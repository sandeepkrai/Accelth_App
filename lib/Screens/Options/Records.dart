import 'dart:convert';

import 'package:accelth/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:accelth/Screens/LabRecords/LabReports.dart';
import '../../models/PatientModel.dart';
import 'package:http/http.dart' as http;
class RecordsPage extends StatefulWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}



class _RecordsPageState extends State<RecordsPage> {
  Future<PatientModel> getPatientApi() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String obtainedEmail = sharedPreferences.getString('Email_id').toString();
    final response = await http.get(Uri.parse(patientUrl+obtainedEmail));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return PatientModel.fromJson(data);
    } else {
      return PatientModel.fromJson(data);
    }
  }
  final List<bool> _onselected = [true,false,false,false,false,false,false];
  List<String> titles = ['Ongoing Treatment','Visits','Hospitalization','Procedures','Medication','Lab','Imaging'];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: getPatientApi(),
            builder: (context,snapshot){
              if (!snapshot.hasData) {
                return SizedBox(
                  height: height*0.3,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              }
              else{
                return Container(
                  color: const Color(0xFFF7FCFF),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back)),
                          Text('Hi ${snapshot.data!.profile!.personal!.name}!',style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                      if(_onselected[0]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                                child: Container(
                                  width: width*0.7,
                                  height: height*0.05,
                                  decoration: BoxDecoration(
                                  border: Border.all(
                                  color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                  Radius.circular(height*0.02)),
                                  color: Colors.white,
                                  ),
                                    child: Row(
                                      children:const [
                                        Expanded(child: Icon(Icons.search)),
                                        Expanded(flex: 4, child: Text('Search History')),
                                      ],
                                    ),
                                ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                 return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.03,
                                  horizontal: width * 0.1),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attachment,
                                        size: 30,
                                        color: Color(0xFF0957DE),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.05),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                'Ongoing Treatment',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: height * 0.008),
                                                child: Text(
                                                  snapshot.data!.ongoingTreatment
                                                      .toString(),
                                                  style: const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height*0.01),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                            child: Icon(Icons.calendar_today)),
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${snapshot.data!.issues![1].date.toString()} | ${snapshot.data!.issues![1].time.toString()}',
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height*0.01),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Icon(FontAwesomeIcons.userDoctor)),
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${snapshot.data!.issues![1].docName}',
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: height*0.01),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Icon(FontAwesomeIcons.hospital)),
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${snapshot.data!.issues![1].hospital}',
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width*0.06,vertical: height*0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  boxShadow: const [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 0.5),
                                    blurRadius: 0.2, spreadRadius: 0.2,
                                  ),],),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: width*0.05),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            radius: 60,
                                          ),
                                        ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: height*0.015,horizontal: width*0.1),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('${snapshot.data!.issues![1].docName}'),
                                            const Text('M.B.B.S, M.D'),
                                            SizedBox(
                                              height: height*0.005,
                                            ),
                                            const Text('OPD Consultation'),
                                            Text('${snapshot.data!.issues![1].hospital}'),
                                            Padding(
                                              padding: EdgeInsets.only(top: height*0.02),
                                              child: GestureDetector(
                                                onTap: (){},
                                                child: Container(
                                                    width: width*0.4,
                                                    height: height*0.04,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color(0xFF0957DE),
                                                        ),
                                                        borderRadius: BorderRadius.all(
                                                            Radius.circular(height*0.02)),
                                                        color: const Color(0xFF0957DE)
                                                    ),
                                                    child: const Center(child: Text('Book Appointment',style: TextStyle(
                                                      color: Colors.white,
                                                    ),))
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Text('Description',style: TextStyle(color: Colors.black,fontSize: height*0.02,fontWeight: FontWeight.w500),),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: width*0.1),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Problem',style: TextStyle(fontWeight: FontWeight.w500,fontSize: height*0.02),),
                                              SizedBox(
                                                height: height*0.01,
                                              ),
                                              Text('${snapshot.data!.issues![1].problem}',style: TextStyle(fontSize: height*0.015,fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Treatment Plan',style: TextStyle(fontWeight: FontWeight.w500,fontSize: height*0.02),),
                                              SizedBox(
                                                height: height*0.01,
                                              ),
                                              Text('${snapshot.data!.issues![1].treatmentPlan}',style: TextStyle(fontSize: height*0.015,fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Diagnosis',style: TextStyle(fontWeight: FontWeight.w500,fontSize: height*0.02),),
                                              SizedBox(
                                                height: height*0.01,
                                              ),
                                              Text('${snapshot.data!.issues![1].diagnosis}',style: TextStyle(fontSize: height*0.015,fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Follow up',style: TextStyle(fontWeight: FontWeight.w500,fontSize: height*0.02),),
                                              SizedBox(
                                                height: height*0.01,
                                              ),
                                              Text('${snapshot.data!.issues![1].followup}',style: TextStyle(fontSize: height*0.015,fontWeight: FontWeight.w300),),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
                              child: Row(
                                children: const [
                                  Text(
                                    'Medications',
                                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height * 0.0001,horizontal: width*0.02),
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: height * 0.25),
                                  itemBuilder: (context, index) {
                                    if (snapshot.data!.medications!.isEmpty) {
                                      return const Center(
                                          child: CircularProgressIndicator(
                                              strokeWidth: 0.3));
                                    } else {
                                      try {
                                        var startDate = snapshot.data!
                                            .medications![index].startDate
                                            .toString()
                                            .split('/')[0]
                                            .toString();
                                        var endDate = snapshot
                                            .data!.medications![index].endDate
                                            .toString()
                                            .split('/')[0]
                                            .toString();
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.01,
                                              horizontal: width * 0.002),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                Alignment.topCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topRight: Radius.circular(width * 0.05),topLeft: Radius.circular(width * 0.05)),
                                                      color:
                                                      const Color(0xFF0957DE),
                                                  ),
                                                  height: height * 0.08,
                                                  width: width * 0.43,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal:
                                                                    width *
                                                                        0.06,
                                                                    vertical: height *
                                                                        0.008),
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .medications![
                                                                  index]
                                                                      .name
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize: height *
                                                                          0.015,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                Alignment.bottomCenter,
                                                child: Container(
                                                  height: height * 0.18,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xFFF7FCFF),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          offset: Offset(1, 1),
                                                          blurRadius: 1,
                                                          spreadRadius: 0.5,
                                                        ), //BoxShadow
                                                      ],
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(height*0.02))
                                                  ),
                                                  width: width * 0.43,
                                                  child: Padding(
                                                    padding: EdgeInsets
                                                        .symmetric(
                                                        vertical:
                                                        height *
                                                            0.01,
                                                        horizontal:
                                                        width *
                                                            0.04),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(Icons
                                                                .calendar_today),
                                                            Text('  $startDate Oct - $endDate Oct'),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(Icons
                                                                .chat_bubble_outline_outlined),
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(
                                                                      8.0),
                                                                  child: Text(snapshot.data!.medications![index].mealPlan!.dose1.toString()),
                                                                ),
                                                                Text(snapshot.data!.medications![index].mealPlan!.dose2.toString()),
                                                                snapshot.data!.medications![index].mealPlan!.dose3.toString() != 'null'
                                                                    ? Padding(
                                                                  padding:
                                                                  const EdgeInsets.all(8.0),
                                                                  child: Text(snapshot.data!.medications![index].mealPlan!.dose3.toString()),
                                                                )
                                                                    : const Text(''),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } catch (e) {
                                        return const CircularProgressIndicator();
                                      }
                                    }
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
                                      child: Row(
                                        children: const [
                                          Text(
                                            'Recovery',
                                            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: width*0.03),
                                          child: Container(
                                              width: width*0.4,
                                              height: height*0.04,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(height*0.02)),
                                                  color: Colors.white
                                              ),
                                              child: Center(child: Text('Expected: ${snapshot.data!.issues![1].recovery!.expected}',style: const TextStyle(
                                                color: Colors.black,
                                              ),))
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: width*0.03),
                                          child: Container(
                                              width: width*0.4,
                                              height: height*0.04,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(height*0.02)),
                                                  color: Colors.white
                                              ),
                                              child: Center(child: Text('Actual: ${snapshot.data!.issues![1].recovery!.actual}',style: const TextStyle(
                                                color: Colors.black,
                                              ),))
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width*0.05,vertical: height*0.01),
                                    child: Row(
                                      children: const [
                                        Text(
                                          'Linked Documents',
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                    child: Container(
                                        width: width*0.9,
                                        height: height*0.06,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: width*0.002,
                                              color: const Color(0xFF0957DE)
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height*0.02)),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: width*0.04),
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(FontAwesomeIcons.squarePollHorizontal,size: height*0.03,color: const Color(0xFF0957DE),),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: const [
                                                              Text('Lab Reports',style: TextStyle(fontSize: 20),),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LabReportsPage()));
                                                },
                                                child: Container(
                                                  height: height*0.0745,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                    color: const Color(0xFF0957DE).withOpacity(0.1),
                                                  ),
                                                  child: const Center(
                                                    child: Text('View',style: TextStyle(
                                                      color: Color(0xFF0957DE),
                                                      fontSize: 18,
                                                    ),),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                    child: Container(
                                        width: width*0.9,
                                        height: height*0.06,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: width*0.002,
                                              color: const Color(0xFF0957DE)
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height*0.02)),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Padding(
                                                padding: EdgeInsets.only(left: width*0.04),
                                                child: Container(
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(FontAwesomeIcons.indianRupeeSign,size: height*0.03,color: const Color(0xFF0957DE),),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: const [
                                                              Text('Transactions',style: TextStyle(fontSize: 20),),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: height*0.0745,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                                  color: const Color(0xFF0957DE).withOpacity(0.1),
                                                ),
                                                child: const Center(
                                                  child: Text('View',style: TextStyle(
                                                    color: Color(0xFF0957DE),
                                                    fontSize: 18,
                                                  ),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],),
                      if(_onselected[1]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                              child: Container(
                                width: width*0.7,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children:const [
                                    Expanded(child: Icon(Icons.search)),
                                    Expanded(flex: 4, child: Text('Search History')),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i] = false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],),
                      if(_onselected[2]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                              child: Container(
                                width: width*0.7,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children:const [
                                    Expanded(child: Icon(Icons.search)),
                                    Expanded(flex: 4, child: Text('Search History')),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          ],),
                      if(_onselected[3]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                              child: Container(
                                width: width*0.7,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children:const [
                                    Expanded(child: Icon(Icons.search)),
                                    Expanded(flex: 4, child: Text('Search History')),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          ],),
                      if(_onselected[4]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                              child: Container(
                                width: width*0.7,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children:const [
                                    Expanded(child: Icon(Icons.search)),
                                    Expanded(flex: 4, child: Text('Search History')),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          ],),
                      if(_onselected[5]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                              child: Container(
                                width: width*0.7,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children:const [
                                    Expanded(child: Icon(Icons.search)),
                                    Expanded(flex: 4, child: Text('Search History')),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          ],),
                      if(_onselected[6]==true)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.01),
                              child: Container(
                                width: width*0.7,
                                height: height*0.05,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3)
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children:const [
                                    Expanded(child: Icon(Icons.search)),
                                    Expanded(flex: 4, child: Text('Search History')),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height*0.06,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _onselected.length,
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                itemBuilder: (context,index){
                                  return Padding(
                                    padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          for(int i=0; i<_onselected.length; i++){
                                            if(i==index) {
                                              _onselected[i]=true;
                                            } else {
                                              _onselected[i]=false;
                                            }
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: width*0.4,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFF0957DE),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(height*0.02)),
                                            color: _onselected[index]==true? const Color(0xFF0957DE): Colors.white,
                                          ),
                                          child: Center(child: Text(titles[index],style: TextStyle(
                                            color: _onselected[index]==true? Colors.white: const Color(0xFF0957DE),
                                          ),))
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          ],),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

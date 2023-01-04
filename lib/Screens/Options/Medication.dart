import 'dart:convert';

import 'package:accelth/Screens/Medicine/ItemMedicine.dart';
import 'package:accelth/models/MedicalItem.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../models/PatientModel.dart';


class MedicationsPage extends StatefulWidget {
  const MedicationsPage({Key? key}) : super(key: key);

  @override
  State<MedicationsPage> createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<MedicationsPage> {
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

  List<MedicalItem> medicalitemlist = [];

  Future<List<MedicalItem>> getMedicalList() async{
    final response = await http.get(Uri.parse(getMedicalitems));
    var data = jsonDecode(response.body.toString());
      if(response.statusCode==200){
        for(Map<String,dynamic> i in data){
          medicalitemlist.add(MedicalItem.fromJson(i));
        }
        return medicalitemlist;
      }else{
        return medicalitemlist;
      }
  }

  bool _buyMedicines = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF7FCFF),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back)),
                  const Text('Medications',style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.03),
                      child: Container(
                        height: height*0.04,
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
                            Expanded(flex: 4, child: Text('Search')),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _buyMedicines = true;
                          });
                        },
                        child: Container(
                            height: height*0.04,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF0957DE),
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(height*0.02)),
                              color: Colors.white,
                            ),
                            child: const Center(child: Text('Buy Medicines Online',style: TextStyle(
                              color: const Color(0xFF0957DE),
                            ),))
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!_buyMedicines) Expanded(
                child: FutureBuilder(
                    future: getPatientApi(),
                    builder: (context,snapshot)
                    {
                      if(!snapshot.hasData){
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
                        return
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
                                  mainAxisExtent: height * 0.22),
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
                                              height: height * 0.06,
                                              width: width * 0.43,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceEvenly,
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
                                              height: height * 0.15,
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
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: CircleAvatar(
                                              backgroundColor: Color(0xFF0957DE),
                                              child: Icon(FontAwesomeIcons.bell,color: Colors.white,),
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
                        );
                      }
                    }
                ),
              ) else Expanded(
                  child: FutureBuilder(
                    future: getMedicalList(),
                    builder: (context, snapshot){
                      if(!snapshot.hasData){
                        return SizedBox(
                          height: height*0.5,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                            ),
                          ),
                        );
                      }
                      else{
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: medicalitemlist.length,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemMedicines(ItemID: medicalitemlist[index].itemID.toString())));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.03,right: width*0.03),
                                  child: Container(
                                      height: height*0.06,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFF0957DE),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height*0.02)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: width*0.04),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Icon(FontAwesomeIcons.tablets,color: Color(0xFF0957DE),)),
                                            Expanded(
                                              flex: 5,
                                                child: Text(medicalitemlist[index].medName.toString(),style: TextStyle(color: Colors.black,fontSize: height*0.018),)),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  )
              ),
              SizedBox(
                width: width*0.6,
                height: height*0.05,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0957DE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),),
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Text("Share"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

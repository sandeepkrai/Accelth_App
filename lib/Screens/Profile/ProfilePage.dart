import 'dart:convert';

import 'package:accelth/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../models/PatientModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
   int _onselected = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getPatientApi(),
          builder: (context,snapshot){
            if (!snapshot.hasData) {
              return SizedBox(
                height: height * 0.3,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            }else{
              return Container(
                color: const Color(0xFFF7FCFF),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back)),
                          Text(snapshot.data!.profile!.personal!.name.toString(),style: const TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
                        child: Row(
                          children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.01),
                                  child: Container(
                                    height: height*0.04,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF0957DE)
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height*0.02)),
                                      color: _onselected == 0 ? const Color(0xFF0957DE): Colors.white,
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _onselected = 0;
                                        });
                                      },
                                        child:  Center(
                                            child: Text('Personal',
                                              style: TextStyle(
                                                color: _onselected == 0? Colors.white: const Color(0xFF0957DE)
                                              ),
                                            ),
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.01),
                                child: Container(
                                  height: height*0.04,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF0957DE)
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height*0.02)),
                                    color: _onselected == 1 ? const Color(0xFF0957DE): Colors.white,
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _onselected = 1;
                                      });
                                    },
                                    child: Center(
                                      child: Text('Medical',
                                        style: TextStyle(
                                            color: _onselected == 1? Colors.white: const Color(0xFF0957DE)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.01),
                                child: Container(
                                  height: height*0.04,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF0957DE),
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height*0.02)),
                                    color: _onselected == 2 ? const Color(0xFF0957DE): Colors.white,
                                  ),
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _onselected = 2;
                                      });
                                    },
                                    child: Center(
                                      child: Text('Lifestyle',
                                        style: TextStyle(
                                            color: _onselected == 2? Colors.white: const Color(0xFF0957DE)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if(_onselected == 0)
                      Expanded(
                        flex: 11,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: width*0.06),
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
                                        flex: 1,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: width*0.01),
                                          child: const CircleAvatar(
                                            backgroundImage: NetworkImage('https://dronaid.in/images/team/Prathmesh-Sinha_22-23_App-Head.jpg',
                                            ),
                                            radius: 70,
                                          ),
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: width*0.1),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text('Name'),
                                            Text('Mr. ${snapshot.data!.profile!.personal!.name} Sinha'),
                                            SizedBox(
                                              height: height*0.005,
                                            ),
                                            const Text('Contact Number'),
                                            Text('+91-${snapshot.data!.profile!.personal!.contactNumber}')
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: height*0.02),
                              child: SizedBox(
                                width: width*0.9,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Email id'),
                                        Text('${snapshot.data!.profile!.personal!.emailId}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black, thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Gender'),
                                        Text('${snapshot.data!.profile!.personal!.gender}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Date of birth'),
                                        Text('${snapshot.data!.profile!.personal!.dateofBirth}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Blood group'),
                                        Text('${snapshot.data!.profile!.personal!.bloodgroup}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Maritial Status'),
                                        Text('${snapshot.data!.profile!.personal!.maritialStatus}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Height'),
                                        Text('${snapshot.data!.profile!.personal!.height} cm')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Weight'),
                                        Text('${snapshot.data!.profile!.personal!.weight} kgs')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Emergency contact'),
                                        Text('+91-${snapshot.data!.profile!.personal!.emergencyContact}')
                                      ],
                                    ),
                                    SizedBox(
                                      height: height*0.02,
                                      width: width*0.9,
                                      child: const Divider(
                                        color: Colors.black,
                                        thickness: 0.8,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text('Address: ${snapshot.data!.profile!.personal!.address}'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if(_onselected==1)
                      Expanded(
                        flex: 11,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height*0.02),
                          child: SizedBox(
                            width: width*0.9,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Allergies'),
                                    Text('${snapshot.data!.profile!.medical!.allergies}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black, thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Vaccination'),
                                    Text('${snapshot.data!.profile!.medical!.vaccination}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Current Medication'),
                                    snapshot.data!.profile!.medical!.currectMedications.toString() == 'null'?
                                    const Text('add current medications'):
                                    Text('${snapshot.data!.profile!.medical!.currectMedications}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Chronic Diseases'),
                                    snapshot.data!.profile!.medical!.chronicDiseases.toString() == 'null'?
                                    const Text('add chronic diseases'):
                                    Text('${snapshot.data!.profile!.medical!.chronicDiseases}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Injuries'),
                                    snapshot.data!.profile!.medical!.injuries.toString() == 'null'?
                                    const Text('add injuries'):
                                    Text('${snapshot.data!.profile!.medical!.injuries}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Surgeries'),
                                    snapshot.data!.profile!.medical!.surgeries.toString() == 'null'?
                                    const Text('add surgeries'):
                                    Text('${snapshot.data!.profile!.medical!.surgeries}')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if(_onselected==2)
                      Expanded(
                        flex: 11,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height*0.02),
                          child: SizedBox(
                            width: width*0.9,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Smoking Habits'),
                                    Text('${snapshot.data!.profile!.lifestyle!.smoking}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black, thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Alcohol Consumption'),
                                    Text('${snapshot.data!.profile!.lifestyle!.alcohol}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Activity level'),
                                    Text('${snapshot.data!.profile!.lifestyle!.activity}')
                                  ],
                                ),
                                SizedBox(
                                  height: height*0.02,
                                  width: width*0.9,
                                  child: const Divider(
                                    color: Colors.black,
                                    thickness: 0.8,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Food Preference'),
                                    Text('${snapshot.data!.profile!.lifestyle!.foodPreference}')
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: width*0.05),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0957DE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text("Edit Profile"),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

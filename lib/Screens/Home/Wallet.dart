import 'dart:convert';
import 'package:accelth/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../models/PatientModel.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

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
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0957DE),
          borderRadius: BorderRadius.all(
              Radius.circular(height*0.01)),
        ),
        child: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          color: Colors.white,
          icon: const Icon(Icons.home),
        ),
      ),
      backgroundColor: Colors.white,
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
                  const Text('Wallet',style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w500
                  ),),
                ],
              ),
              FutureBuilder(
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
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.01),
                        child: Stack(
                          children: [
                            Container(
                              height: height*0.38,
                              width: double.infinity,
                              alignment: Alignment.topCenter,
                              child: Image.network('https://img.freepik.com/free-vector/gold-coin-seamless-pattern-background-money-vector-finance-illustration_53876-136818.jpg?w=1060&t=st=1670557934~exp=1670558534~hmac=28306b9eebebae25d327dfed9a2e3c8c8d4761c5afcbc1ea159a6a6bbd85881c',),
                            ),
                            Positioned(
                              bottom: 1,
                              left: width*0.35,
                              child: Column(
                                children: [
                                  const Text('My Balance',style: TextStyle(color: Color(0xFF0957DE),fontSize: 25,fontWeight: FontWeight.w500),),
                                  Text(snapshot.data!.walletBalance.toString(),style: const TextStyle(color: Color(0xFF0957DE),fontSize: 25,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                 },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.03),
                child: Row(
                  children: [
                    const Expanded(
                        child:
                        Text('Accelth rewards you with coins everytime you make a transaction with your app',
                        style: TextStyle(
                          wordSpacing: 1.75,
                          letterSpacing: 0.02,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height*0.01),
                child: Column(
                  children: [
                    Container(
                      width: width*0.9,
                      height: height*0.05,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF0957DE)
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(height*0.02)),
                        color: Colors.white,
                      ),
                      child: const Center(child: Text('Earn on all the transactions!')),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height*0.01),
                      child: Container(
                        width: width*0.9,
                        height: height*0.05,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF0957DE)
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(height*0.02)),
                          color: Colors.white,
                        ),
                        child: const Center(child: Text('Earn on all the transactions!')),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height*0.005),
                      child: Container(
                        width: width*0.9,
                        height: height*0.05,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xFF0957DE)
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(height*0.02)),
                          color: Colors.white,
                        ),
                        child: const Center(child: Text('Earn on all the transactions!')),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

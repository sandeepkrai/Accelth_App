import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../models/PatientModel.dart';
import 'package:http/http.dart' as http;

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  Future<PatientModel> getPatientApi() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String obtainedEmail = sharedPreferences.getString('Email_id').toString();
    final response = await http.get(Uri.parse('$patientUrl$obtainedEmail'));
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
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: height,
            color: const Color(0xFFF7FCFF),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back)),
                    const Text('Your Orders',style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),),
                  ],
                ),
                FutureBuilder(
                  future: getPatientApi(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(strokeWidth: 2.0,),);
                      }else{
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.orders!.length,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.015),
                                child: Container(
                                    width: width*0.9,
                                    height: height*0.09,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: width*0.004,
                                        color: Colors.black.withOpacity(0.1)
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height*0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            color: Color(0xFFF7FCFF).withOpacity(0.5),
                                            child: Padding(
                                              padding: EdgeInsets.only(top: height*0.01,left: width*0.04,bottom: height*0.01),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text('${snapshot.data!.orders![index].orderID}',style: TextStyle(fontSize: 15),),
                                                  Text('${snapshot.data!.orders![index].date} | ${snapshot.data!.orders![index].time}',style: TextStyle(fontSize: 14),),
                                                  GestureDetector(
                                                    onTap: (){

                                                    },child: Text('View Order Details',style: TextStyle(color: Color(0xFF0957DE),fontSize: 14) ,)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: height*0.0945,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                              color: const Color(0xFF0957DE)
                                            ),
                                            child: Center(
                                              child: Text('Track Order',style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              );
                            }
                        );
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

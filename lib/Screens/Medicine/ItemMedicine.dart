import 'dart:convert';

import 'package:accelth/models/MedicineModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';


class ItemMedicines extends StatefulWidget {
  final String ItemID;
  const ItemMedicines({Key? key,required this.ItemID}) : super(key: key);
  @override
  State<ItemMedicines> createState() => _ItemMedicinesState();
}

class _ItemMedicinesState extends State<ItemMedicines> {
  Future<MedicineModel> getMedicineData() async {
    final response = await http.get(Uri.parse('$getasingleMedicine/${widget.ItemID}'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return MedicineModel.fromJson(data);
    } else {
      return MedicineModel.fromJson(data);
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
            color: const Color(0xFFF7FCFF),
            child: FutureBuilder(
              future: getMedicineData(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return SizedBox(
                    height: height*0.5,
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                      ),
                    ),
                  );
                }else{
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back)),
                          Text(snapshot.data!.medName.toString(),style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500
                          ),),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Manufactured By: ${snapshot.data!.manufacture}',style: TextStyle(fontWeight: FontWeight.w500),),
                            Text('Contains: ${snapshot.data!.contains}',style: TextStyle(fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description',style: TextStyle(fontWeight: FontWeight.w500),),
                            SizedBox(
                              height: height*0.004,
                            ),
                            Text('${snapshot.data!.description}',
                              style: TextStyle(fontWeight: FontWeight.w400,wordSpacing: width*0.01),

                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                              });
                            },
                            child: Container(
                                height: height*0.04,
                                width: width*0.5,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1, 1),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: const Color(0xFF0957DE),
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.01)),
                                  color: Colors.white,
                                ),
                                child: const Center(child: Text('Add to Cart',style: TextStyle(
                                  color: const Color(0xFF0957DE),
                                ),))
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: height*0.01,horizontal: width*0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Substitutes',style: TextStyle(fontWeight: FontWeight.w500,fontSize: height*0.016),),
                              ),
                              SizedBox(
                                height: height*0.01,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.substitutes!.length,
                                  itemBuilder: (context,index){
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${snapshot.data!.substitutes![index].subMedName}',style: TextStyle(fontWeight: FontWeight.w300),),
                                );
                              }
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                            });
                          },
                          child: Container(
                              height: height*0.05,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0957DE),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height*0.01)),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Side effects',style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.w400,fontSize: height*0.016
                                    ),),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                            });
                          },
                          child: Container(
                              height: height*0.05,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0957DE),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height*0.01)),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Uses',style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.w400,fontSize: height*0.016
                                    ),),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                            });
                          },
                          child: Container(
                              height: height*0.05,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0957DE),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height*0.01)),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Concerns',style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.w400,fontSize: height*0.016
                                    ),),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                            });
                          },
                          child: Container(
                              height: height*0.05,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0957DE),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height*0.01)),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Warnings',style: TextStyle(
                                      color: Colors.black,fontWeight: FontWeight.w400,fontSize: height*0.016
                                    ),),
                                  ),
                                ],
                              )
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            ),
          ),
        ),
      ),
    );
  }
}

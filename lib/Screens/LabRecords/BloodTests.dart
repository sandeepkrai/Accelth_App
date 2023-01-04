import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../models/PatientModel.dart';

class BloodTestsPage extends StatefulWidget {
  final int index;
  const BloodTestsPage({required this.index, Key? key}) : super(key: key);

  @override
  State<BloodTestsPage> createState() => _BloodTestsPageState();
}

class _BloodTestsPageState extends State<BloodTestsPage> {
  List<bool> _onselected = [false, false, false, false, false];
  List<String> titles = ['CBC', 'BMP', 'CMP', 'TP', 'LP'];
  List<String> units = ['x10E3/uL','x10E6/uL','gm/dL','%', 'fL', '%','mg/dL','mmol/L','g/dL','U/L','ug/dL','ng/dL','uIU/ml','pg/ml'];
  Future<PatientModel> getPatientApi() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String obtainedEmail = sharedPreferences.getString('Email_id').toString();
    final response = await http.get(Uri.parse(patientUrl + obtainedEmail));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return PatientModel.fromJson(data);
    } else {
      return PatientModel.fromJson(data);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _onselected[widget.index] = true;
    });
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
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back)),
                    const Text(
                      'Blood Tests',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.06,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _onselected.length,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02,
                            left: width * 0.02,
                            right: width * 0.01),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              for (int i = 0; i < _onselected.length; i++) {
                                if (i == index) {
                                  _onselected[i] = true;
                                } else {
                                  _onselected[i] = false;
                                }
                              }
                            });
                          },
                          child: Container(
                              width: width * 0.2,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF0957DE),
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(height * 0.02)),
                                color: _onselected[index] == true
                                    ? const Color(0xFF0957DE)
                                    : Colors.white,
                              ),
                              child: Center(
                                  child: Text(
                                titles[index],
                                style: TextStyle(
                                  color: _onselected[index] == true
                                      ? Colors.white
                                      : const Color(0xFF0957DE),
                                ),
                              ))),
                        ),
                      );
                    },
                  ),
                ),
                FutureBuilder(
                    future: getPatientApi(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox(
                          height: height * 0.3,
                          child: const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                        );
                      } else {
                        if (_onselected[0] == true) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'WBC',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.wBC}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[0],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'RBC',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.rBC}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[1],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Haemoglobin',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.haemoglobin!.avgResult}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[2],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Haematocrit',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.haematocrit}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'MCV',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.mCV}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[4],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'MCHC',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.mCHC}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[2],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'RDW',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.rDW}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Platelets',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.platelets}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[0],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Neutrophils',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.neutrophils}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Lymphs',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.lymphs}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Monocytes',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.monocytes}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'EOS',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.eOS}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Basos',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.cBC!.basos}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        }
                        if (_onselected[1] == true) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Glucose',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.glucose!.avgResult}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[6],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Urea Nitrogen',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.ureaNitrogen}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[6],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Creatnine',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.creatine}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[2],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Sodium',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.sodium}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Potassium',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.potassium}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Chlorine',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.chlorine}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Carbon Dioxide',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.carbonDioxide}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Calcium',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.basicMetabolicPanel!.calcium}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[6],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        }
                        if (_onselected[2] == true) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Urea Nitrogen',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.ureaNitrogen!.avgResult}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[6],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Creatnine',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.creatine}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[2],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Sodium',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.sodium}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Potassium',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.potassium}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Chlorine',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.chlorine}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Carbon Dioxide',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.carbonDioxide}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[7],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Calcium',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.calcium}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[6],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Protein',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.protein}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[8],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Albumin',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.albumin}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[8],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Globulin',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.globulin}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[8],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'A/G Ratio',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.aGRatio}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[8],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Bilirubin',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.bilirubin}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[6],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Alkaline \nPhosphate',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.alkalinePhosphate}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[9],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'AST',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.aST}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[9],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'ALT',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.comprehensiveMetabolicPanel!.aLT}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[9],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        }
                        if (_onselected[3] == true) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Thyroxine (T4)',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.thyroidPanel!.thyroxine!.avgResult}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[10],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'T3 Uptake',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.thyroidPanel!.t3Uptake}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[3],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Free Thyroxine Index',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.thyroidPanel!.freeThyroxineIndex}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Thyroxine T4 Free,Direct',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.thyroidPanel!.thyroxineT4FreeDirect}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[11],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'TSH',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.thyroidPanel!.tSH}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[12],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.02,
                                    left: width * 0.02,
                                    right: width * 0.01),
                                child: Container(
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.transparent,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.02)),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.04),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              flex: 3,
                                              child: Text(
                                                'Triiodothyronine Free Serum',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                '${snapshot.data!.labReports!.bloodTests!.thyroidPanel!.triiodothyronineFreeSerum}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              )),
                                          Expanded(
                                              flex: 2,
                                              child: Text(
                                                units[13],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: height * 0.018),
                                              ))
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.02,
                                  right: width * 0.01),
                              child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.02)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Total Cholesterol',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${snapshot.data!.labReports!.bloodTests!.lipidPanel!.totalCholesterol!.avgResult}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              units[6],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.02,
                                  right: width * 0.01),
                              child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.02)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Triglycerides',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${snapshot.data!.labReports!.bloodTests!.lipidPanel!.triglycerides}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              units[6],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.02,
                                  right: width * 0.01),
                              child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.02)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'HDL Cholesterol',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${snapshot.data!.labReports!.bloodTests!.lipidPanel!.hDLCholesterol}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              units[6],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.02,
                                  right: width * 0.01),
                              child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.02)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'LDL Cholesterol',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${snapshot.data!.labReports!.bloodTests!.lipidPanel!.lDLCholesterol}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              units[6],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.02,
                                  right: width * 0.01),
                              child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.02)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'LDL/HDL Ratio',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${snapshot.data!.labReports!.bloodTests!.lipidPanel!.lDLHDLRatio}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              units[6],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.02,
                                  left: width * 0.02,
                                  right: width * 0.01),
                              child: Container(
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.02)),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            flex: 3,
                                            child: Text(
                                              'Total CHOL/HDL',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              '${snapshot.data!.labReports!.bloodTests!.lipidPanel!.totalCHOLHDL}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              units[6],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: height * 0.018),
                                            ))
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        );
                      }
                    }),
                SizedBox(height: height * 0.1),
                SizedBox(
                  width: width * 0.6,
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0957DE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text("Share"),
                  ),
                ),
                SizedBox(height: height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

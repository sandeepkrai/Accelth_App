import 'package:accelth/Screens/LabRecords/BloodTests.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LabReportsPage extends StatefulWidget {
  const LabReportsPage({Key? key}) : super(key: key);

  @override
  State<LabReportsPage> createState() => _LabReportsPageState();
}

class _LabReportsPageState extends State<LabReportsPage> {

  String _dropdownValue = 'Diagnostic Tests';

  void dropdownCallback (String? selectedValue){
    if(selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    List<String> dropdownitems = [
      'Diagnostic Tests',
      'Blood Tests',
    ];
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
                  const Text('Lab Reports',style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                  ),),
                ],
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: width*0.7,
                  height: height*0.06,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: width*0.003,
                        color: Color(0xFF0957DE),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: width*0.04,right: width*0.04),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                          items: dropdownitems.map<DropdownMenuItem<String>>((String value)
                          {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: height*0.02),
                                ),
                            );
                          }).toList(),
                          borderRadius: BorderRadius.all(
                              Radius.circular(height*0.02)),
                          value: _dropdownValue,
                          onChanged: dropdownCallback,
                        iconEnabledColor: const Color(0xFF0957DE),
                      ),
                    ),
                  ),
                ),
              ),
              if(_dropdownValue == 'Diagnostic Tests')
                Expanded(
                child: Column(
                  children: [
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.squarePollHorizontal,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('COVID-19 Report',style: TextStyle(fontSize: 18),),
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
                                      color: Colors.black,
                                      fontSize: 18,
                                    ),),
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.squarePollHorizontal,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('Dengue Report',style: TextStyle(fontSize: 18),),
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
                                      color: Colors.black,
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
              if(_dropdownValue == 'Blood Tests')
                Expanded(
                child: Column(
                  children: [
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.monitor_heart_outlined,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('CBC',style: TextStyle(fontSize: 18),),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodTestsPage(index: 0)));
                                  },
                                  child: Container(
                                    height: height*0.0745,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                      color: const Color(0xFF0957DE).withOpacity(0.1),
                                    ),
                                    child: const Center(
                                      child: Text('View',style: TextStyle(
                                        color: Colors.black,
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.monitor_heart_outlined,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('Basic Metabolic Panel',style: TextStyle(fontSize: 18),),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodTestsPage(index: 1)));
                                  },
                                  child: Container(
                                    height: height*0.0745,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                      color: const Color(0xFF0957DE).withOpacity(0.1),
                                    ),
                                    child: const Center(
                                      child: Text('View',style: TextStyle(
                                        color: Colors.black,
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.monitor_heart_outlined,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('Comprehensive MP',style: TextStyle(fontSize: 18),),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodTestsPage(index: 2)));
                                  },
                                  child: Container(
                                    height: height*0.0745,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                      color: const Color(0xFF0957DE).withOpacity(0.1),
                                    ),
                                    child: const Center(
                                      child: Text('View',style: TextStyle(
                                        color: Colors.black,
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.monitor_heart_outlined,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('Thyroid Panel',style: TextStyle(fontSize: 18),),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodTestsPage(index: 3)));
                                  },
                                  child: Container(
                                    height: height*0.0745,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                      color: const Color(0xFF0957DE).withOpacity(0.1),
                                    ),
                                    child: const Center(
                                      child: Text('View',style: TextStyle(
                                        color: Colors.black,
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
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(left: width*0.04),
                                  child: Container(
                                    color: Colors.white,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.monitor_heart_outlined,size: height*0.025,),
                                          Padding(
                                            padding: EdgeInsets.only(left: width*0.03,top: height*0.001),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text('Lipid Panel',style: TextStyle(fontSize: 18),),
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BloodTestsPage(index: 4)));
                                  },
                                  child: Container(
                                    height: height*0.0745,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(height * 0.01),bottomRight: Radius.circular(height * 0.01)),
                                      color: const Color(0xFF0957DE).withOpacity(0.1),
                                    ),
                                    child: const Center(
                                      child: Text('View',style: TextStyle(
                                        color: Colors.black,
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
                  ],
                ),
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

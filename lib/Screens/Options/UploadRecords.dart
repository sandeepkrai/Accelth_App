import 'package:accelth/Screens/UploadRecords/Consent.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<String> defaultText= ["Enter DD/MM/YYYY", "Select the type of document"];
  List<String> documentType=["Prescription", "Lab Reports", "Imaging"];
  final _dateController=TextEditingController();
  DateTime? _date;
  BoxDecoration bd=BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black.withOpacity(0.3) , width: 1,));
  String? tod;
  void _showDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1980), lastDate: DateTime(2025)).then((value) {setState(() {
      _date=value;
    });});
  }
  int f=1;
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
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back)),
                    Text("Upload Records", style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ),
                SizedBox(
                  height: height*0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  child: Text("Manually upload your medical documents (prescriptions, lab reports, imaging) and access them easily with timeline.",
                    style: TextStyle(fontSize: width*0.047, fontWeight: FontWeight.w400 ),
                  ),
                ),
                SizedBox(height:height*0.03,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  child: Text("Date of the visit",
                      style: TextStyle(fontSize: width*0.05, fontWeight: FontWeight.w400 )),),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  padding: EdgeInsets.symmetric(horizontal: width*0.02),
                  decoration: bd,
                  child: ElevatedButton(onPressed: _showDatePicker,

                    child: Row(

                      children: [
                        Icon(Icons.calendar_month, color: _date.toString()!="null"?Colors.black:Color.fromRGBO(0, 0, 0, 0.6)),
                        SizedBox(width: width*0.04,),
                        (_date.toString()!="null")?
                        Text(_date!.day.toString()+"/"+_date!.month.toString()+"/"+_date!.year.toString(),style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),):
                        Text(defaultText[0], style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6), fontWeight: FontWeight.normal),),
                      ],
                    ),

                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        elevation: MaterialStateProperty.all<double>(0),
                        padding: MaterialStateProperty.all(EdgeInsets.all(0))
                    ),

                  ),

                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.02),
                  margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  child: (f==0)?Text("Enter date!!",style: TextStyle(color: Colors.red, fontSize: width*0.04, fontWeight: FontWeight.w600),):Text(""),
                ),

                SizedBox(height: height*0.025,),

                Container(margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  child: Text("Type of Document", style: TextStyle(fontSize: width*0.05, fontWeight: FontWeight.w400 )),),
                SizedBox(height: height*0.01,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  padding: EdgeInsets.symmetric(horizontal: width*0.02),
                  decoration: bd,

                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(defaultText[1]),
                      isExpanded: true,

                      value: tod,
                      onChanged: (value){
                        setState(() {
                          tod=value;
                        });
                      },
                      items: documentType.map((value)  {
                        return DropdownMenuItem(value:value, child: Text(value),);
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: width*0.02),
                  margin: EdgeInsets.symmetric(horizontal: width*0.03),
                  child: (f==0)?Text("Select a type of document!!",style: TextStyle(color: Colors.red, fontSize: width*0.04, fontWeight: FontWeight.w600),):Text(""),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin:  EdgeInsets.symmetric(vertical:height*0.05,horizontal: width*0.03),
                      width: width*0.6,

                      child: ElevatedButton(
                        onPressed: (_date.toString()!="null" && tod.toString()!="null")?
                            (){setState(() {f=1;});  Navigator.push(context, MaterialPageRoute(builder: (context) => consentForm())); }:
                            (){setState(() {f=0;});},
                        child:  Text('Upload ',style: TextStyle(fontSize: width*0.04),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Color(0xff0957DE)),
                            padding: MaterialStateProperty.all(EdgeInsets.all(height*0.017)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            elevation: MaterialStateProperty.all(05)
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),

          ),
        ),
      ),
    );
  }
}
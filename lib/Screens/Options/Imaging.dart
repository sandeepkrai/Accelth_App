import 'package:flutter/material.dart';


class ImagingPage extends StatefulWidget {
  const ImagingPage({Key? key}) : super(key: key);

  @override
  State<ImagingPage> createState() => _ImagingPageState();
}

class _ImagingPageState extends State<ImagingPage> {
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
                  const Text('Imaging',style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}

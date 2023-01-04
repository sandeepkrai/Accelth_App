import 'package:flutter/material.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  List<String> firstaids = [
    'Abdominal Pain',
    'Angina(Chest pain)',
    'Animal Bite',
    'Asthma/Attack',
    'Bleeding',
    'Burns',
    'Choking',
    'Convulsions',
    'Diarrhea',
    'Electric shock',
    'Eye injury',
    'Fainting',
    'Fever',
    'Head Injury',
    'Nose Bleed',
    'Poisoning',
    'Snake Bite',
    'Sprain/Strain',
    'Stroke',
    'Vomiting'
  ];
  final List<bool> _onselectedPage = [true,false];
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
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back)),
                    const Text('Emergency',style: TextStyle(
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
                        padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _onselectedPage[0]=true;
                              _onselectedPage[1]=false;
                            });
                          },
                          child: Container(
                              width: width*0.3,
                              height: height*0.04,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF0957DE),
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: _onselectedPage[0]==true ? const Color(0xFF0957DE): Colors.white,
                              ),
                              child: Center(child: Text('Call Ambulance',style: TextStyle(
                                color: _onselectedPage[0]==true ? Colors.white: const Color(0xFF0957DE),
                              ),))
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
                              _onselectedPage[1]=true;
                              _onselectedPage[0]=false;
                            });
                          },
                          child: Container(
                              width: width*0.3,
                              height: height*0.04,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFF0957DE),
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(height*0.02)),
                                  color: _onselectedPage[1]==true ? const Color(0xFF0957DE): Colors.white,
                              ),
                              child: Center(child: Text('First Aid',style: TextStyle(
                                color: _onselectedPage[1]==true ? Colors.white: const Color(0xFF0957DE),
                              ),))
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                if(_onselectedPage[0]==true)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height*0.02,horizontal: width*0.03),
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                          width: width*0.9,
                          height: height*0.14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(height*0.01)),
                            color: Colors.red,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Icon(Icons.phone_forwarded_rounded,size: height*0.08,color: Colors.white,)),
                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width*0.08),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Call Ambulance',style: TextStyle(color: Colors.white,fontSize: height*0.03),),
                                      Text('Tap here to dial 112',style: TextStyle(color: Colors.white.withOpacity(0.9),fontSize: height*0.02)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                  ),
                if(_onselectedPage[1]==true)
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
                              Expanded(flex: 4, child: Text('Search')),
                            ],
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: firstaids.length,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: EdgeInsets.only(top: height*0.02,left: width*0.02,right: width*0.01),
                            child: GestureDetector(
                              onTap: (){

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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(firstaids[index],style: TextStyle(color: Colors.black,fontSize: height*0.018),),
                                          const Icon(Icons.arrow_right_sharp)
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      )
    );
  }
}

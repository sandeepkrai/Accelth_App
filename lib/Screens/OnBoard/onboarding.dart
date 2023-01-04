import 'package:accelth/Screens/auth/signup.dart';
import 'package:accelth/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/slider_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  late PageController _controller;
  bool showOnBoarding = true;
  bool showgetStarted = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return showOnBoarding == false
        ? const SignUp()
        : Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (value) {
                        setState(() {
                          if(value==2){
                            showgetStarted=true;
                          }else{
                            showgetStarted=false;
                          }
                          currentIndex = value;
                        });
                      },
                      itemCount: slides.length,
                      itemBuilder: (context, index) {
                        // contents of slider
                        Widget temp1, temp2;
                        if (index == 0) {
                          temp1 = Center(
                            child: Text(
                              "Book Doctor Appointments",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          temp2 = Padding(
                            padding: EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Book appointments and video consult best doctors from the comfort of your home.",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        wordSpacing: 3,
                                        color: textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else if (index == 1) {
                          temp1 = Center(
                            child: Text(
                              "Drone Delivery",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          temp2 = Padding(
                            padding: EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Order medicines online and get them delivered instantly via drones.",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        color: textColor,
                                        wordSpacing: 3,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          temp1 = Center(
                            child: Text(
                              "Know Your Body Better",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                          temp2 = Padding(
                            padding: EdgeInsets.symmetric(horizontal: width*0.1,vertical: height*0.02),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Access all your medical records and get to know your health better with our interactive diagnosis.",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        color: textColor,
                                        wordSpacing: 3,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Slider(
                              image: slides[index].getImage()!,
                            ),
                            temp1,
                            temp2,
                          ],
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    slides.length,
                    (index) => buildDot(index, context),
                  ),
                ),
                showgetStarted?
                Container(
                  height: 60,
                  margin: EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.05),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    onPressed: () {
                      showOnBoarding = false;
                      setState(() {});
                    },
                    child: const Text("Get Started"),
                  ),
                ):Container(
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: height*0.04,horizontal: width*0.05),
                    width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: btnColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    onPressed: (){},
                    child: AnimatedTextKit(animatedTexts: [
                      RotateAnimatedText('Search for doctors --> ',textStyle: TextStyle(fontSize: height*0.018),duration: Duration(milliseconds: 1500)),
                      RotateAnimatedText('Search for clinics and hospitals --> ',textStyle: TextStyle(fontSize: height*0.018),duration: Duration(milliseconds: 1500)),
                      RotateAnimatedText('Search for medicines and tests --> ',textStyle: TextStyle(fontSize: height*0.018),duration: Duration(milliseconds: 1500)),
                      RotateAnimatedText('Search for Symptoms/Specialities -->',textStyle: TextStyle(fontSize: height*0.018),duration: Duration(milliseconds: 1500)),
                    ],repeatForever: true),
                  )
                ),
              ],
            ),
          );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: blue,
      ),
    );
  }
}

class Slider extends StatelessWidget {
  String? image;

  Slider({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // image given in slider
          Image(
            image: AssetImage(image!),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

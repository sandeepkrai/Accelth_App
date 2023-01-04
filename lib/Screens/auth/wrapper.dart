import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user_modal.dart';
import '../home.dart';
import 'authenticate.dart';

late String finalEmail;

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  // Future getValidationData() async{
  //    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //      var obtainedEmail = sharedPreferences.getString('Email_id').toString();
  //      setState((){
  //        finalEmail = obtainedEmail;
  //     });
  // }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getValidationData().whenComplete(() async {
    //   if(finalEmail==null){
    //     Timer(
    //         const Duration(seconds: 0),
    //             () => Navigator.pushAndRemoveUntil(
    //             context, MaterialPageRoute(builder: (context) => OnBoarding()),ModalRoute.withName('/')));
    //   }
    //   else{
    //     Timer(
    //         const Duration(seconds: 0),
    //             () => Navigator.pushAndRemoveUntil(
    //             context, MaterialPageRoute(builder: (context) => homepage()),ModalRoute.withName('/')));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<MyUser?>(context);
    if (userProvider == null) {
      // return OnBoarding();
      return const Authenticate();
    } else {
      return const Home();
    }
    // return Container();
  }
}

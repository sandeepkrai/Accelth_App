import 'dart:convert';
import 'dart:developer';
import 'package:accelth/Screens/LabRecords/LabReports.dart';
import 'package:accelth/Screens/Options/Emergency.dart';
import 'package:accelth/Screens/Options/Hospitals.dart';
import 'package:accelth/Screens/Options/Imaging.dart';
import 'package:accelth/Screens/Options/Medication.dart';
import 'package:accelth/Screens/Options/Orders.dart';
import 'package:accelth/Screens/Options/Records.dart';
import 'package:accelth/Screens/Options/Vitals.dart';
import 'package:accelth/Screens/Profile/ProfilePage.dart';
import 'package:accelth/constants.dart';
import 'package:accelth/models/PatientModel.dart';
import 'package:accelth/Screens/Home/Wallet.dart';
import 'package:accelth/Screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:accelth/Screens/Options/Reminders.dart';
import 'package:accelth/Screens/Options/UploadRecords.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/CustomListTitle.dart';
import '../Options/Doctors.dart';
import '../Options/Fitbit.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedIndex = -1;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RecordsPage()));
        break;
      case 3:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DoctorPage()));
        break;
      case 4:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LabReportsPage()));
        break;
      case 5:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ImagingPage()));
        break;
      case 6:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VitalsPage()));
        break;
      case 7:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EmergencyPage()));
        break;
      case 9:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MedicationsPage()));
        break;
      case 10:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrdersPage()));
        break;
      case 11:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WalletPage()));
        break;
      case 12:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UploadPage()));
        break;
      case 14:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfilePage()));
        break;
      case 15:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ReminderPage()));
        break;
    }
  }

  _ontouched(int index) async {
    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FitbitPage()));
        break;
      case 7:
        {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.remove('Email_id');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignIn()));
        }
    }
  }

  Future<PatientModel> getPatientApi() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String obtainedEmail = sharedPreferences.getString('Email_id').toString();
    final response = await http.get(Uri.parse('$patientUrl$obtainedEmail'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      return PatientModel.fromJson(data);
    } else {
      return PatientModel.fromJson(data);
    }
  }

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final list = [
      "Home",
      "Interactive Visualisation",
      "Prescription",
      "Doctors",
      "Lab Reports",
      "Imaging",
      "Vitals",
      "Emergency",
      "Hospitals and Health Centres",
      "Medicines and Health Products",
      "Your Orders",
      "Wallet",
      "Upload Records",
      "Share",
      "Profile",
      "Reminders"
    ];
    final list2 = [
      "Connected Devices",
      "Fitbit",
      "Connected Apps",
      "Glucometer",
      "About Us",
      "Need Help?",
      "Settings",
      "Logout"
    ];
    final icon = [
      Icons.home,
      Icons.favorite,
      Icons.edit,
      Icons.person,
      Icons.science,
      Icons.sunny,
      Icons.monitor_heart,
      Icons.emergency,
      Icons.local_hospital,
      Icons.vaccines,
      Icons.shopping_cart_checkout,
      Icons.wallet,
      Icons.upload,
      Icons.share,
      Icons.person,
      Icons.notifications_active
    ];
    final VitalUnitList = ['BPM', 'mmHg', '%', 'BPM', 'F', 'gm/dL', 'mg/dL'];
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder<PatientModel>(
        future: getPatientApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            );
          } else {
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Container(
                height: height * 0.06,
                width: width * 0.125,
                decoration: BoxDecoration(
                  color: const Color(0xFF0957DE),
                  borderRadius:
                      BorderRadius.all(Radius.circular(height * 0.01)),
                ),
                child: const Icon(
                  Icons.home_filled,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                title: Text(
                  "Hi ${snapshot.data!.profile!.personal!.name}!",
                  style: TextStyle(color: Colors.black, fontSize: width * 0.06),
                ),
                automaticallyImplyLeading: true,
                backgroundColor: const Color.fromRGBO(240, 250, 255, 1),
                iconTheme: IconThemeData(
                    color: const Color(0xFF0957DE), size: height * 0.035),
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WalletPage())),
                      icon: const Icon(Icons.wallet_outlined),
                    ),
                  ),
                ],
              ),
              drawer: Drawer(
                width: width * 0.85,
                backgroundColor: Colors.white,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.08),
                    child: Column(
                      children: [
                        Text(
                          "Hi ${snapshot.data!.profile!.personal!.name}, this is your Heath ID",
                          style: TextStyle(
                              fontSize: width * 0.045,
                              fontWeight: FontWeight.w500),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: height * 0.005),
                        ),
                        Image.asset("assets/images/health_id_qr.jpeg"),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.05)),
                                      color: _selectedIndex == index
                                          ? (const Color(0XFF0957DE))
                                          : Colors.white,
                                    ),
                                    height: height * 0.1,
                                    child: Center(
                                      child: ListTile(
                                        title: customListTitle(
                                          list[index],
                                          icon[index],
                                          _selectedIndex == index
                                              ? Colors.white
                                              : const Color(0xFF0957DE),
                                        ),
                                        onTap: () => _onSelected(index),
                                      ),
                                    ),
                                  ),
                                )),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: height * 0.006),
                        ),
                        Divider(
                          thickness: height * 0.004,
                          color: Colors.black,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: height * 0.006),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list2.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Container(
                              margin: EdgeInsets.only(left: width * 0.03),
                              child: ListTile(
                                onTap: () => _ontouched(index),
                                title: Text(
                                  list2[index],
                                  style: TextStyle(
                                      color: const Color(0XFF0957DE),
                                      fontWeight: FontWeight.w700,
                                      fontSize: width * 0.045),
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
              backgroundColor: const Color.fromRGBO(245, 250, 255, 1),
              body: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.022),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.03)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DoctorPage()));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 0.9,
                                            ), //BoxShadow
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.02)),
                                          color: const Color.fromRGBO(
                                              245, 250, 255, 1),
                                        ),
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.person,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Text(
                                              "Doctor",
                                              style: TextStyle(
                                                color: Color(0xFF0957DE),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          //BoxShadow
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 0.9,
                                          ), //BoxShadow
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height * 0.02)),
                                        color: const Color.fromRGBO(
                                            245, 250, 255, 1),
                                      ),
                                      height: height * 0.09,
                                      width: width * 0.21,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            FontAwesomeIcons.hackerrank,
                                            color: Color(0xFF0957DE),
                                          ),
                                          Text(
                                            "Visualisation",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFF0957DE),
                                            ),
                                          )
                                        ],
                                      )),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MedicationsPage()));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            //BoxShadow
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 0.9,
                                            ), //BoxShadow
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.02)),
                                          color: const Color.fromRGBO(
                                              245, 250, 255, 1),
                                        ),
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.vaccines,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Text(
                                              "Medicines",
                                              style: TextStyle(
                                                color: Color(0xFF0957DE),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Hospitals()));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Color(0xFF0957DE),
                                          //     width: height*0.003
                                          // ),
                                          boxShadow: const [
                                            //BoxShadow
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 0.9,
                                            ), //BoxShadow
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.02)),
                                          color: const Color.fromRGBO(
                                              245, 250, 255, 1),
                                        ),
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.local_hospital,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Text(
                                              "Hospitals",
                                              style: TextStyle(
                                                color: Color(0xFF0957DE),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VitalsPage()));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 0.9,
                                            ), //BoxShadow
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.02)),
                                          color: const Color.fromRGBO(
                                              245, 250, 255, 1),
                                        ),
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.monitor_heart,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Text(
                                              "Vitals",
                                              style: TextStyle(
                                                color: Color(0xFF0957DE),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RecordsPage()));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Color(0xFF0957DE),
                                          //     width: height*0.003
                                          // ),
                                          boxShadow: const [
                                            //BoxShadow
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 0.9,
                                            ), //BoxShadow
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.02)),
                                          color: const Color.fromRGBO(
                                              245, 250, 255, 1),
                                        ),
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.attach_file,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Text(
                                              "Records",
                                              style: TextStyle(
                                                color: Color(0xFF0957DE),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const FitbitPage()));
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: Color(0xFF0957DE),
                                          //     width: height*0.003
                                          // ),
                                          boxShadow: const [
                                            //BoxShadow
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 1),
                                              blurRadius: 1,
                                              spreadRadius: 0.9,
                                            ), //BoxShadow
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(height * 0.02)),
                                          color: const Color.fromRGBO(
                                              245, 250, 255, 1),
                                        ),
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.watch,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Text(
                                              "Fitbit",
                                              style: TextStyle(
                                                color: Color(0xFF0957DE),
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        // border: Border.all(color: Color(0xFF0957DE),
                                        //     width: height*0.003
                                        // ),
                                        boxShadow: const [
                                          //BoxShadow
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(1, 1),
                                            blurRadius: 1,
                                            spreadRadius: 0.9,
                                          ), //BoxShadow
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(height * 0.02)),
                                        color: const Color.fromRGBO(
                                            245, 250, 255, 1),
                                      ),
                                      height: height * 0.09,
                                      width: width * 0.2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.shield,
                                            color: Color(0xFF0957DE),
                                          ),
                                          Text(
                                            "Insuarance",
                                            style: TextStyle(
                                              color: Color(0xFF0957DE),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.01),
                      ),
                      Container(
                        height: height * 0.24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(height * 0.03)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/slider3.png",
                              height: height * 0.18,
                            ),
                            SizedBox(
                              width: width * 0.04,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Visualise your body like never before, deep dive into knowing your body better. ",
                                    style: TextStyle(fontSize: width * 0.04),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => const homepage(),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF0957DE)),
                                    child:
                                        const Text("Interactive Visualisation"),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.03)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03,
                                            horizontal: width * 0.1),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.attachment,
                                              size: 40,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const Text(
                                                      'Ongoing Treatment',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: height * 0.008),
                                                      child: Text(
                                                        snapshot.data!
                                                            .ongoingTreatment
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Treatment Plan: ${snapshot.data!.treatmentPlan}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: height * 0.008),
                                                    child: const Text(
                                                      'Medications',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Icon(
                                              Icons.attachment,
                                              size: 40,
                                              color: Color(0xFF0957DE),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.0001,
                                              horizontal: width * 0.02),
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: snapshot
                                                          .data!
                                                          .medications!
                                                          .length !=
                                                      0
                                                  ? snapshot
                                                      .data!.medications!.length
                                                  : 1,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: snapshot
                                                                  .data!
                                                                  .medications!
                                                                  .length !=
                                                              0
                                                          ? 2
                                                          : 1,
                                                      mainAxisExtent: snapshot
                                                                  .data!
                                                                  .medications!
                                                                  .length !=
                                                              0
                                                          ? height * 0.25
                                                          : height * 0.38),
                                              itemBuilder: (context, index) {
                                                if (snapshot.data!.medications!
                                                    .isEmpty) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Lottie.network(
                                                              'https://assets6.lottiefiles.com/packages/lf20_9voc0tca.json'),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.03),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                  height:
                                                                      height *
                                                                          0.04,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFF0957DE),
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(height *
                                                                            0.02)),
                                                                  ),
                                                                  width: width *
                                                                      0.8,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    'Upload your Medication',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            height *
                                                                                0.02,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: Colors
                                                                            .white),
                                                                  ))),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  try {
                                                    var startDate = snapshot
                                                        .data!
                                                        .medications![index]
                                                        .startDate
                                                        .toString()
                                                        .split('/')[0]
                                                        .toString();
                                                    var endDate = snapshot
                                                        .data!
                                                        .medications![index]
                                                        .endDate
                                                        .toString()
                                                        .split('/')[0]
                                                        .toString();
                                                    return Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  height * 0.01,
                                                              horizontal:
                                                                  width *
                                                                      0.002),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(width *
                                                                            0.05),
                                                                    topLeft: Radius
                                                                        .circular(width *
                                                                            0.05)),
                                                                color: const Color(
                                                                    0xFF0957DE),
                                                              ),
                                                              height:
                                                                  height * 0.08,
                                                              width:
                                                                  width * 0.43,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                          child:
                                                                              Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: width *
                                                                                0.06,
                                                                            vertical:
                                                                                height * 0.008),
                                                                        child:
                                                                            Text(
                                                                          snapshot
                                                                              .data!
                                                                              .medications![index]
                                                                              .name
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: height * 0.015,
                                                                              color: Colors.white),
                                                                        ),
                                                                      )),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: Container(
                                                              height:
                                                                  height * 0.18,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF7FCFF),
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          color:
                                                                              Colors.grey,
                                                                          offset: Offset(
                                                                              1,
                                                                              1),
                                                                          blurRadius:
                                                                              1,
                                                                          spreadRadius:
                                                                              0.5,
                                                                        ), //BoxShadow
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(height *
                                                                              0.02))),
                                                              width:
                                                                  width * 0.43,
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical:
                                                                        height *
                                                                            0.01,
                                                                    horizontal:
                                                                        width *
                                                                            0.04),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.calendar_today),
                                                                        Text(
                                                                            '  $startDate Oct - $endDate Oct'),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                            Icons.chat_bubble_outline_outlined),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Text(snapshot.data!.medications![index].mealPlan!.dose1.toString()),
                                                                            ),
                                                                            Text(snapshot.data!.medications![index].mealPlan!.dose2.toString()),
                                                                            snapshot.data!.medications![index].mealPlan!.dose3.toString() != 'null'
                                                                                ? Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Text(snapshot.data!.medications![index].mealPlan!.dose3.toString()),
                                                                                  )
                                                                                : const Text(''),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                strokeWidth:
                                                                    0.3));
                                                  }
                                                }
                                              })),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                      FutureBuilder(
                          future: getPatientApi(),
                          builder: (context, snapshot) {
                            if (snapshot.data!.vitals.toString() == 'null') {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.03)),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03,
                                            horizontal: width * 0.1),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.monitor_heart_outlined,
                                              size: 40,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: const Text(
                                                  'Vitals',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.3,
                                              height: height * 0.05,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                'View all',
                                                style: TextStyle(
                                                    color: Color(0xFF0957DE),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Lottie.network(
                                          'https://assets1.lottiefiles.com/packages/lf20_42B8LS.json'),
                                      // Image.network('https://img.freepik.com/free-vector/medical-video-call-consultation-illustration_88138-415.jpg?w=1480&t=st=1672235117~exp=1672235717~hmac=5d0fbf7a288e1da852beee70dae5134b76911aa55bab6e6e776562f2c610e566'),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: height * 0.04,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF0957DE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                ),
                                                width: width * 0.8,
                                                child: Center(
                                                    child: Text(
                                                  'Upload your Vital Records',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              try {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.03)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.03,
                                              horizontal: width * 0.1),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.monitor_heart_outlined,
                                                size: 40,
                                                color: Color(0xFF0957DE),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.05),
                                                  child: const Text(
                                                    'Vitals',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.05,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: width * 0.004,
                                                      color: const Color(
                                                          0xFF0957DE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                  color: Colors.white,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'View all',
                                                  style: TextStyle(
                                                      color: Color(0xFF0957DE),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .heart_broken_outlined,
                                                                size: height *
                                                                    0.03,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      'Heart Rate',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data!.vitals!.heartRate!.latestResult.toString()} ${VitalUnitList[0]}'),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data!.vitals!
                                                              .heartRate!.status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .heartRate!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .bloodtype_rounded,
                                                                size: height *
                                                                    0.03,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      'Pressure',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data!.vitals!.bloodPressure!.latestResult.toString()} ${VitalUnitList[1]}'),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .vitals!
                                                              .bloodPressure!
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .bloodPressure!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .bubble_chart_outlined,
                                                                size: height *
                                                                    0.04,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      'Oxygen',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data!.vitals!.oxygen!.latestResult.toString()} ${VitalUnitList[2]}'),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data!.vitals!
                                                              .oxygen!.status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .oxygen!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.air,
                                                                size: height *
                                                                    0.04,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      'Respiratory',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data!.vitals!.respiratory!.latestResult.toString()} ${VitalUnitList[3]}'),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .vitals!
                                                              .respiratory!
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .respiratory!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .thermostat,
                                                                size: height *
                                                                    0.04,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      'Temperature',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        '${snapshot.data!.vitals!.temperature!.latestResult.toString()} ${VitalUnitList[4]}'),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .vitals!
                                                              .temperature!
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .temperature!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } catch (err) {
                                return Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 0.3));
                              }
                            }
                          }),
                      FutureBuilder(
                          future: getPatientApi(),
                          builder: (context, snapshot) {
                            if (snapshot.data!.vitals.toString() == 'null') {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.03)),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03,
                                            horizontal: width * 0.1),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.video_label_rounded,
                                              size: 40,
                                              color: Color(0xFF0957DE),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: const Text(
                                                  'Lab Reports',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.3,
                                              height: height * 0.05,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: const Center(
                                                  child: Text(
                                                'View all',
                                                style: TextStyle(
                                                    color: Color(0xFF0957DE),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Lottie.network(
                                          'https://assets9.lottiefiles.com/packages/lf20_hSevJIQ2Wm.json'),
                                      // Image.network('https://img.freepik.com/free-vector/medical-video-call-consultation-illustration_88138-415.jpg?w=1480&t=st=1672235117~exp=1672235717~hmac=5d0fbf7a288e1da852beee70dae5134b76911aa55bab6e6e776562f2c610e566'),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: height * 0.04,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF0957DE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                ),
                                                width: width * 0.8,
                                                child: Center(
                                                    child: Text(
                                                  'Upload your Lab Records',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              try {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.03)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.03,
                                              horizontal: width * 0.1),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.video_label_rounded,
                                                size: 40,
                                                color: Color(0xFF0957DE),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.05),
                                                  child: const Text(
                                                    'Lab Reports',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.05,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: width * 0.004,
                                                      color: const Color(
                                                          0xFF0957DE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                  color: Colors.white,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'View all',
                                                  style: TextStyle(
                                                      color: Color(0xFF0957DE),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.1,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_heart_outlined,
                                                                size: height *
                                                                    0.03,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Haemoglobin',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        'Latest result: ${snapshot.data!.vitals!.heartRate!.latestResult.toString()} ${VitalUnitList[5]}'),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        'Average result: ${snapshot.data!.vitals!.heartRate!.avgResult.toString()} ${VitalUnitList[5]}'),
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
                                                      height: height * 0.0945,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .vitals!
                                                              .haemoglobin!
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .haemoglobin!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.1,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_heart_outlined,
                                                                size: height *
                                                                    0.03,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Glucose',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        'Latest result: ${snapshot.data!.vitals!.glucose!.latestResult.toString()} ${VitalUnitList[5]}'),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        'Average result: ${snapshot.data!.vitals!.glucose!.avgResult.toString()} ${VitalUnitList[5]}'),
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
                                                      height: height * 0.0945,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data!.vitals!
                                                              .glucose!.status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .glucose!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.1,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_heart_outlined,
                                                                size: height *
                                                                    0.03,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.01),
                                                                child: Column(
                                                                  children: [
                                                                    const Text(
                                                                      'Thyroid',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18),
                                                                    ),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        'Latest result: ${snapshot.data!.vitals!.thyroid!.status.toString()}'),
                                                                    SizedBox(
                                                                      height: height *
                                                                          0.005,
                                                                    ),
                                                                    Text(
                                                                        'Average result:${snapshot.data!.vitals!.thyroid!.status.toString()}'),
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
                                                      height: height * 0.0945,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot.data!.vitals!
                                                              .thyroid!.status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .thyroid!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.1,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.03),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .monitor_heart_outlined,
                                                              size:
                                                                  height * 0.03,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: width *
                                                                      0.02,
                                                                  top: height *
                                                                      0.01),
                                                              child: Column(
                                                                children: [
                                                                  const Text(
                                                                    'Blood Pressure',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.005,
                                                                  ),
                                                                  Text(
                                                                      'Latest result: ${snapshot.data!.vitals!.bloodPressure!.latestResult.toString()}${VitalUnitList[1]}'),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.005,
                                                                  ),
                                                                  Text(
                                                                      'Average result: ${snapshot.data!.vitals!.bloodPressure!.avgResult.toString()}${VitalUnitList[1]}'),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      height: height * 0.0945,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .vitals!
                                                              .bloodPressure!
                                                              .status
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: snapshot
                                                                        .data!
                                                                        .vitals!
                                                                        .bloodPressure!
                                                                        .status
                                                                        .toString() ==
                                                                    'CONCERN'
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } catch (err) {
                                return SizedBox(
                                  height: height * 0.3,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              }
                            }
                          }),
                      FutureBuilder(
                          future: getPatientApi(),
                          builder: (context, snapshot) {
                            if (snapshot.data!.medicalDevice.toString() ==
                                    'null' ||
                                snapshot.data!.medicalDevice!.fitbit
                                        .toString() ==
                                    '') {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.03)),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03,
                                            horizontal: width * 0.1),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.watch,
                                                size: 40,
                                                color: Color(0xFF0957DE),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: const Text(
                                                  'Fitbit',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: width * 0.2,
                                                height: height * 0.04,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: width * 0.004,
                                                      color: const Color(
                                                          0xFF0957DE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                  color: Colors.white,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'View all',
                                                  style: TextStyle(
                                                      color: Color(0xFF0957DE),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Lottie.network(
                                          'https://assets5.lottiefiles.com/packages/lf20_90trtl38.json'),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: height * 0.04,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF0957DE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                ),
                                                width: width * 0.8,
                                                child: Center(
                                                    child: Text(
                                                  'Connect with your fitness tracker',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              try {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.03)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.03,
                                              horizontal: width * 0.1),
                                          child: Row(
                                            children: [
                                              const Expanded(
                                                flex: 1,
                                                child: Icon(
                                                  Icons.watch,
                                                  size: 40,
                                                  color: Color(0xFF0957DE),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.05),
                                                  child: const Text(
                                                    'Fitbit',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Container(
                                                  width: width * 0.2,
                                                  height: height * 0.04,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: width * 0.004,
                                                        color: const Color(
                                                            0xFF0957DE)),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                height * 0.02)),
                                                    color: Colors.white,
                                                  ),
                                                  child: const Center(
                                                      child: Text(
                                                    'View all',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF0957DE),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.055,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_heart_outlined,
                                                                size: height *
                                                                    0.04,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.001),
                                                                child:
                                                                    const Text(
                                                                  'Number of steps',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .medicalDevice!
                                                              .fitbit!
                                                              .numberofSteps
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.055,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_heart_outlined,
                                                                size: height *
                                                                    0.04,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.001),
                                                                child:
                                                                    const Text(
                                                                  'Distance',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .medicalDevice!
                                                              .fitbit!
                                                              .distance
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.03,
                                              vertical: height * 0.015),
                                          child: Container(
                                              width: width * 0.9,
                                              height: height * 0.055,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: width * 0.004,
                                                    color: const Color(
                                                        0xFF0957DE)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.02)),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: width * 0.04),
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Center(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .monitor_heart_outlined,
                                                                size: height *
                                                                    0.04,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.03,
                                                                    top: height *
                                                                        0.001),
                                                                child:
                                                                    const Text(
                                                                  'Calories',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
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
                                                      height: height * 0.0745,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        0.01)),
                                                        color: const Color(
                                                                0xFF0957DE)
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .medicalDevice!
                                                              .fitbit!
                                                              .calories
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.02,
                                              horizontal: width * 0.05),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.directions_run_outlined,
                                                size: height * 0.04,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.003,
                                                    horizontal: width * 0.02),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('Fitness'),
                                                    SizedBox(
                                                      height: height * 0.015,
                                                    ),
                                                    const Text(
                                                        'Weekly active zone graph')
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } catch (err) {
                                return SizedBox(
                                  height: height * 0.3,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              }
                            }
                          }),
                      FutureBuilder(
                          future: getPatientApi(),
                          builder: (context, snapshot) {
                            if (snapshot.data!.medicalDevice.toString() ==
                                    'null' ||
                                snapshot.data!.medicalDevice!.glucometer
                                        .toString() ==
                                    '') {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: height * 0.01),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(height * 0.03)),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: Icon(
                                                Icons.gas_meter,
                                                size: 40,
                                                color: Color(0xFF0957DE),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    Text(
                                                      'Glucometer',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Glucose results',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                width: width * 0.2,
                                                height: height * 0.04,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: width * 0.004,
                                                      color: const Color(
                                                          0xFF0957DE)),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                  color: Colors.white,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'View all',
                                                  style: TextStyle(
                                                      color: Color(0xFF0957DE),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Lottie.network(
                                          'https://assets8.lottiefiles.com/packages/lf20_l13zwx3i.json'),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.03),
                                        child: Column(
                                          children: [
                                            Container(
                                                height: height * 0.04,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF0957DE),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              height * 0.02)),
                                                ),
                                                width: width * 0.8,
                                                child: Center(
                                                    child: Text(
                                                  'Add your Glucose Test reports',
                                                  style: TextStyle(
                                                      fontSize: height * 0.02,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ))),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              try {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(height * 0.03)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: height * 0.03,
                                              horizontal: width * 0.05),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 1,
                                                    child: Icon(
                                                      Icons.gas_meter,
                                                      size: 40,
                                                      color: Color(0xFF0957DE),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  width * 0.05),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: const [
                                                          Text(
                                                            'Glucometer',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Glucose results',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      width: width * 0.2,
                                                      height: height * 0.04,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width:
                                                                width * 0.004,
                                                            color: const Color(
                                                                0xFF0957DE)),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    height *
                                                                        0.02)),
                                                        color: Colors.white,
                                                      ),
                                                      child: const Center(
                                                          child: Text(
                                                        'View all',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF0957DE),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: height * 0.03,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.05),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Latest result: ${snapshot.data!.medicalDevice!.glucometer!.latestResult.toString()} ${VitalUnitList[6]}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Average result: ${snapshot.data!.medicalDevice!.glucometer!.avgResult.toString()} ${VitalUnitList[6]}',
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } catch (err) {
                                return SizedBox(
                                  height: height * 0.3,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              }
                            }
                          }),
                      GestureDetector(
                        onTap: () {
                          _scrollController.animateTo(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.fastOutSlowIn);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Back to the top',
                              style: TextStyle(
                                  color: Color(0xFF0957DE),
                                  fontSize: height * 0.016),
                            ),
                            Icon(
                              Icons.arrow_drop_up_rounded,
                              color: Color(0xFF0957DE),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}

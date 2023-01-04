import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../../models/nearby_hospital.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  State<Hospitals> createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  static String nearbyApi =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=hospital&key=AIzaSyBf_u2zG1AIgEB_5wpL3GTxcIUVgBOEKh0&radius=5000";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<List<NearbyHospital>?> getHospitals(double lat, double lang) async {
    try {
      var url = Uri.parse(nearbyApi + "&location=$lat,$lang");
      // print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['results'];
        List<NearbyHospital> hospitals = data.map((e) {
          return NearbyHospital(
              name: e['name'],
              address: e['vicinity'],
              lat: e['geometry']['location']['lat'],
              lang: e['geometry']['location']['lng']);
        }).toList();
        return hospitals;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

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
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    'Hospitals and Healthcare Centres',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.015),
                child: Text(
                  'Search for nearby specialist hospitals, clinics, lab centres and pharmacies.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: width * 0.04),
                ),
              ),
              FutureBuilder(
                future: _determinePosition(),
                builder:
                    (BuildContext context, AsyncSnapshot<Position> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return FutureBuilder(
                      future: getHospitals(
                          snapshot.data!.latitude, snapshot.data!.longitude),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<NearbyHospital>?> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          List<NearbyHospital> data = snapshot.data!;
                          return Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  CameraPosition camPos = CameraPosition(
                                      target: LatLng(
                                          data[index].lat, data[index].lang),
                                      zoom: 14.5);
                                  return GestureDetector(
                                    onTap: () async {
                                      await launchUrl(Uri.parse(
                                          "https://www.google.com/maps/search/?api=1&query=${data[index].lat},${data[index].lang}"));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Color(0xff0957DE),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 108,
                                                height: 48,
                                                margin: EdgeInsets.only(
                                                  right: 14,
                                                  bottom: 12,
                                                ),
                                                child: GoogleMap(
                                                  initialCameraPosition: camPos,
                                                  zoomControlsEnabled: false,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  data[index].name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.w400),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            data[index].address,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error");
                        } else {
                          return Expanded(
                            child: Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.toString()),
                    );
                  } else {
                    return Expanded(
                      child: Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
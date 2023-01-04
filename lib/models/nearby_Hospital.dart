import 'package:flutter/material.dart';

class NearbyHospital {
  String name, address;
  double lat, lang;

  NearbyHospital({
    required this.name,
    required this.address,
    required this.lat,
    required this.lang,
  });
}
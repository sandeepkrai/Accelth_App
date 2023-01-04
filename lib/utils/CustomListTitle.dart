import 'package:flutter/material.dart';

class customListTitle extends StatelessWidget {
  var titleName;
  IconData a;
  Color c;
  customListTitle(this.titleName, this.a, this.c, {super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Icon(
          a,
          color: c,
          size: width * 0.08,
        ),
        SizedBox(
          width: width * 0.01,
        ),
        Text(
          titleName,
          style: TextStyle(
              color: c, fontSize: width * 0.04, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
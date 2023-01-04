import 'package:accelth/Screens/OnBoard/onboarding.dart';

import 'signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "package:accelth/providers/sign.dart";

class Authenticate extends StatelessWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<SignInOrRegister>(context);
    if (data.isSignIn) {
      return const SignIn();
    } else {
      return const OnBoarding();
    }
  }
}

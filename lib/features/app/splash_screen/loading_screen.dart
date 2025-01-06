
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NewUserLoadingScreen extends StatelessWidget {
  const NewUserLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff39f1d0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Creating your account. Please wait a moment.\n", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
          SpinKitDualRing(
            color: Colors.white,
            size: 100.0,),
      ]
      )
    );
  }
}

class DefaultLoadingScreen extends StatelessWidget {
  const DefaultLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff39f1d0),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please wait a moment.\n", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
              SpinKitCircle(
                color: Colors.white,
                size: 100.0,),
            ]
        )
    );
  }
}









import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class NewUserLoadingScreen extends StatelessWidget {
  const NewUserLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff39f1d0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Creating your account. Please wait a moment.\n", textAlign: TextAlign.center, style: GoogleFonts.tinos(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
          const SpinKitDualRing(
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please wait a moment.\n", style: GoogleFonts.tinos(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
              const SpinKitCircle(
                color: Colors.white,
                size: 100.0,),
            ]
        )
    );
  }
}








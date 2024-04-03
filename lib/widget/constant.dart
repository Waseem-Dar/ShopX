import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant{
  
  // static Color pink =  const Color.fromARGB(170,243, 124, 151 );
  static Color pink =  const Color.fromARGB(199, 161, 0, 117);

  static showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  static void showProgressBar(BuildContext context,Color color){
    showDialog(context: context, builder: (_)=> Center(child: CircularProgressIndicator(color: color,),));
  }

}

//
// #on:
// #  pull_request:
// #    branches:
// #      - master
// #  push:
// #    branches:
// #      - master
// #      - work
// #name: "Build & Release"
// #jobs:
// #  build:
// #    name: Build & Release
// #    runs-on: windows-latest
// #    steps:
// #      - uses: actions/checkout@v3
// #      - uses: actions/setup-java@v3
// #        with:
// #          distribution: 'zulu'
// #          java-version: '12'
// #      - uses: subosito/flutter-action@v2
// #        with:
// #          channel: 'stable'
// #          architecture: x64
// #
// #      - run: flutter build apk --release --split-per-abi
// #      - run: |
// #          flutter build ios --no-codesign
// #          cd build/ios/iphoneos
// #          mkdir Payload
// #          cd Payload
// #          ln -s ../Runner.app
// #          cd ..
// #          zip -r app.ipa Payload
// #      - name: Push to Releases
// #        uses: ncipollo/release-action@v1
// #        with:
// #          artifacts: "build/app/outputs/apk/release/*,build/ios/iphoneos/app.ipa"
// #          tag: v1.0.${{ github.run_number }}
// #          token: ${{ secrets.TOKEN }}
// #

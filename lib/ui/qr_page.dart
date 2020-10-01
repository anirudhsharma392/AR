import 'dart:async';
import 'package:augmented_reaility/main.dart';
import 'package:augmented_reaility/ui/image_recognition/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'auto_detect_plane.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'common/common_widgets.dart';

class QR extends StatefulWidget {
  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QR> {
  String code = "";
  double progress = 0;
  bool flag = false;
  @override
  void initState() {
    super.initState();

    setState(() {
      progress = 0;
      progress = 100;
    });
  }

  Future scanBarCode() async {
    String barCodeResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    if (barCodeResult != '-1') {
      setState(() {
        flag = true;
      });

      Future.delayed(Duration(milliseconds: 1300), () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AugmentedReality(url: barCodeResult)),
        );
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            flag ? progressIndicator() : Container(),
            !flag
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DefaultButton(onPress: scanBarCode,name: "Scan QR",),
                    SizedBox(height: 50,),
                    DefaultButton(onPress: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageRecognitionHome(cameras)),
                      );
                    },name: "Scan Image",),

                  ],
                )
                : Container(
                    child: Text(
                      "Loading..",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            flag
                ? Container(
                    margin: EdgeInsets.only(top: 150),
                    alignment: Alignment.topCenter,
                    child: Loading())
                : Container(),
          ],
        ),
      ),
    ));
  }

  Widget Loading() {
    return Column(
      children: <Widget>[
        GlowingProgressIndicator(
          child: Text(
            "Generating \n3D models",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget progressIndicator() {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
          size: 300,
          startAngle: 0,
          angleRange: 360,
          customColors: CustomSliderColors(
            progressBarColors: [
              Colors.blue,
              Colors.redAccent,
              Colors.purpleAccent
            ],
            shadowMaxOpacity: 0.6,
          ),
          customWidths: CustomSliderWidths(
              progressBarWidth: 20, trackWidth: 5, handlerSize: 10)),
      innerWidget: (value) {
        return Container();
      },
      initialValue: progress,
    );
  }


}

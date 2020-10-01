import 'package:augmented_reaility/ui/common/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import '../auto_detect_plane.dart';
import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class ImageRecognitionHome extends StatefulWidget {
  final List<CameraDescription> cameras;

  ImageRecognitionHome(this.cameras);

  @override
  _ImageRecognitionHomeState createState() => new _ImageRecognitionHomeState();
}

class _ImageRecognitionHomeState extends State<ImageRecognitionHome> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  List<Widget> buttonList = [];
  Map<String, bool> objectList = {"Bed": true, "Bench": true, "Couch": true};

  @override
  void initState() {
    super.initState();
    setModel();
  }

  setModel() async {
    setState(() {
      _model = cocoMobileNet;
      //best

      //good:
      //yolo
      //useless:
      //posenet
      //
      //bad:
      //ssd
      //mobilenet
    });
    loadModel();
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case cocoMobileNet:
        res = await Tflite.loadModel(
            model: "assets/detect.tflite",
            labels: "assets/labelmap.txt",
            numThreads: 2);
        break;

      case imageRecognition:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224_quant.tflite",
            labels: "labels_mobilenet_quant_v1_224.txt",
            numThreads: 2);
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      case ssd:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  addButton(name, link) {
    if (objectList[name]) {
      setState(() {
        buttonList.add(DefaultButton(
          name: "Spawn\n$name",
          height: 60,
          width: 100,
          fontSize: 16,
          onPress: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AugmentedReality(
                          url: link,
                        )));
          },
        ));
        buttonList.add(SizedBox(
          width: 30,
        ));
      });
      objectList[name] = false;
    }
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      for (var element in recognitions) {
        print(
            '------------------------------------------------------------------------------------');
        print("Detected Class : ${element['detectedClass']}");
        print("Model Used : $_model");
        print(
            '------------------------------------------------------------------------------------');
        switch (element['detectedClass']) {
          case "bed":
            addButton("Bed",
                "https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/bed_2/model.gltf");
            break;
          case "bench":
            addButton("Bench",
                "https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/bench/bench.gltf");
            break;
          case "couch":
            addButton("Couch",
                "https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/sofa/sofa.gltf");
            break;
        }
      }
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              _model),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  ...buttonList,
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

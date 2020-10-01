import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class AssetsObject extends StatefulWidget {
  @override
  _AssetsObjectState createState() => _AssetsObjectState();
}

class _AssetsObjectState extends State<AssetsObject> {
  ArCoreController arCoreController;
  Color selectedColor=Colors.red;
  Color unSelectedColor=Colors.transparent;
  int selected=1;

  String objectSelected =
      'https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/bench/bench.gltf';

  @override
  Widget build(BuildContext context) {
    Widget button(int num, String url) {
      if(selected==num){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: RaisedButton(
              color: selectedColor,
              onPressed: () {
                setState(() {
                  objectSelected = url;
                  selected=num;
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              child: Text(
                "$num",
                style: TextStyle(fontSize: 30, color: Colors.white),
              )),
        );
      }else{
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: RaisedButton(
              color: unSelectedColor,
              onPressed: () {
                setState(() {
                  selected=num;
                  objectSelected = url;
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              child: Text(
                "$num",
                style: TextStyle(fontSize: 30, color: Colors.red),
              )),
        );
      }
    }

    return MaterialApp(
      home: Scaffold(

        body: Stack(
          children: <Widget>[
            ArCoreView(
              onArCoreViewCreated: _onArCoreViewCreated,
              enableTapRecognizer: true,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      button(1,
                          'https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/sofa/sofa.gltf'),
                      button(2,
                          'https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/drums/drums.gltf'),
                      button(3,
                          ''),
                      button(4,
                          'https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/bench/bench.gltf'),
                      button(5,
                          'https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/bedroom/Bedroom.gltf'),
                      button(6,
                          'https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/bar/bar.gltf'),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    arCoreController.onPlaneDetected=(a){print('plane detected !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');};
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneTap = _handleOnPlaneTap;
  }

  void _addToucano(var plane) {
    if (objectSelected != null) {
      //"https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF/Duck.gltf"
      final toucanoNode = ArCoreReferenceNode(

          objectUrl: objectSelected,
          position: plane.pose.translation,
          rotation: plane.pose.rotation);

      arCoreController.addArCoreNodeWithAnchor(toucanoNode);
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text('Select an object!')),
      );
    }
  }

  void _handleOnPlaneTap(List<ArCoreHitTestResult> hits) {
    final hit = hits.first;
    _addToucano(hit);
  }

  void onTapHandler(String name) {
    print("Flutter: onNodeTap");
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Row(
          children: <Widget>[
            Text('Remove $name?'),
            IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  arCoreController.removeNode(nodeName: name);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

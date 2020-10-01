import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:augmented_reaility/ui/qr_page.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:vector_math/vector_math_64.dart';


class AugmentedReality extends StatefulWidget {
  final String url;
  AugmentedReality(
      {this.url =
          "https://raw.githubusercontent.com/anirudhsharma392/Poly-ar/master/gltf/chairs/scene.gltf"});
  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  ArCoreController arCoreController;
  ArCoreNode node;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableUpdateListener: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneDetected = _handleOnPlaneDetected;
  }

  void _handleOnPlaneDetected(ArCorePlane plane) {
    if (node != null) {
      arCoreController.removeNode(nodeName: node.name);
    }
    _addObject(arCoreController, plane);
  }

  bool spawnFlag = true;

  void _addObject(ArCoreController controller, ArCorePlane plane) {
    node = ArCoreReferenceNode(
        objectUrl: widget.url,
        position: plane.centerPose.translation ,
        rotation: plane.centerPose.rotation

    );
    if (spawnFlag == true) {
      controller.addArCoreNodeWithAnchor(node);
      spawnFlag = false;
    } else {
      print('Already Spawned');
    }
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

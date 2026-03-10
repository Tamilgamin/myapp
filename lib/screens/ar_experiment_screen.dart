import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:ar_chemistry_lab/reaction_engine/reaction_engine.dart';

class ARExperimentScreen extends StatefulWidget {
  final dynamic experiment;

  const ARExperimentScreen({super.key, required this.experiment});

  @override
  _ARExperimentScreenState createState() => _ARExperimentScreenState();
}

class _ARExperimentScreenState extends State<ARExperimentScreen> {
  late ARSessionManager arSessionManager;
  late ARObjectManager arObjectManager;
  late ARAnchorManager arAnchorManager;

  List<ARNode> nodes = [];
  bool surfaceDetected = false;

  @override
  void dispose() {
    arSessionManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.experiment['title']),
      ),
      body: Stack(
        children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          if (!surfaceDetected)
            const Center(
              child: Text('Point camera at a flat surface'),
            ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: surfaceDetected ? startExperiment : null,
              child: const Text('Start Experiment'),
            ),
          ),
        ],
      ),
    );
  }

  void onARViewCreated(
    ARSessionManager arSessionManager,
    ARObjectManager arObjectManager,
    ARAnchorManager arAnchorManager,
    ARLocationManager arLocationManager,
  ) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: null,
      showWorldOrigin: false,
      handleTaps: false,
    );

    this.arObjectManager.onInitialize();
  }

  void onPlaneOrPointTapped(List<ARHitTestResult> hitTestResults) {
    var singleHitTestResult = hitTestResults.firstWhere(
      (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane,
    );
    var newAnchor = ARPlaneAnchor(
      transformation: singleHitTestResult.worldTransform,
    );
    arAnchorManager.addAnchor(newAnchor);
    setState(() {
      surfaceDetected = true;
    });
    }

  void startExperiment() {
    // Add lab table and equipment
    addLabEquipment();
  }

  void addLabEquipment() {
    // Add beaker
    var node = ARNode(
      type: NodeType.localGLTF2,
      uri: "assets/models/beaker.gltf",
      scale: vector.Vector3(0.1, 0.1, 0.1),
      position: vector.Vector3(0.0, 0.0, 0.0),
      rotation: vector.Vector4(1.0, 0.0, 0.0, 0.0),
    );
    arObjectManager.addNode(node);
    nodes.add(node);

    // Add other equipment similarly
  }
}
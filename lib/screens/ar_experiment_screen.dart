import 'package:flutter/material.dart';

class ARExperimentScreen extends StatefulWidget {
  final dynamic experiment;

  const ARExperimentScreen({super.key, required this.experiment});

  @override
  State<ARExperimentScreen> createState() => _ARExperimentScreenState();
}

class _ARExperimentScreenState extends State<ARExperimentScreen> {
  List<String> equipment = [];
  bool surfaceDetected = false;

  @override
  void initState() {
    super.initState();
    _loadExperimentData();
  }

  void _loadExperimentData() {
    // Load equipment from experiment
    if (widget.experiment != null) {
      setState(() {
        surfaceDetected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.experiment != null ? widget.experiment['title'] ?? 'AR Lab' : 'AR Lab'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // AR View Placeholder
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue[900]!, Colors.purple[900]!],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.videocam,
                      size: 64,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      surfaceDetected ? 'Surface Detected' : 'Point camera at a flat surface',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Controls
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.red,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.green,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Simulation started')),
                      );
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
                  FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.orange,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Screenshot saved')),
                      );
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

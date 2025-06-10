import 'dart:math';

import 'package:camera/camera.dart';
import 'package:chatapp/screens/video_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'camera_view.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  Future<void>? _cameraValue;
  List<CameraDescription>? _cameras;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
        );
        _cameraValue = _cameraController!.initialize().then((_) {
          if (mounted) {
            setState(() {});
          }
        });
      } else {
        print("No cameras available");
      }
    } catch (e) {
      print("Error initializing cameras: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void takePhoto(BuildContext context) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      print("Camera not initialized");
      return;
    }
    try {
      final XFile file = await _cameraController!.takePicture();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraViewPage(path: file.path),
        ),
      );
    } catch (e) {
      print("Error taking photo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameras == null ||
          _cameraController == null ||
          _cameraValue == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          FutureBuilder<void>(
            future: _cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(_cameraController!),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.black,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () async {
                          if (_cameraController != null) {
                            setState(() {
                              flash = !flash;
                            });
                            await _cameraController!.setFlashMode(
                              flash ? FlashMode.torch : FlashMode.off,
                            );
                          }
                        },
                      ),
                      GestureDetector(
                        onLongPress: () async {
                          if (_cameraController != null &&
                              !_cameraController!.value.isRecordingVideo) {
                            try {
                              await _cameraController!.startVideoRecording();
                              setState(() {
                                isRecording = true;
                              });
                            } catch (e) {
                              print("Error starting video: $e");
                            }
                          }
                        },
                        onLongPressUp: () async {
                          if (_cameraController != null &&
                              _cameraController!.value.isRecordingVideo) {
                            try {
                              final XFile videoPath =
                              await _cameraController!.stopVideoRecording();
                              setState(() {
                                isRecording = false;
                              });
                              if (!mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VideoViewPage(path: videoPath.path),
                                ),
                              );
                            } catch (e) {
                              print("Error stopping video: $e");
                            }
                          }
                        },
                        onTap: () {
                          if (!isRecording) {
                            takePhoto(context);
                          }
                        },
                        child: isRecording
                            ? const Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,
                        )
                            : const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      IconButton(
                        icon: Transform.rotate(
                          angle: transform,
                          child: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        onPressed: () async {
                          if (_cameras == null || _cameras!.isEmpty) return;
                          setState(() {
                            isCameraFront = !isCameraFront;
                            transform = transform + pi;
                          });
                          final int cameraPos = isCameraFront ? 0 : 1;
                          if (cameraPos < _cameras!.length) {
                            await _cameraController?.dispose();
                            _cameraController = CameraController(
                              _cameras![cameraPos],
                              ResolutionPreset.high,
                            );
                            _cameraValue = _cameraController!.initialize().then((_) {
                              if (mounted) {
                                setState(() {});
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Hold for Video, tap for photo",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
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
// ignore: file_names
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ilearn/Global/constants.dart';

class Capture extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final File result;
  const Capture({Key? key, required this.result}) : super(key: key);

  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  TextDetector textDetector = GoogleMlKit.vision.textDetector();
  File? image;
  String processedText = "";
  bool togglePicker = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size mediaScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        // ignore: unnecessary_null_comparison
        child: widget.result == null
            ? const Text("No image scanned")
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.file(
                      widget.result,
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () => processTextForResults(),
        label: const Text("Process Image"),
        icon: const Icon(
          Icons.camera,
        ),
      ),
    );
  }

  processTextForResults() async {
    InputImage inImage = InputImage.fromFile(widget.result);
    var proces = await textDetector.processImage(inImage);

    // Navigator.of(context).pop();
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheet(
              enableDrag: true,
              onDragStart: (details) {
                if (kDebugMode) {
                  print(details);
                }
              },
              backgroundColor: Colors.transparent,
              builder: (context) {
                Size mediaScreen = MediaQuery.of(context).size;
                return Container(
                  width: mediaScreen.width,
                  height: mediaScreen.height / 3,
                  decoration: const BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  // ignore: prefer_if_null_operators
                  child: Center(child: Text(proces.text)),
                );
              },
              onClosing: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text("Done"),
                  ),
                );
              });
        });
  }
}

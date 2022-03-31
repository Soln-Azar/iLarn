// ignore: file_names
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Models/or_divider.dart';
import 'package:ilearn/Views/Home/Screens/Results.dart';

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
    processScaned();
  }

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }

  Future<String> processScaned() async {
    InputImage inImage = InputImage.fromFile(widget.result);
    var proces = await textDetector.processImage(inImage);
    setState(() {});
    return proces.text;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size mediaScreen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        // ignore: unnecessary_null_comparison
        child: FutureBuilder(
          future: processScaned(),
          builder: ((context, snapshot) {
            return snapshot.hasError
                ? Padding(
                    padding: const EdgeInsets.all(38.0),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: mediaScreen.height / 3,
                          ),
                          const Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator.adaptive()),
                          SizedBox(height: mediaScreen.height * 0.03),
                          const Center(
                            child: Text("Loading......"),
                          )
                        ],
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrDivider(
                          label: 'Cropped Image',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Container(
                            width: mediaScreen.width,
                            height: mediaScreen.height / 2.3,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: FileImage(widget.result),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrDivider(
                          label: 'Scanned Results',
                        ),
                      ),
                      SizedBox(
                        height: mediaScreen.height / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Text('${snapshot.data}'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        onPressed: () => navigateTo(),
        label: const Text("Process Results"),
        icon: const Icon(
          Icons.camera,
        ),
      ),
    );
  }

  navigateTo() async {
    var data = await processScaned();
    Navigator.of(context).push(
      PageRouteBuilder(
          transitionDuration: const Duration(seconds: 500),
          reverseTransitionDuration: const Duration(seconds: 500),
          pageBuilder: (context, animation, _) {
            return Results(
              query: data,
            );
          }),
    );
  }

  processTextForResults() async {
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
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(''),
                    ),
                  ),
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

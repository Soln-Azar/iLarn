import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Views/Settings/Model/Needed.dart';
import 'package:image_picker/image_picker.dart';

class Capture extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final drawerKey;
  const Capture({Key? key, this.drawerKey}) : super(key: key);

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

  processImageFromGallery() async {
    Navigator.of(context).pop();
    var pickImage =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      image = File(pickImage!.path);
    });
    InputImage inputImage = InputImage.fromFile(image!);
    RecognisedText txt = await textDetector.processImage(inputImage);
    setState(() {
      processedText = txt.text;
    });
  }

  processImageFromCamera() async {
    Navigator.of(context).pop();

    var pickImage =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      image = File(pickImage!.path);
    });
    InputImage inputImage = InputImage.fromFile(image!);
    RecognisedText txt = await textDetector.processImage(inputImage);
    setState(() {
      processedText = txt.text;
    });
  }

  processTextForResults() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: image == null
            ? const Text("No image scanned")
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: Card(child: Image.file(image!)),
                    ),
                  ),
                  Text(processedText),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () => showImageSettings(),
        child: const Icon(
          Icons.camera,
        ),
      ),
    );
  }

  void showImageSettings() {
    showModalBottomSheet(
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BottomSheet(
            backgroundColor: Colors.transparent,
            onClosing: () {},
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height / 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  children: [
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: Icon(Icons.browse_gallery_rounded),
                      ),
                      title: const Text("Pick from gallery"),
                      onTap: () => processImageFromGallery(),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: Icon(Icons.camera),
                      ),
                      title: const Text("Pick from camera"),
                      onTap: () => processImageFromCamera(),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}

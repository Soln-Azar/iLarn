import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Views/Home/Screens/Capture.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_crop/image_crop.dart';

class ImageCropper extends StatefulWidget {
  const ImageCropper({Key? key}) : super(key: key);

  @override
  _ImageCropperState createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  File? image;

  final cropKey = GlobalKey<CropState>();
  File? _file;
  File? _sample;
  File? _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(
      child: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        label: const Text("Choose image"),
        onPressed: () => showImageSettings(),
        icon: const Icon(
          Icons.camera,
        ),
      ),
    );
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Crop.file(
            _sample!,
            key: cropKey,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              OutlinedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(kPrimaryColor),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
                    fixedSize: MaterialStateProperty.all(const Size(200, 50))),
                child: Text(
                  'Crop Image',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                ),
                onPressed: () => _cropImage(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _openImage() async {
    Navigator.of(context).pop();
    final pickedFile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size!.longestSide.ceil(),
    );

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  /// capture image from camera
  Future<void> _captureImage() async {
    Navigator.of(context).pop();
    final pickedFile =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size!.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger

    final sample = await ImageCrop.sampleImage(
      file: _file!,
      preferredSize: (1000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;
    // ignore: unnecessary_null_comparison
    if (file != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Capture(
            result: file,
          ),
        ),
      );
    }
    debugPrint('$file');
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
                      onTap: () => _openImage(),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        child: Icon(Icons.camera),
                      ),
                      title: const Text("Pick from camera"),
                      onTap: () => _captureImage(),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}

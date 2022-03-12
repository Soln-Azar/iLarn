// ignore: file_names
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilearn/Auth/Auth.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Views/Home/Screens/Capture.dart';
import 'package:ilearn/Views/Home/Screens/Note.dart';
import 'package:ilearn/Views/Home/Screens/Profile.dart';
import 'package:ilearn/Views/Home/Screens/record.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var pageController = PageController();
  Widget? currentPage;
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  List<Widget> pages = [
    const Note(),
    const Capture(),
    const RecordSession(),
    Profile()
  ];
  Auth logout = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
      bottomNavigationBar: ConvexAppBar(
        height: 70,
        curveSize: 100,
        backgroundColor: kPrimaryColor,
        disableDefaultTabController: true,
        initialActiveIndex: selectedPage,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
          pageController.animateToPage(
            selectedPage,
            duration: const Duration(milliseconds: 450),
            curve: Curves.elasticOut,
          );
        },
        items: const [
          TabItem(
            isIconBlend: true,
            title: "Add Note",
            icon: Icon(
              Icons.note_add,
              size: 24,
            ),
          ),
          TabItem(
            isIconBlend: true,
            title: "Record",
            icon: Icon(
              Icons.record_voice_over_rounded,
              size: 24,
            ),
          ),
          TabItem(
            isIconBlend: true,
            title: "Capture",
            icon: Icon(
              Icons.camera_alt_rounded,
              size: 24,
              color: kPrimaryLightColor,
            ),
          ),
          TabItem(
            isIconBlend: true,
            title: "Profile",
            icon: Icon(
              Icons.person,
              size: 24,
              color: kPrimaryLightColor,
            ),
          )
        ],
      ),
    );
  }
}

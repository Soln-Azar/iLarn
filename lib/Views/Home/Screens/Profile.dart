import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ilearn/Auth/Auth.dart';
import 'package:ilearn/Global/constants.dart';
import 'package:ilearn/Views/Settings/Settings.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.all(48.0),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              radius: 50,
              child: Icon(
                Icons.person,
                size: 60,
              ),
            ),
          ),
          const Divider(
            color: kPrimaryLightColor,
          ),
          // const Text("Profile"),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) {
                      return Settngs();
                    }),
              );
            },
            title: const Text("Settings"),
            leading: const CircleAvatar(
              child: Icon(Icons.app_settings_alt_rounded),
            ),
          ),
          ListTile(
            onTap: () {
              Auth().logoutUser(context);
            },
            title: const Text("Logout"),
            leading: const CircleAvatar(
              child: Icon(Icons.logout),
            ),
          ),
          ListTile(
              onTap: () {
                exit(0);
              },
              title: const Text("Exit App"),
              leading:
                  CircleAvatar(child: const Icon(Icons.exit_to_app_rounded)))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ilearn/Auth/Auth.dart';
import 'package:ilearn/Global/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
          const Text("Profile"),
          ElevatedButton(
            onPressed: () {
              Auth().logoutUser(context);
            },
            child: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}

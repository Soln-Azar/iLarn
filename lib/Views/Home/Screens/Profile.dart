import 'package:flutter/material.dart';
import 'package:ilearn/Auth/Auth.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 400,
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

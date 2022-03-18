import 'package:flutter/material.dart';
import 'package:ilearn/Views/Settings/Model/Needed.dart';

class SetBody extends StatefulWidget {
  SetBody({Key? key}) : super(key: key);

  @override
  State<SetBody> createState() => _SetBodyState();
}

class _SetBodyState extends State<SetBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.image),
          ),
          title: const Text("Image Scanner"),
          onTap: () => showImageSettings(context),
        )
      ],
      // children:SetModel.data,
    );
  }
}

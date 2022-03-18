import 'package:flutter/material.dart';

void showImageSettings(BuildContext context) {
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                children: const [
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.browse_gallery_rounded),
                    ),
                    title: Text("Pick from gallery"),
                  ),
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.camera),
                    ),
                    title: Text("Pick from camera"),
                  )
                ],
              ),
            );
          },
        );
      });
}

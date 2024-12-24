import 'package:flutter/material.dart';

import '../screens/setting_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, size: 50)),
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.transparent,
                builder: (_) => SettingScreen(),
              );
            },
            icon: Icon(Icons.settings, size: 50)),
      ],
    );
  }
}

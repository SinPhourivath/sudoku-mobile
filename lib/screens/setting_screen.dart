import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/theme_notifier.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withValues(alpha: 200),
            ),
          ),
        ),
        Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: themeNotifier.themeMode == ThemeMode.dark
                    ? Colors.grey[900]!.withValues(alpha: 100)
                    : Colors.white.withValues(alpha: 100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Setting",
                      style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 20),
                  Text(
                    "Sound",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: AudioSlider(),
                  // ),
                  SizedBox(height: 20),
                  Text(
                    "Dark mode",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Switch(
                      value: themeNotifier.themeMode == ThemeMode.dark,
                      onChanged: (bool value) {
                        themeNotifier.toggleTheme(value);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

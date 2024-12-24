import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/audio_slider.dart';
import '../services/theme_notifier.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Material( // Wrap everything in a Material widget
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withValues(alpha: 200),
            ),
          ),
          Center(
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: themeNotifier.themeMode == ThemeMode.dark
                    ? Colors.grey[900]
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                    AudioSlider(),
                    SizedBox(height: 20),
                    Text(
                      "Dark mode",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: themeNotifier.themeMode == ThemeMode.dark,
                      onChanged: (bool value) {
                        themeNotifier.toggleTheme(value);
                      },
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


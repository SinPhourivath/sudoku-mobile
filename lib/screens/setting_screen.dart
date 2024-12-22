import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sudoku/widgets/audio_slider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // So basically, I think I need to use the stack because the blur background effect is
    // a continer of its own and the actuall setting is another one
    return Stack(
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
              color: Colors.white,
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
                  Material(
                    child: Switch(
                      value: false,
                      onChanged: (bool value) {},
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

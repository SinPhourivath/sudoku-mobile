import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/theme_notifier.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                color: isDarkMode
                    ? Colors.grey[900]!.withValues(alpha: 100)
                    : Colors.white.withValues(alpha: 100),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Setting",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 30,
                          ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Dark mode",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          color:
                              isDarkMode ? Colors.grey[500] : Colors.grey[800],
                        ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Switch(
                      value: isDarkMode,
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/app_button.dart';
import '../screens/difficulity_screen.dart';
import '../screens/setting_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDarkMode
                  ? [Colors.grey[900]!, Colors.black]
                  : [Colors.blue[50]!, Colors.white],
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (_) => SettingScreen(),
                        );
                      },
                      icon: Icon(Icons.settings, size: 50)),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/nobg_logo.png'),
                        width: 200,
                        color: isDarkMode ? Colors.white : null,
                      ),
                      SizedBox(height: 50),
                      GameButton(
                          text: 'Start Game',
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DifficulityScreen(),
                              ),
                            );
                          }),
                      SizedBox(height: 20),
                      GameButton(
                        text: 'Exit Game',
                        backgroundColor: Colors.red,
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

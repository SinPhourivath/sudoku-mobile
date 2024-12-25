import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/difficulity_screen.dart';
import '../screens/setting_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  ),
                  SizedBox(height: 50),
                  Material(
                    color: Colors.blue,
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: MaterialButton(
                        minWidth: 350,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DifficulityScreen(),
                            ),
                          );
                        },
                        child: Text('Start Game')),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Continue'),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text('Exit Game'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

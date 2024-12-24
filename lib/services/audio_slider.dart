import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioSlider extends StatefulWidget {
  const AudioSlider({super.key});

  @override
  State<StatefulWidget> createState() => _AudioSliderState();
}

class _AudioSliderState extends State<AudioSlider> {
  double _volume = 0.5;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setVolume(_volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Slider(
        value: _volume,
        min: 0.0,
        max: 1.0,
        divisions: 20,
        onChanged: (value) {
          setState(() {
            _volume = value;
            _audioPlayer.setVolume(_volume);
          });
        },
      ),
    );
  }
}

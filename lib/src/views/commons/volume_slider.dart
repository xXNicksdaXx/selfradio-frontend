import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider(this.audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  State<StatefulWidget> createState() => VolumeSliderState();
}

class VolumeSliderState extends State<VolumeSlider> {

  double volume = 100;

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0.0,
      max: 150,
      value: volume,
      onChanged: (newVolume) {
        setState(() {
          volume = newVolume;
        });
        widget.audioPlayer.setVolume(volume * 0.01);
        },
      label: '${volume.round()}%',
      divisions: 30,
    );
  }
}
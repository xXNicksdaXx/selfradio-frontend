import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:selfradio/src/views/commons/player_buttons.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    // set a sequence of audio sources that will be played by the audio player.
    audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/selfradio-f2820.appspot.com/o/105fd7792.mp3?alt=media&token=956063b2-e99f-461b-a5a1-0db508acae34")),
      AudioSource.uri(Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/selfradio-f2820.appspot.com/o/3bfe3fed.mp3?alt=media&token=14f6a743-728f-476d-958b-697cc398ab8e")),
    ]));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PlayerButtons(audioPlayer)
      );
  }
}
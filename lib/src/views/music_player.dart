import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
        child: StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            return playerButton(playerState!);
          },
        ),
      );
  }

  Widget playerButton(PlayerState playerState) {

    // extract processing state
    final state = playerState.processingState;

    if (state == ProcessingState.loading ||
        state == ProcessingState.buffering) {
      // loading
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 64,
        height: 64,
        child: const CircularProgressIndicator(),
      );
    }

    else if (audioPlayer.playing == false) {
      // start playing
      return IconButton(
        icon: const Icon(Icons.play_arrow),
        iconSize: 64,
        onPressed: audioPlayer.play,
      );
    }

    else if (state != ProcessingState.completed) {
      // stop playing via pause
      return IconButton(
        icon: const Icon(Icons.pause),
        iconSize: 64,
        onPressed: audioPlayer.pause,
      );
    }

    else {
      // finished playing
      return IconButton(
        icon: const Icon(Icons.replay),
        iconSize: 64,
        onPressed: () => audioPlayer.seek(Duration.zero,
            index: audioPlayer.effectiveIndices?.first),
      );
    }
  }
}
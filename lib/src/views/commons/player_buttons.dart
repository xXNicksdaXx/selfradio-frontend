import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons(this.audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<bool>(
              stream: audioPlayer.shuffleModeEnabledStream,
              builder: (context, snapshot) {
                return shuffleButton(context, snapshot.data ?? false);
              },
            ),
            StreamBuilder<SequenceState?>(
              stream: audioPlayer.sequenceStateStream,
              builder: (_, __) {
                return previousButton();
              },
            ),
            StreamBuilder<PlayerState>(
              stream: audioPlayer.playerStateStream,
              builder: (_, snapshot) {
                final playerState = snapshot.data;
                return playPauseButton(playerState!);
              },
            ),
            StreamBuilder<SequenceState?>(
              stream: audioPlayer.sequenceStateStream,
              builder: (_, __) {
                return nextButton();
              },
            ),
            StreamBuilder<LoopMode>(
              stream: audioPlayer.loopModeStream,
              builder: (context, snapshot) {
                return repeatButton(context, snapshot.data ?? LoopMode.off);
              },
            ),
            ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<double>(
              stream: audioPlayer.volumeStream,
              builder: (context, snapshot) {
                return MuteButton(audioPlayer);
              },
            ),
            StreamBuilder<double>(
              stream: audioPlayer.volumeStream,
              builder: (context, snapshot) {
                return volumeDownButton(snapshot.data ?? 1);
              },
            ),
            StreamBuilder<double>(
              stream: audioPlayer.volumeStream,
              builder: (context, snapshot) {
                return volumeBar(snapshot.data ?? 1);
              },
            ),
            StreamBuilder<double>(
              stream: audioPlayer.volumeStream,
              builder: (context, snapshot) {
                return volumeUpButton(snapshot.data ?? 1);
              },
            ),
          ],
        )
      ],
    );
  }

  Widget playPauseButton(PlayerState playerState) {
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
        onPressed: () => audioPlayer.seek(
            Duration.zero,
            index: audioPlayer.effectiveIndices?.first
        ),
      );
    }
  }

  Widget previousButton() {
    return IconButton(
        icon: const Icon(Icons.skip_previous),
        onPressed: () async {
          if(audioPlayer.hasPrevious) {
            audioPlayer.seekToPrevious();
          }
        }
    );
  }

  Widget nextButton() {
    return IconButton(
        icon: const Icon(Icons.skip_next),
        onPressed: () {
          if(audioPlayer.hasNext) audioPlayer.seekToNext();
        }
    );
  }

  Widget shuffleButton(BuildContext context, bool isEnabled) {
    Icon shuffle;
    if(isEnabled) {
      shuffle = const Icon(Icons.shuffle, color: Colors.deepOrange);
    } else {
      shuffle = const Icon(Icons.shuffle);
    }
    return IconButton(
      icon: shuffle,
      onPressed: () async {
        if (!isEnabled) {
          await audioPlayer.shuffle();
        }
        await audioPlayer.setShuffleModeEnabled(!isEnabled);
      },
    );
  }

  Widget repeatButton(BuildContext context, LoopMode loopMode) {
    final icons = [
      const Icon(Icons.repeat),
      const Icon(Icons.repeat, color: Colors.deepOrange),
      const Icon(Icons.repeat_one, color: Colors.deepOrange),
    ];
    const cycleModes = [
      LoopMode.off,
      LoopMode.all,
      LoopMode.one,
    ];
    final index = cycleModes.indexOf(loopMode);
    return IconButton(
      icon: icons[index],
      onPressed: () {
        audioPlayer.setLoopMode(
            cycleModes[
              (cycleModes.indexOf(loopMode) + 1) % cycleModes.length
            ]);
      },
    );
  }

  Widget volumeDownButton(double volume) {
    return IconButton(
        icon: const Icon(Icons.volume_down_rounded),
        onPressed: () {
          double currentVolume = audioPlayer.volume;
          if(currentVolume >= 0.1) {
            audioPlayer.setVolume(currentVolume - 0.1);
          }
        }
    );
  }

  Widget volumeUpButton(double volume) {
    return IconButton(
        icon: const Icon(Icons.volume_up_rounded),
        onPressed: () {
          double currentVolume = audioPlayer.volume;
          if(currentVolume <= 1.4) {
            audioPlayer.setVolume(currentVolume + 0.1);
          }
        }
    );
  }

  Widget volumeBar(double volume) {
    return Slider(
      min: 0.0,
      max: 1.5,
      onChanged: (value) => value = volume,
      value: volume,
    );
  }
}

class MuteButton extends StatefulWidget {
  const MuteButton(this.audioPlayer, {Key? key}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  State<StatefulWidget> createState() => MuteButtonState();
}

class MuteButtonState extends State<MuteButton> {

  double volume = 1;

  @override
  Widget build(BuildContext context) {
    Icon mute;
    bool isMuted;
    double currentVolume = widget.audioPlayer.volume;
    if(currentVolume == 0) {
      mute = const Icon(Icons.volume_off_rounded);
      isMuted = true;
    } else {
      mute = const Icon(Icons.volume_mute_rounded);
      isMuted = false;
    }
    return IconButton(
        icon: mute,
        onPressed: () {
          if(isMuted) {
            widget.audioPlayer.setVolume(volume);
          } else {
            volume = widget.audioPlayer.volume;
            widget.audioPlayer.setVolume(0);
          }
        }
    );
  }
}
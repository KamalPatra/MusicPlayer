import 'package:flutter/material.dart';
import 'package:fluttery_audio/fluttery_audio.dart';
import 'package:music_player/radial_seek_bar.dart';
import 'package:music_player/theme.dart';



class AudioRadialSeekBar extends StatefulWidget {

  final String albumArtUrl;

  AudioRadialSeekBar({this.albumArtUrl});

  @override
  AudioRadialSeekBarState createState() => AudioRadialSeekBarState();
}

class AudioRadialSeekBarState extends State<AudioRadialSeekBar> {

  double _seekPercent;

  @override
  Widget build(BuildContext context) {
    return AudioComponent(
      updateMe: [
        WatchableAudioProperties.audioPlayhead,
        WatchableAudioProperties.audioSeeking
      ],
      playerBuilder:
          (BuildContext context, AudioPlayer player, Widget child) {
        double playbackProgress = 0.0;
        if (player.audioLength != null && player.position != null) {
          playbackProgress = player.position.inMilliseconds /
              player.audioLength.inMilliseconds;
        }

        _seekPercent = player.isSeeking ? _seekPercent : null;

        return RadialSeekBar(
            progress: playbackProgress,
            seekPercent: _seekPercent,
            onSeekRequested: (double seekPercent) {
              setState(() => _seekPercent = seekPercent);
              final seekMillis =
              (player.audioLength.inMilliseconds * seekPercent)
                  .round();
              player.seek(Duration(milliseconds: seekMillis));
            },
            child: Container(
              color: accentColor,
              child: Image.network(
                widget.albumArtUrl,
                fit: BoxFit.cover,
              ),
            )
        );
      },
    );
  }
}
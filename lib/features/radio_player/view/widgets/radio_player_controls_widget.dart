import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_player_event.dart';
import 'package:provider/provider.dart';
import 'package:text_scroll/text_scroll.dart';

class FRPPlayerControls extends StatefulWidget {
  final FlutterRadioPlayer flutterRadioPlayer;
  final Function addSourceFunction;
  final Function nextSource;
  final Function prevSource;
  final Function(String status) updateCurrentStatus;

  const FRPPlayerControls({
    super.key,
    required this.flutterRadioPlayer,
    required this.addSourceFunction,
    required this.nextSource,
    required this.prevSource,
    required this.updateCurrentStatus,
  });

  @override
  State<FRPPlayerControls> createState() => _FRPPlayerControlsState();
}

class _FRPPlayerControlsState extends State<FRPPlayerControls> {
  String latestPlaybackStatus = "flutter_radio_stopped";
  String currentPlaying = "N/A";
  double volume = 0.5;
  final nowPlayingTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);
    return StreamBuilder(
      stream: widget.flutterRadioPlayer.frpEventStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FRPPlayerEvents frpEvent =
              FRPPlayerEvents.fromJson(jsonDecode(snapshot.data as String));
          if (kDebugMode) {
            print("====== EVENT START =====");
            print("Playback status: ${frpEvent.playbackStatus}");
            print("Icy details: ${frpEvent.icyMetaDetails}");
            print("Other: ${frpEvent.data}");
            print("====== EVENT END =====");
          }
          if (frpEvent.playbackStatus != null) {
            latestPlaybackStatus = frpEvent.playbackStatus!;
            widget.updateCurrentStatus(latestPlaybackStatus);
          }
          if (frpEvent.icyMetaDetails != null) {
            currentPlaying = frpEvent.icyMetaDetails!;
            nowPlayingTextController.text = frpEvent.icyMetaDetails!;
          }
          var statusIcon = Icons.pause_circle_filled;
          switch (frpEvent.playbackStatus) {
            case "flutter_radio_playing":
              statusIcon = Icons.pause_circle_filled;
              break;
            case "flutter_radio_paused":
              statusIcon = Icons.play_circle_filled;
              break;
            case "flutter_radio_loading":
              statusIcon = Icons.refresh_rounded;
              break;
            case "flutter_radio_stopped":
              statusIcon = Icons.play_circle_filled;
              break;
          }
          return latestPlaybackStatus == "flutter_radio_stopped"
              ?  Center(
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      color: themeData.colorPalette.button,
                    ),
                  ),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextScroll(
                      currentPlaying,
                      textAlign: TextAlign.start,
                      style:
                          themeData.radioAppTextTheme.titleCurrentplaying,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButtonWidget(
                          onTap: () async {
                            widget.flutterRadioPlayer.playOrPause();
                            resetNowPlayingInfo();
                          },
                          icon: statusIcon,
                        ),
                      ],
                    ),
                  ],
                ),
              );
        } else if (latestPlaybackStatus == "flutter_radio_stopped") {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Text("Determining state ...");
      },
    );
  }

  void resetNowPlayingInfo() {
    currentPlaying = "N/A";
  }
}

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);

    return InkWell(
      enableFeedback: false,
      onTap: (onTap),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          size: 50,
          color: themeData.colorPalette.button,
        ),
      ),
    );
  }
}

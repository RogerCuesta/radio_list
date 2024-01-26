import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/features/radio_player/view/widgets/radio_player_info_widget.dart';
import 'package:flutter_radio/models/radio.dart' as radio_model;
import 'package:flutter_radio/theme/theme.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'package:provider/provider.dart';

import 'widgets/radio_player_widget.dart';

class RadioPage extends StatefulWidget {
  final radio_model.Radio radioSelected;
  const RadioPage({super.key, required this.radioSelected});
  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  final FlutterRadioPlayer _flutterRadioPlayer = FlutterRadioPlayer();

  late FRPSource frpSource;

  @override
  void initState() {
    super.initState();
    _flutterRadioPlayer.initPlayer();
    frpSource = FRPSource(
      mediaSources: <MediaSources>[
        MediaSources(
          url: widget.radioSelected.url,
          description: widget.radioSelected.name,
          isPrimary: true,
          title: widget.radioSelected.name,
          isAac: true,
        ),
      ],
    );
    _flutterRadioPlayer.addMediaSources(frpSource);
  }

  @override
  void dispose() {
    super.dispose();
    _flutterRadioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorPalette.seashell,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: themeData.colorPalette.appTitle,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: themeData.colorPalette.seashell,
          child: Column(
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 12,
                  borderOnForeground: false,
                  child: widget.radioSelected.favicon != null &&
                          widget.radioSelected.favicon!.contains(RegExp(
                              r'\b(?:https?|ftp):\/\/[^\s/$.?#].[^\s]*\.(?:png|jpeg)\b'))
                      ? Hero(
                          tag: widget.radioSelected.stationuuid ?? '',
                          child: CachedNetworkImage(
                            imageUrl: widget.radioSelected.favicon!,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey,
                              child: const Center(
                                child: Icon(
                                  Icons.radio,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          color: themeData.colorPalette.appTitle,
                          child: const Center(
                            child: Icon(
                              Icons.radio,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    FRPlayer(
                      flutterRadioPlayer: _flutterRadioPlayer,
                      frpSource: frpSource,
                      useIcyData: true,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RadioPlayerInfoWidget(
                          radioChannel: widget.radioSelected,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

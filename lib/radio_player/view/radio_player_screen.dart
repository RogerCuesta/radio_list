import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/l10n/l10n.dart';
import 'package:flutter_radio/models/radio.dart' as radiomodel;
import 'package:flutter_radio/theme/theme.dart';
import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:flutter_radio_player/models/frp_source_modal.dart';
import 'package:provider/provider.dart';

import 'widgets/radio_player_widget.dart';

class RadioPage extends StatefulWidget {
  final radiomodel.Radio radioSelected;
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
    final l10n = context.l10n;
    final themeData = Provider.of<RadioAppThemeData>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          widget.radioSelected.name!,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff3f51b5), Color(0xff000000)],
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 12,
                  borderOnForeground: false,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.stateText,
                                    style: themeData
                                        .radioAppTextTheme.radioInfoText,
                                  ),
                                  Text(
                                    widget.radioSelected.state!,
                                    style: themeData
                                        .radioAppTextTheme.radioInfoText
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            flex: 2,
                            child: SizedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.votesText,
                                    style: themeData
                                        .radioAppTextTheme.radioInfoText,
                                  ),
                                  Text(
                                    widget.radioSelected.votes!.toString(),
                                    style: themeData
                                        .radioAppTextTheme.radioInfoText
                                        .copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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

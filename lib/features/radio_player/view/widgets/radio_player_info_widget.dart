import 'package:flutter/material.dart';
import 'package:flutter_radio/l10n/l10n.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_radio/models/radio.dart' as radio_model;

class RadioPlayerInfoWidget extends StatelessWidget {
  final radio_model.Radio radioChannel;

  const RadioPlayerInfoWidget({
    super.key,
    required this.radioChannel,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);
    final l10n = context.l10n;

    return Card(
      elevation: 5,
      color: themeData.colorPalette.seashell,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              radioChannel.name!,
              style: themeData.radioAppTextTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Flexible(
              flex: 2,
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.stateText,
                      style: themeData.radioAppTextTheme.radioInfoText,
                    ),
                    Text(
                      radioChannel.state!,
                      style: themeData.radioAppTextTheme.radioInfoText.copyWith(
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.votesText,
                    style: themeData.radioAppTextTheme.radioInfoText,
                  ),
                  Text(
                    radioChannel.votes!.toString(),
                    style: themeData.radioAppTextTheme.radioInfoText.copyWith(
                      fontWeight: FontWeight.w500,
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

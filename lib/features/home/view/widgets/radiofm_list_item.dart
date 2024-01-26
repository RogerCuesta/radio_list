import 'package:flutter/material.dart';
import 'package:flutter_radio/features/home/view/widgets/radiofm_list_item_image.dart';
import 'package:flutter_radio/features/radio_player/radio_player.dart';
import 'package:flutter_radio/models/radio.dart' as radio_model;
import 'package:flutter_radio/theme/theme.dart';
import 'package:flutter_radio/utils/extensions.dart';
import 'package:provider/provider.dart';

class RadioItem extends StatelessWidget {
  final radio_model.Radio radioChannel;
  final int index;
  const RadioItem({
    required this.radioChannel,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RadioPage(
              radioSelected: radioChannel,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          children: [
            Column(
              children: [
                RadioImage(
                  imageUrl: radioChannel.favicon,
                  imageId: radioChannel.stationuuid ?? '',
                )
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    radioChannel.name!,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.radioAppTextTheme.titleCardRadios,
                    maxLines: 2,
                  ),
                  Text(
                    radioChannel.tags != null
                        ? radioChannel.tags!.capitalizeWordsSeparatedByCommas()
                        : '',
                    overflow: TextOverflow.ellipsis,
                    style: themeData.radioAppTextTheme.subTitleCardRaios,
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      radioChannel.votes!.toString(),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.thumb_up,
                      color: themeData.colorPalette.fuchsiarose,
                      size: 15,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

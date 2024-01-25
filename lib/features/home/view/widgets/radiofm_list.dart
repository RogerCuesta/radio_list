import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/features/home/home.dart';
import 'package:flutter_radio/features/home/view/widgets/radiofm_station_item.dart';
import 'package:flutter_radio/models/radio.dart' as radioModel;
import 'package:flutter_radio/features/radio_player/radio_player.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:flutter_radio/utils/extensions.dart';
import 'package:provider/provider.dart';

class RadioList extends StatelessWidget {
  final List<radioModel.Radio> radioList;
  const RadioList({
    required this.radioList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);

    bool loadingMore = context.read<HomeCubit>().state.loadingMore;

    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0) {
          context.read<HomeCubit>().loadMoreRadioChannels();
        }
        return false;
      },
      child: ListView.builder(
        //physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: radioList.length + (loadingMore ? 1 : 0),
        itemBuilder: (BuildContext ctx, index) {
          if (index < radioList.length) {
            radioModel.Radio radioChannel = radioList[index];
            return RadioItem(
              radioChannel: radioChannel,
              index: index,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Icon(Icons.headphones),
              ),
            );
          }
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final radioModel.Radio radioChannel;
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
                ChannelImageCard(
                  imageUrl: radioChannel.favicon,
                  imageId: index.toString() ?? '',
                )
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    radioChannel.name! ?? '-',
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
                      color: themeData.colorPalette.icon,
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



/*   */
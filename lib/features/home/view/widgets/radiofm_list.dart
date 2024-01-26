import 'package:flutter/material.dart';
import 'package:flutter_radio/features/home/home.dart';
import 'package:flutter_radio/features/home/view/widgets/radiofm_list_item.dart';
import 'package:flutter_radio/models/radio.dart' as radio_model;
import 'package:provider/provider.dart';

class RadioList extends StatelessWidget {
  final List<radio_model.Radio> radioList;
  const RadioList({
    required this.radioList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool loadingMore = context.read<HomeCubit>().state.loadingMore;

    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0) {
          context.read<HomeCubit>().loadMoreRadioChannels();
        }
        return false;
      },
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: radioList.length + (loadingMore ? 1 : 0),
        itemBuilder: (BuildContext ctx, index) {
          if (index < radioList.length) {
            radio_model.Radio radioChannel = radioList[index];
            return RadioItem(
              radioChannel: radioChannel,
              index: index,
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Icon(
                  Icons.headphones,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

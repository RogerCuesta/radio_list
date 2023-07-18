import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/models/radio.dart' as radiomodel;
import 'package:flutter_radio/radio_player/radio_player.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:provider/provider.dart';

class RadioList extends StatelessWidget {
  final List<radiomodel.Radio> radioList;
  const RadioList({
    required this.radioList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);

    return SizedBox(
      height: 60 * (radioList.length ~/ 2).toDouble(),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 11,
          ),
          itemCount: radioList.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RadioPage(
                      radioSelected: radioList[index],
                    ),
                  ),
                );
              },
              //Cards Design
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -15,
                      bottom: -10,
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(25 / 360),
                        child: CachedNetworkImage(
                          width: 83,
                          height: 83,
                          imageUrl: radioList[index].favicon!,
                          placeholder: (context, url) => const Center(
                            child: Icon(
                              Icons.radio,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(
                              Icons.radio,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Title Card Radios
                    Padding(
                      padding: const EdgeInsets.only(top: 6, left: 11),
                      child: Text(radioList[index].name!,
                          style: themeData.radioAppTextTheme.titleCardRadios,
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

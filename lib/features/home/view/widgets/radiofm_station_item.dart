import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:provider/provider.dart';

class ChannelImageCard extends StatelessWidget {
  final String? imageUrl;
  final String imageId;
  final bool localImage;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final double borderRadius;
  final double? boxDimension;
  final bool selected;
  final Function(Object, StackTrace?)? localErrorFunction;

  const ChannelImageCard({
    super.key,
    required this.imageUrl,
    required this.imageId,
    this.localImage = false,
    this.elevation = 5,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 7.0,
    this.boxDimension = 55.0,
    this.selected = false,
    this.localErrorFunction,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);

    return CircleAvatar(
      radius: 35,
      backgroundColor: themeData.colorPalette.backgroundColor,
      child: ClipOval(
        child: SizedBox.square(
          dimension: boxDimension!,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildImage(context),
              if (selected) _buildSelectionOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);
    if (imageUrl == null ||
        imageUrl!.contains(
            RegExp(r'(\b(?:https?|ftp):\/\/[^\s/$.?#].[^\s]*\.svg\b)'))) {
      return Icon(
        Icons.radio,
        color: themeData.colorPalette.button,
        size: 30,
      );
    } else {
      return Hero(
        tag: imageId,
        child: CachedNetworkImage(
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Icon(
                  Icons.radio,
                  color: themeData.colorPalette.button,
                  size: 30,
                ),
            imageUrl: imageUrl!,
            filterQuality: FilterQuality.high,
            placeholder: (_, __) => Icon(
                  Icons.radio,
                  color: themeData.colorPalette.button,
                  size: 30,
                )),
      );
    }
  }

  Widget _handleError(
      BuildContext context, Object error, StackTrace? stacktrace) {
    if (localErrorFunction != null) {
      localErrorFunction!(error, stacktrace);
    }
    return const Icon(
      Icons.radio,
      color: Colors.white,
      size: 30,
    );
  }

  Widget _buildSelectionOverlay() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black54,
      ),
      child: const Center(
        child: Icon(
          Icons.check_rounded,
        ),
      ),
    );
  }
}

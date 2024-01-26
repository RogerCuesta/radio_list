import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/features/home/home.dart';
import 'package:flutter_radio/l10n/l10n.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:provider/provider.dart';

class RadioSearchBar extends StatelessWidget {
  const RadioSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);
    final l10n = context.l10n;
    final TextEditingController textController = TextEditingController();

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 55.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(1.5, 1.5),
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10.0),
            Icon(
              CupertinoIcons.search,
              color: themeData.colorPalette.coralpink,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration.collapsed(
                  hintText: l10n.searchText,
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: themeData.colorPalette.appTitle,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                onSubmitted: (String searchTerm) => context
                    .read<HomeCubit>()
                    .loadRadioChannels(
                        searchText: searchTerm, resetPagination: true),
              ),
            ),
            const SizedBox(width: 10.0),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (context.read<HomeCubit>().state.searchText.isNotEmpty) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          textController.clear();
                          context
                              .read<HomeCubit>()
                              .loadRadioChannels(resetPagination: true);
                        },
                        child: Icon(
                          Icons.close,
                          color: themeData.colorPalette.coralpink,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

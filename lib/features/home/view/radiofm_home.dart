import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/features/home/bloc/home_cubit.dart';
import 'package:flutter_radio/features/home/bloc/home_state.dart';
import 'package:flutter_radio/features/home/view/widgets/radiofm_list.dart';
import 'package:flutter_radio/l10n/l10n.dart';
import 'package:flutter_radio/repositories/radio_repository.dart';
import 'package:flutter_radio/theme/theme_data.dart';
import 'package:provider/provider.dart';

import 'widgets/radiofm_searchbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final themeData = Provider.of<RadioAppThemeData>(context);

    return BlocProvider(
      create: (_) => HomeCubit(
        radioRepository: RepositoryProvider.of<RadioRepository>(context),
      )..loadRadioChannels(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.radioAppBarTitle,
          ),
          bottomOpacity: 0.0,
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            color: themeData.colorPalette.seashell,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case RadiosLoadStatus.failed:
                        return const ErrorView();
                      case RadiosLoadStatus.succeeded:
                        return Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 60),
                              state.radioChannels.isNotEmpty
                                  ? Flexible(
                                      child: RadioList(
                                        radioList: state.radioChannels,
                                      ),
                                    )
                                  : Flexible(
                                      child: Center(
                                        child: Text(
                                          l10n.notFoundText,
                                          style: themeData
                                              .radioAppTextTheme.bodyText,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        );
                      case RadiosLoadStatus.loading:
                        return const Flexible(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                    }
                  },
                ),
                const RadioSearchBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<RadioAppThemeData>(context);
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Failed to fetch radios',
              style: themeData.radioAppTextTheme.titleLarge,
            ),
          ),
          MaterialButton(
              child: Icon(
                Icons.replay_circle_filled_rounded,
                color: themeData.colorPalette.fuchsiarose,
                size: 40,
              ),
              onPressed: () {
                context.read<HomeCubit>().loadRadioChannels();
              }),
        ],
      ),
    );
  }
}

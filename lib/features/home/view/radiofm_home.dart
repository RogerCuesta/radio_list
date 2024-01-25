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
  //TextEditingController _textEditingController = TextEditingController();
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
            color: themeData.colorPalette.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
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
                              const SizedBox(height: 10),
                              const RadioSearchBar(),
                              const SizedBox(height: 10),
                              state.radioChannels.isNotEmpty
                                  ? Flexible(
                                      child: RadioList(
                                          radioList: state.radioChannels),
                                    )
                                  : const Center(
                                      child: Text('No radios found'),
                                    ),
                            ],
                          ),
                        );
                      case RadiosLoadStatus.loading:
                        return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
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
    return Column(
      children: [
        const Center(
          child: Text('failed to fetch radios'),
        ),
        MaterialButton(
            child: const Icon(
              Icons.replay_circle_filled_rounded,
            ),
            onPressed: () {
              context.read<HomeCubit>().loadRadioChannels();
            }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/home/bloc/radios_bloc.dart';
import 'package:flutter_radio/home/bloc/radios_event.dart';
import 'package:flutter_radio/home/bloc/radios_state.dart';
import 'package:flutter_radio/home/view/widgets/radiofm_list.dart';
import 'package:flutter_radio/l10n/l10n.dart';
import 'package:flutter_radio/repositories/radio_repository.dart';

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

    return BlocProvider(
      create: (_) => RadiosBloc(
        radioRepository: RepositoryProvider.of<RadioRepository>(context),
      )..add(RadiosGetData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.radioAppBarTitle,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff3f51b5), Color(0xff000000)],
              ),
            ),
            child: Column(
              children: [
                BlocBuilder<RadiosBloc, RadiosState>(
                  builder: (context, state) {
                    switch (state.radiosLoadStatus) {
                      case RadiosLoadStatus.failed:
                        return const ErrorView();
                      case RadiosLoadStatus.succeeded:
                        return Expanded(
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              state.radioList.isNotEmpty
                                  ? Flexible(
                                      child:
                                          RadioList(radioList: state.radioList),
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
              context.read<RadiosBloc>().add(RadiosGetData());
            }),
      ],
    );
  }
}

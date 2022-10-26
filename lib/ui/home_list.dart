import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cripto_list/blocs/coins_bloc.dart';
import 'package:flutter_cripto_list/blocs/coins_event.dart';
import 'package:flutter_cripto_list/blocs/coins_state.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoinsBloc()..add(CoinsGetData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'CoinMarketCap',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              BlocBuilder<CoinsBloc, CoinsState>(
                builder: (context, state) {
                  switch (state.coinsLoadStatus) {
                    case CoinsLoadStatus.failed:
                      return Column(
                        children: [
                          const Center(
                            child: Text('failed to fetch coins'),
                          ),
                          MaterialButton(
                              child: const Icon(
                                Icons.replay_circle_filled_rounded,
                              ),
                              onPressed: () {
                                context.read<CoinsBloc>().add(CoinsGetData());
                              }),
                        ],
                      );
                    case CoinsLoadStatus.succeeded:
                      return Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 24),
                              child: TextFormField(
                                controller: _textEditingController,
                                onEditingComplete: () {
                                  BlocProvider.of<CoinsBloc>(context)
                                      .add(CoinsSearch(
                                    coinName: _textEditingController.text,
                                  ));
                                },
                              ),
                            ),
                            state.coinsList.isNotEmpty
                                ? Flexible(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.coinsList.length,
                                      itemBuilder: ((context, index) {
                                        return Card(
                                          child: ListTile(
                                            leading: Image.network(
                                              state.coinsList[index].image!,
                                              width: 24,
                                              height: 24,
                                            ),
                                            title: Text(
                                                state.coinsList[index].name!),
                                            subtitle: Text(
                                              state.coinsList[index]
                                                  .marketCapRank
                                                  .toString(),
                                            ),
                                            trailing: Text(
                                                "${state.coinsList[index].currentPrice.toString()} \$"),
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No coins found'),
                                  ),
                          ],
                        ),
                      );
                    case CoinsLoadStatus.loading:
                      return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cripto_list/api/api_services.dart';
import 'package:flutter_cripto_list/home/bloc/coins_bloc.dart';
import 'package:flutter_cripto_list/home/bloc/coins_event.dart';
import 'package:flutter_cripto_list/home/bloc/coins_state.dart';
import 'package:flutter_cripto_list/l10n/l10n.dart';
import 'package:flutter_cripto_list/models/coin.dart';
import 'package:flutter_cripto_list/repositories/coingecko_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocProvider(
      create: (_) => CoinsBloc(
        coingeckoRepository:
            RepositoryProvider.of<CoingeckoRepository>(context),
      )..add(CoinsGetData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.cryptoListAppBarTitle,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  l10n.homeTitle,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              BlocBuilder<CoinsBloc, CoinsState>(
                builder: (context, state) {
                  switch (state.coinsLoadStatus) {
                    case CoinsLoadStatus.failed:
                      return const ErrorView();
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
                                    child:
                                        CoinsList(coinsList: state.coinsList),
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

class CoinsList extends StatelessWidget {
  final List<Coin> coinsList;
  const CoinsList({
    required this.coinsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: coinsList.length,
      itemBuilder: ((context, index) {
        return Card(
          child: ListTile(
            leading: Image.network(
              coinsList[index].image!,
              width: 24,
              height: 24,
            ),
            title: Text(coinsList[index].name!),
            subtitle: Text(
              coinsList[index].marketCapRank.toString(),
            ),
            trailing: Text("${coinsList[index].currentPrice.toString()} \$"),
          ),
        );
      }),
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
  }
}

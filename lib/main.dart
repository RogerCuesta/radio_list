import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cripto_list/api/coingecko/coingecko_api.dart';
import 'package:flutter_cripto_list/home/view/home_list.dart';
import 'package:flutter_cripto_list/l10n/l10n.dart';
import 'package:flutter_cripto_list/repositories/coingecko_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CoingeckoService>(
          create: (_) => CoingeckoService(),
        ),
      ],
      child: _RepositoryInitializer(
        child: MaterialApp(
          title: 'Flutter Demo',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
        ),
      ),
    );
  }
}

class _RepositoryInitializer extends StatelessWidget {
  final Widget child;
  const _RepositoryInitializer({
    required this.child,
  }) : super();

  @override
  Widget build(BuildContext context) {
    final coingeckoService =
        Provider.of<CoingeckoService>(context, listen: false);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => CoingeckoRepository(
            coingeckoService: coingeckoService,
          ),
        ),
      ],
      child: child,
    );
  }
}

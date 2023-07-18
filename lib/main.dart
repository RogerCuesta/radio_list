import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio/api/radiofm/radiofm_api.dart';
import 'package:flutter_radio/home/view/radiofm_home.dart';
import 'package:flutter_radio/l10n/l10n.dart';
import 'package:flutter_radio/repositories/radio_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_radio/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RadioService>(
          create: (_) => RadioService(),
        ),
      ],
      child: _RepositoryInitializer(
        child: Provider(
            create: (_) => RadioAppThemeData.light(),
            child: Builder(builder: (context) {
              return MaterialApp(
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
                locale: const Locale('es'),
                theme:
                    Provider.of<RadioAppThemeData>(context).materialThemeData,
                home: const MyHomePage(),
              );
            })),
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
    final radioService = Provider.of<RadioService>(context, listen: false);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => RadioRepository(
            radioService: radioService,
          ),
        ),
      ],
      child: child,
    );
  }
}

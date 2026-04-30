import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/atividade_controller.dart';
import 'controllers/configuracao_controller.dart';
import 'controllers/navegacao_controller.dart';
import 'views/splash_view.dart';

void main() {
  runApp(const FitLifeApp());
}

class FitLifeApp extends StatelessWidget {
  const FitLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AtividadeController()),
        ChangeNotifierProvider(create: (_) => ConfiguracaoController()),
        ChangeNotifierProvider(create: (_) => NavegacaoController()),
      ],
      child: Consumer<ConfiguracaoController>(
        builder: (context, configuracaoController, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fit Life',
            themeMode: configuracaoController.model.temaEscuro
                ? ThemeMode.dark
                : ThemeMode.light,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF3A7D44),
                brightness: Brightness.light,
              ),
              scaffoldBackgroundColor: const Color(0xFFF7F7F2),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6CC070),
                brightness: Brightness.dark,
              ),
            ),
            home: const SplashView(),
          );
        },
      ),
    );
  }
}

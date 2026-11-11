import 'package:flutter/material.dart';
import 'package:pasar_splindid_app/core/widgets/shared_widgets.dart';
import 'package:pasar_splindid_app/features/auth/presentation/pages/login_screen.dart';

class PasarSplendidApp extends StatelessWidget {
  const PasarSplendidApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Pasar Splendid',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: canvas,
          colorScheme: ColorScheme.fromSeed(seedColor: forest),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: ink, fontSize: 13),
            titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w700),
          ),
        ),
        home: const LoginPage(),
      );
}

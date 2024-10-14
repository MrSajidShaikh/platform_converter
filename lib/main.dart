import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/Provider/lec_2.1_provider.dart';
import 'package:platform_converter/Provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/platform_change_provider.dart';
import 'Provider/platform_provider.dart';
import 'Screen/cupertino_ui.dart';
import 'Screen/material_ui.dart';

bool isDark = false;
bool isIos = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  isDark = sharedPreferences.getBool("theme") ?? false;
  isIos = sharedPreferences.getBool("platform") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Lec2Provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PlatFormProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeController(isDark),
        ),
        ChangeNotifierProvider(
          create: (context) => PlatformChangeProvider(isIos),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTheme = Provider.of<ThemeController>(context);
    return (!Provider.of<PlatformChangeProvider>(context).isIos)
        ? MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (providerTheme.isDark)
          ? providerTheme.themeDark
          : providerTheme.themeLight,
      home: const MaterialUi(),
    )
        : CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: (providerTheme.isDark)
          ? providerTheme.cupertinoThemeDark
          : providerTheme.cupertinoThemeLight,
      home: const CupertinoUi(),
    );
  }
}
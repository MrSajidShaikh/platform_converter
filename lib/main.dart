import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/provider_homepage.dart';
import 'package:platform_converter_app/view/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ProviderHomepage(),
      builder:(context, child) =>  MaterialApp(
        themeMode: Provider.of<ProviderHomepage>(context, listen: true).isDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home:const HomePage(),
      ),
    );
  }
}

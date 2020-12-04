import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/page/home_page.dart';
import 'package:qr_scan/page/map_page.dart';
import 'package:qr_scan/providers/ui_provider.dart';

import 'providers/scan_list_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UiProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScanListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'QR-scan',
        initialRoute: 'home',
        routes: {'home': (_) => HomePage(), 'map': (_) => MapPage()},
        theme: ThemeData(
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple)),
      ),
    );
  }
}

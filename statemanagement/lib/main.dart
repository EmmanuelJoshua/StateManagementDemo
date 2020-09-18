import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement/providers/themeprovider.dart';
import 'package:statemanagement/screens/homepage.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => ThemeProvider(), child: AppStart()));
}

class AppStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(themeProvider: themeProvider);
  }
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;

  MyApp({this.themeProvider});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: widget.themeProvider.themeData(),
      home: HomePage(),
    );
  }
}

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:embedding_web/theme_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const ChangeableThemeApp(),
    ),
  );
}

class ChangeableThemeApp extends StatelessWidget {
  const ChangeableThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) {
        final color = notifier.currentTheme;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: color)),
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    if (kReleaseMode) {
      final export = createJSInteropWrapper(this);
      globalContext['_appState'] = export;
    }
  }

  @JSExport()
  void onSelected(String? themeName) {
    if (themeName != null) {
      context.read<ThemeNotifier>().setTheme(themeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownMenu(
              initialSelection: 'red',
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 'red', label: 'Red'),
                DropdownMenuEntry(value: 'orange', label: 'Orange'),
                DropdownMenuEntry(value: 'yellow', label: 'Yellow'),
                DropdownMenuEntry(value: 'green', label: 'Green'),
                DropdownMenuEntry(value: 'blue', label: 'Blue'),
                DropdownMenuEntry(value: 'purple', label: 'Purple'),
              ],
              inputDecorationTheme: const InputDecorationTheme(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onSelected: onSelected,
            ),
          ],
        ),
      ),
    );
  }
}

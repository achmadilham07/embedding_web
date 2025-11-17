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
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @JSExport()
  void onSelected(String? themeName) {
    if (themeName != null) {
      context.read<ThemeNotifier>().setTheme(themeName);
      // Update the dropdown value with capitalized theme name
      controller.text = themeName[0].toUpperCase() + themeName.substring(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryFixed,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: <Widget>[
            Text(
              'Pilih warna untuk mengubah tema aplikasi Flutter.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            DropdownMenu(
              controller: controller,
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

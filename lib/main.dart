import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

import 'package:brazil_finance_indicators/widgets/indicators_widget.dart';
import 'package:brazil_finance_indicators/services/indicators_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IndicatorsService()..initialize(),
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
    return MaterialApp(
      title: 'Brazil Indicators',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _showFloatingWidget(BuildContext context) async {
    bool permission = await FlutterOverlayWindow.isPermissionGranted();

    if (!permission) {
      await FlutterOverlayWindow.requestPermission();
    }

    if (await FlutterOverlayWindow.isPermissionGranted()) {
      FlutterOverlayWindow.showOverlay(
        height: 250,
        width: 220,
        alignment: OverlayAlignment.centerRight,
        enableDrag: true,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissão negada para overlay.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brazil Economic Indicators'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => Provider.of<IndicatorsService>(context, listen: false).fetchData(),
          ),
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: 'Mostrar flutuante',
            onPressed: () => _showFloatingWidget(context),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              IndicatorsWidget(),
              SizedBox(height: 20),
              Text('Data updates automatically every 4 hours'),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
import 'package:brazil_finance_indicators/services/indicators_service.dart';
import 'package:brazil_finance_indicators/widgets/indicators_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isOverlayActive = false;

  @override
  void initState() {
    super.initState();
    _checkOverlayStatus();
  }

  Future<void> _checkOverlayStatus() async {
    final status = await FlutterOverlayWindow.isActive();
    setState(() {
      _isOverlayActive = status;
    });
  }

  Future<void> _toggleFloatingWidget() async {
    try {
      if (_isOverlayActive) {
        await FlutterOverlayWindow.closeOverlay();
        setState(() => _isOverlayActive = false);
        return;
      }

      // Verificação de permissão corrigida
      bool hasPermission =
          await FlutterOverlayWindow.isPermissionGranted() ?? false;

      if (!hasPermission) {
        hasPermission = await FlutterOverlayWindow.requestPermission() ?? false;
      }

      if (hasPermission) {
        await FlutterOverlayWindow.showOverlay(
          height: 250,
          width: 220,
          alignment: OverlayAlignment.centerRight,
          enableDrag: true,
          flag: OverlayFlag.defaultFlag,
        );

        setState(() => _isOverlayActive = true);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Permissão negada para exibir overlay'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicadores Econômicos do Brasil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Atualizar dados',
            onPressed: () => Provider.of<IndicatorsService>(
              context,
              listen: false,
            ).fetchData(),
          ),
          IconButton(
            icon: Icon(_isOverlayActive ? Icons.close : Icons.open_in_new),
            tooltip: _isOverlayActive ? 'Fechar overlay' : 'Abrir overlay',
            onPressed: _toggleFloatingWidget,
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
              Text('Os dados são atualizados automaticamente a cada 4 horas'),
              SizedBox(height: 10),
              Text(
                'Toque no ícone de overlay para exibir os indicadores\nem uma janela flutuante',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

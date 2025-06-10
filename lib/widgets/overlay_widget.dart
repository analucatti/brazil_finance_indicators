import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:provider/provider.dart';
import 'package:brazil_finance_indicators/services/indicators_service.dart';

class OverlayIndicatorsWidget extends StatelessWidget {
  const OverlayIndicatorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<IndicatorsService>(context);

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () {
          // Fechar overlay ao tocar fora
          FlutterOverlayWindow.closeOverlay();
        },
        child: Container(
          color: Colors.transparent,
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      spreadRadius: 1),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Indicadores 🇧🇷',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green),
                  ),
                  const SizedBox(height: 8),
                  _row('SELIC', service.selic),
                  _row('IPCA', service.ipca),
                  _row('IPCA Acum.', service.ipcaAcumulado),
                  _row('Dólar', service.dolar),
                  const SizedBox(height: 8),
                  Text(
                    'Atualizado: ${service.updateDate}',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getValueColor(value),
          ),
        ),
      ],
    ),
  );

  Color _getValueColor(String value) {
    if (value.contains('Erro')) return Colors.red;
    return Colors.black;
  }
}
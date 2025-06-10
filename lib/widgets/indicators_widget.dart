import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brazil_finance_indicators/services/indicators_service.dart';

class IndicatorsWidget extends StatelessWidget {
  const IndicatorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<IndicatorsService>(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Brazil Economic Indicators',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildIndicatorRow('SELIC:', service.selic),
          const SizedBox(height: 8),
          _buildIndicatorRow('IPCA:', service.ipca),
          const SizedBox(height: 8),
          _buildIndicatorRow('IPCA Acumulado no Ano:', service.ipcaAcumulado),
          const SizedBox(height: 8),
          _buildIndicatorRow('Dólar (hoje):', service.dolar),
          if (service.updateDate.isNotEmpty) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Updated: ${service.updateDate}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicatorRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

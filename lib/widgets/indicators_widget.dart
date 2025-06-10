import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brazil_finance_indicators/services/indicators_service.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class IndicatorsWidget extends StatelessWidget {
  const IndicatorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<IndicatorsService>(context);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '📊 Indicadores Econômicos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildIndicatorRow('SELIC', service.selic, Mdi.chart_line_variant),
          _buildIndicatorRow('IPCA', service.ipca, Mdi.trending_up),
          _buildIndicatorRow('IPCA Acumulado', service.ipcaAcumulado, Mdi.chart_bar),
          _buildIndicatorRow('Dólar Hoje', service.dolar, Mdi.currency_usd),

          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Atualizado em: ${service.updateDate}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorRow(String label, String value, String icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Iconify(icon, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

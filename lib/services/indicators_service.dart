import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IndicatorsService with ChangeNotifier {
  String _selic = 'Carregando...';
  String _ipca = 'Carregando...';
  String _ipcaAcumulado = 'Carregando...';
  String _dolar = 'Carregando...';
  String _updateDate = '';
  Timer? _timer;

  String get selic => _selic;
  String get ipca => _ipca;
  String get ipcaAcumulado => _ipcaAcumulado;
  String get dolar => _dolar;
  String get updateDate => _updateDate;

  void initialize() {
    loadData();
    fetchData();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(hours: 4), (timer) {
      fetchData();
    });
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _selic = prefs.getString('selic') ?? 'Carregando...';
    _ipca = prefs.getString('ipca') ?? 'Carregando...';
    _ipcaAcumulado = prefs.getString('ipcaAcumulado') ?? 'Carregando...';
    _dolar = prefs.getString('dolar') ?? 'Carregando...';
    _updateDate = prefs.getString('updateDate') ?? '';
    notifyListeners();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selic', _selic);
    await prefs.setString('ipca', _ipca);
    await prefs.setString('ipcaAcumulado', _ipcaAcumulado);
    await prefs.setString('dolar', _dolar);
    await prefs.setString('updateDate', _updateDate);
  }

  Future<void> fetchData() async {
    try {
      final responses = await Future.wait([
        http.get(Uri.parse('https://api.bcb.gov.br/dados/serie/bcdata.sgs.432/dados/ultimos/1?formato=json')),
        http.get(Uri.parse('https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados/ultimos/1?formato=json')),
        http.get(Uri.parse('https://api.bcb.gov.br/dados/serie/bcdata.sgs.13522/dados/ultimos/1?formato=json')),
        http.get(Uri.parse('https://economia.awesomeapi.com.br/json/last/USD-BRL')),
      ]);

      if (responses.every((r) => r.statusCode == 200)) {
        final selicData = json.decode(responses[0].body);
        final ipcaData = json.decode(responses[1].body);
        final ipcaAcumuladoData = json.decode(responses[2].body);
        final dolarData = json.decode(responses[3].body);

        _selic = '${double.parse(selicData[0]['valor']).toStringAsFixed(2)}%';
        _ipca = '${double.parse(ipcaData[0]['valor']).toStringAsFixed(2)}%';
        _ipcaAcumulado = '${double.parse(ipcaAcumuladoData[0]['valor']).toStringAsFixed(2)}%';
        _dolar = 'R\$ ${double.parse(dolarData['USDBRL']['bid']).toStringAsFixed(2)}';
        _updateDate = _formatDate(selicData[0]['data']);

        await saveData();
        notifyListeners();
      } else {
        _setErrorState();
      }
    } catch (e) {
      _setErrorState();
    }
  }

  void _setErrorState() {
    _selic = 'Erro';
    _ipca = 'Erro';
    _ipcaAcumulado = 'Erro';
    _dolar = 'Erro';
    _updateDate = 'Falha na atualização';
    notifyListeners();
  }

  String _formatDate(String date) {
    try {
      final parts = date.split('-');
      return '${parts[2]}/${parts[1]}/${parts[0]}';
    } catch (e) {
      return date;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
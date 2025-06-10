import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IndicatorsService with ChangeNotifier {
  String _selic = 'Loading...';
  String _ipca = 'Loading...';
  String _ipcaAcumulado = 'Loading...';
  String _dolar = 'Loading...';
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
    _timer = Timer.periodic(const Duration(hours: 4), (timer) {
      fetchData();
    });
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _selic = prefs.getString('selic') ?? 'Loading...';
    _ipca = prefs.getString('ipca') ?? 'Loading...';
    _ipcaAcumulado = prefs.getString('ipcaAcumulado') ?? 'Loading...';
    _dolar = prefs.getString('dolar') ?? 'Loading...';
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
      final selicResponse = await http.get(Uri.parse(
          'https://api.bcb.gov.br/dados/serie/bcdata.sgs.432/dados/ultimos/1?formato=json'));

      final ipcaResponse = await http.get(Uri.parse(
          'https://api.bcb.gov.br/dados/serie/bcdata.sgs.433/dados/ultimos/1?formato=json'));

      final ipcaAcumuladoResponse = await http.get(Uri.parse(
          'https://api.bcb.gov.br/dados/serie/bcdata.sgs.13522/dados/ultimos/1?formato=json'));

      final dolarResponse = await http.get(Uri.parse(
          'https://economia.awesomeapi.com.br/json/last/USD-BRL'));

      if (selicResponse.statusCode == 200 &&
          ipcaResponse.statusCode == 200 &&
          ipcaAcumuladoResponse.statusCode == 200 &&
          dolarResponse.statusCode == 200) {

        final selicData = json.decode(selicResponse.body);
        final ipcaData = json.decode(ipcaResponse.body);
        final ipcaAcumuladoData = json.decode(ipcaAcumuladoResponse.body);
        final dolarData = json.decode(dolarResponse.body);

        _selic = '${double.parse(selicData[0]['valor']).toStringAsFixed(2)}%';
        _ipca = '${double.parse(ipcaData[0]['valor']).toStringAsFixed(2)}%';
        _ipcaAcumulado = '${double.parse(ipcaAcumuladoData[0]['valor']).toStringAsFixed(2)}%';
        _dolar = 'R\$ ${double.parse(dolarData['USDBRL']['bid']).toStringAsFixed(2)}';
        _updateDate = selicData[0]['data'];

        await saveData();
        notifyListeners();
      }
    } catch (e) {
      _selic = 'Error';
      _ipca = 'Error';
      _ipcaAcumulado = 'Error';
      _dolar = 'Error';
      _updateDate = 'Update failed';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

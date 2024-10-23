import 'package:flutter/material.dart';
import 'package:aplikasi_api/service/currency_service.dart';

class CurrencyConverterHome extends StatefulWidget {
  @override
  _CurrencyConverterHomeState createState() => _CurrencyConverterHomeState();
}

class _CurrencyConverterHomeState extends State<CurrencyConverterHome> {
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  final _amountController = TextEditingController();
  double? _convertedAmount;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _convertCurrency() async {
    final fromCurrency = _fromController.text.toUpperCase();
    final toCurrency = _toController.text.toUpperCase();
    final amount = double.tryParse(_amountController.text);

    if (fromCurrency.isEmpty || toCurrency.isEmpty || amount == null) {
      setState(() {
        _errorMessage = 'Please enter valid currencies and amount.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final result =
        await CurrencyService.convertCurrency(fromCurrency, toCurrency, amount);

    setState(() {
      _isLoading = false;
      if (result.error != null) {
        _errorMessage = result.error!;
      } else {
        _convertedAmount = result.convertedAmount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fromController,
              decoration: InputDecoration(
                labelText: 'From Currency',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To Currency',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _convertCurrency,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Convert'),
            ),
            SizedBox(height: 20.0),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (_convertedAmount != null)
              Text(
                'Converted Amount: $_convertedAmount',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

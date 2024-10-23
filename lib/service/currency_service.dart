import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  static const String _apiKey =
      'fca_live_b6JOWQGoe2jCR1zjEVOxLw6xdMrdoAPk5DmsxBnD';
  static const String _apiUrl = 'https://api.freecurrencyapi.com/v1/latest';

  static Future<CurrencyResult> convertCurrency(
      String fromCurrency, String toCurrency, double amount) async {
    final url = Uri.parse(
        '$_apiUrl?apikey=$_apiKey&currencies=$toCurrency&base_currency=$fromCurrency');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final exchangeRate = data['data'][toCurrency];

        return CurrencyResult(convertedAmount: amount * exchangeRate);
      } else {
        return CurrencyResult(
          error: 'Error: ${response.statusCode} - ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      return CurrencyResult(error: 'An error occurred: $e');
    }
  }
}

class CurrencyResult {
  final double? convertedAmount;
  final String? error;

  CurrencyResult({this.convertedAmount, this.error});
}

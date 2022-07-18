import "dart:convert";
import "package:http/http.dart" as http;

import '../models/currency.dart';
import '../models/data_error.dart';

class CryptoRepository {
  static const String _baseUrl = "https://min-api.cryptocompare.com/";
  final http.Client _httpClient;

  CryptoRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<CryptoCurrency>> getCurrencies() async {
    const requestUrl =
        '${_baseUrl}data/top/totalvolfull?limit=25&tsym=USD&page=0';
    try {
      final response = await _httpClient.get(Uri.parse(requestUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        final coinList = List.from(data['Data']);
        return coinList.map((coin) => CryptoCurrency.fromMap(coin)).toList();
      }
      return [];
    } catch (err) {
      throw DataError(message: err.toString());
    }
  }
}

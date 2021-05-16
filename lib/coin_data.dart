import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String apiKey = "FA3B235D-27B3-4EE6-A7D5-F472CAB4AABB";
  String coinApiUrl = "https://rest.coinapi.io/v1/exchangerate";

  //This method returns the equivalent of 1 unit of the normal currency to the crypto currency given by parameter.
  Future<double> getCoinExchangeRate(
      {@required String cryptoCurrency,
      @required String normalCurrency}) async {
    http.Response response = await http
        .get("$coinApiUrl/$cryptoCurrency/$normalCurrency?apikey=$apiKey");
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["rate"];
    } else {
      print(
          "There was an error trying to retreive the data from the url. Status code = " +
              response.statusCode.toString());
    }
  }
}

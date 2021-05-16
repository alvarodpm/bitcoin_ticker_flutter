import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'AUD';

  String conversion = "0";

  DropdownButton<String> getAndroidPicker() {
    List<DropdownMenuItem<String>> dropDownCurrencies = [];
    for (int i = 0; i < currenciesList.length; i++) {
      dropDownCurrencies.add(
        DropdownMenuItem<String>(
          child: Text(currenciesList[i]),
          value: currenciesList[i],
        ),
      );
    }

    return DropdownButton<String>(
      onChanged: (String value) {
        setState(
          () {
            selectedCurrency = value;
            getData();
          },
        );
      },
      items: dropDownCurrencies,
      value: selectedCurrency,
    );
  }

  CupertinoPicker getiOSPicker() {
    List<Text> textCurrencies = [];
    for (String currency in currenciesList) {
      textCurrencies.add(Text(currency));
    }

    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (int selectedIndex) {
        setState(
          () {
            selectedCurrency = textCurrencies[selectedIndex].data;
            getData();
          },
        );
      },
      children: textCurrencies,
    );
  }

  Widget getPicker() {
    if (Platform.isAndroid) {
      return getAndroidPicker();
    } else if (Platform.isIOS) {
      return getiOSPicker();
    }
  }

  void getData() async {
    double rate = await coinData.getCoinExchangeRate(
        cryptoCurrency: "BTC", normalCurrency: selectedCurrency);
    conversion = rate.round().toString();
  }

  @override
  void initState() {
    super.initState();
    setState(
      () {
        getData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $conversion $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

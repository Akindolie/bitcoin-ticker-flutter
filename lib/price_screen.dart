import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  var coinRate;

  Map<String, String> coinInfo = {};

  bool isWaiting = false;

  void updateUI(String currency) async {
    isWaiting = true;
    try {
      CoinData coinData = CoinData(currency);
      var data = await coinData.getCoinData();
      print(currency);
      setState(() {
        coinInfo = data;
        print(coinInfo);
      });
    } catch (e) {
      print(e);
    }
    isWaiting = false;
  }

  DropdownButton<String> andriodPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            updateUI(selectedCurrency);
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      dropdownItems.add(newItem);
    }

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: dropdownItems,
    );
  }

  // void generateDataBox() {
  //   for (String coin in cryptoList) {}
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI(selectedCurrency);
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
          CryptoCard(
            coinRate: isWaiting ? '?' : coinInfo['BTC'],
            crypto: 'BTC',
            currency: selectedCurrency,
          ),
          CryptoCard(
            coinRate: isWaiting ? '?' : coinInfo['ETH'],
            crypto: 'ETH',
            currency: selectedCurrency,
          ),
          CryptoCard(
            coinRate: isWaiting ? '?' : coinInfo['LTC'],
            crypto: 'LTC',
            currency: selectedCurrency,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : andriodPicker(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final String currency;
  final String coinRate;
  final String crypto;

  CryptoCard({this.currency, this.coinRate, this.crypto});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $crypto = $coinRate $currency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

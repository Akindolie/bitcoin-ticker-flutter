import 'services/networking.dart';

const apiKey = '0B627219-7DF9-4B92-B8E4-99F8997AD1F6';
const coinApi = 'https://rest.coinapi.io/v1/exchangerate/';

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
  String currency;
  CoinData(this.currency);

  Future<dynamic> getCoinData() async {
    Map<String, String> cryptoData = {};
    for (String crypto in cryptoList) {
      String url = '$coinApi$crypto/$currency?apiKey=$apiKey';
      NetworkHelper networkHelper = NetworkHelper(url);
      //print(url);
      var coinData = await networkHelper.getData();
      double data = coinData['rate'];
      cryptoData[crypto] = data.toStringAsFixed(0);
    }

    return cryptoData;
  }
}

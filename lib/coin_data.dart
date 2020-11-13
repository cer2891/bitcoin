import 'package:http/http.dart' as http;
import 'dart:convert';

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

const URL='https://blockchain.info/ru/ticker';

class CoinData {

  Future getCoinData(select) async{
    String requestURL=URL;
    http.Response response=await http.get(requestURL);
    if(response.statusCode==200){
      var decodeData=jsonDecode(response.body);
      var lastPrise=decodeData['$select']['last'];
      print(lastPrise);
      return lastPrise;
    }else{
      print(response.statusCode);
      throw 'Problem request';
    }
  }

}

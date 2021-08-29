import 'package:myfirstapp/models/allcurrencies.dart';
import 'package:myfirstapp/models/ratesmodel.dart';
import 'package:myfirstapp/utils/key.dart';
import 'package:http/http.dart' as http;

Future<Ratesmodel> fetchrates() async {

  var response = await http.get(Uri.parse(
      'http://api.exchangeratesapi.io/v1/latest?access_key=' + key));
  final result = ratesmodelFromJson(response.body);
  return result;
}

Future<Map> fetchcurrencies() async {
  var response = await http.get(Uri.parse(
      'https://openexchangerates.org/api/currencies.json?app_id=' + key));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

String convertany(Map exchangeRates, String amount, String currencybase,
    String currencyfinal) {
  String output = (double.parse(amount) /
      exchangeRates[currencybase] *
      exchangeRates[currencyfinal])
      .toStringAsFixed(2)
      .toString();

  return output;
}
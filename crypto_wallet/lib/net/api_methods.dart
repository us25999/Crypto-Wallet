
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var url = "http://api.coingecko.com/api/v3/coins/" +  id;
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var value = json['market_data']['current_price']['inr'].toString();
    return double.parse(value);
  } catch(e) {
    // ignore: avoid_print
    print(e.toString());
    return 0.0;
  }
}
Future getCurrentUser()async{
  return await FirebaseAuth.instance.currentUser;
}
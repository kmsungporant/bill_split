import 'package:http/http.dart' as http;

import '../models/Bill.dart';

class request {
  static Future<http.Response> postBill(Bill bill) async {
    return await http.post(
        Uri.parse("http://127.0.0.1:5000/parse_items"), // https://bestphat0409.pythonanywhere.com
        body: bill.toString());
  }

  static Future<http.Response> getBill() async {
    return await http
        .get(Uri.parse("https://bestphat0409.pythonanywhere.com/parse_items"));
  }
}

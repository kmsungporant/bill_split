import 'package:http/http.dart' as http;

import '../models/Bill.dart';

class request {
  static Future<http.Response> postBill(Bill bill) async {
    return await http.post(
        Uri.parse("https://bestphat0409.pythonanywhere.com/parse_items"),
        body: bill.toString());
  }

  static Future<http.Response> getBill() async {
    return await http
        .get(Uri.parse("https://bestphat0409.pythonanywhere.com/parse_items"));
  }
}

import 'dart:convert';

import 'package:trashtrace/data/models/dustbin.dart';
import 'package:http/http.dart' as http;

class TrashTraceBackend {
  static const String root =
      'https://5425-2405-201-d036-284f-9db7-a90a-6e3a-ba8.ngrok-free.app/';

  Future<List<Dustbin>> getAllBins() async {
    List<Dustbin> dustbins = [];
    final uri = Uri.parse("$root/binocculars/get_all");
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final resdata = jsonDecode(res.body);
      for (final x in resdata) {
        final d = Dustbin.fromJson(x);
        dustbins.add(d);
      }
    }
    return dustbins;
  }

  Future<List<Dustbin>> getProximalBins({
    required double lat,
    required double lng,
    required double radius,
  }) async {
    List<Dustbin> dustbins = [];
    final uri = Uri.parse("$root/binocculars/get_proximal/$lat/$lng/$radius");
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final resdata = jsonDecode(res.body);
      for (final x in resdata) {
        final d = Dustbin.fromJson(x);
        dustbins.add(d);
      }
    }
    return dustbins;
  }
}

import 'dart:convert';

import 'package:trashtrace/data/models/dustbin.dart';
import 'package:http/http.dart' as http;

class TrashTraceBackend {
  static const String root =
      'https://3711-2405-201-d036-284f-9db7-a90a-6e3a-ba8.ngrok-free.app';

  Future<bool> register(
      {required String name,
      required String username,
      required String password}) async {
    final uri = Uri.parse("$root/user/register");
    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
          {'name': name, 'username': username, 'password': password}),
    );
    if (res.statusCode == 200) {
      return true;
    }
    print('ERROR => ${res.body}');
    return false;
  }

  Future<bool> login(
      {required String username, required String password}) async {
    final uri = Uri.parse("$root/user/login");
    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {'username': username, 'password': password},
      ),
    );
    if (res.statusCode == 200) {
      return true;
    }
    print('ERROR => ${res.body}');
    return false;
  }

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

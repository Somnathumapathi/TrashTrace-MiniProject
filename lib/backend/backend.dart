import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtrace/data/models/dustbin.dart';
import 'package:http/http.dart' as http;

Future<String> getServerLink() async {
  final prefs = await SharedPreferences.getInstance();
  final srvr = prefs.getString('server_root_link');
  return srvr ??
      'https://5ca9-2405-201-d036-284f-9db7-a90a-6e3a-ba8.ngrok-free.app';
}

Future<void> setServerLink(String link) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('server_root_link', link);
}

class TrashTraceBackend {
  Future<bool> register(
      {required String name,
      required String username,
      required String password}) async {
    final root = await getServerLink();
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
    final root = await getServerLink();
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
    final root = await getServerLink();

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
    final root = await getServerLink();
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

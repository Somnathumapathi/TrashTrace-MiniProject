import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trashtrace/data/models/dustbin.dart';
import 'package:http/http.dart' as http;

class ResponseType<T> {
  T result;
  String message;

  ResponseType({
    required this.result,
    required this.message,
  });
}

Future<String> getServerLink() async {
  final prefs = await SharedPreferences.getInstance();
  final srvr = prefs.getString('server_root_link');
  return srvr ?? 'https://trash-trace-backend.vercel.app';
}

Future<void> setServerLink(String link) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('server_root_link', link);
}

class TrashTraceBackend {
  Future<ResponseType<bool>> register(
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
      return ResponseType(result: true, message: 'success');
    }
    print('ERROR => ${res.body}');
    return ResponseType(result: true, message: res.body.toString());
  }

  Future<ResponseType<bool>> login(
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
      final resdata = jsonDecode(res.body);
      final succ = resdata['success'] ?? false;
      if (succ) {
        return ResponseType(result: true, message: 'success');
      } else {
        print("ERROR ===> ${resdata['message']}");
        return ResponseType(result: false, message: resdata['message']);
      }
    }
    print('ERROR => ${res.body}');
    return ResponseType(result: false, message: res.body);
  }

  Future<ResponseType<int?>> getIDFromUsername(String uname) async {
    final root = await getServerLink();
    final uri = Uri.parse("$root/user/get_id_by_username/$uname");
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final resdata = jsonDecode(res.body);
      return ResponseType(
        result: resdata['id'],
        message: 'success',
      );
    }
    return ResponseType(
      result: null,
      message: 'Server Side Error (${res.statusCode})',
    );
  }

  Future<ResponseType<List<Dustbin>?>> getAllBins() async {
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
    } else {
      return ResponseType(
        result: null,
        message: 'Server Side Error (${res.statusCode})',
      );
    }
    return ResponseType(result: dustbins, message: 'success');
  }

  Future<ResponseType<List<Dustbin>?>> getProximalBins({
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
    } else {
      return ResponseType(
        result: null,
        message: 'Server Side Error (${res.statusCode})',
      );
    }
    return ResponseType(result: dustbins, message: 'success');
  }

  // ====================== (RCX) ============================

  Future<ResponseType<List<Map>?>> getRCXPartners(
      {String filter = 'all'}) async {
    final root = await getServerLink();

    List<Map> partners = [];
    final uri = Uri.parse("$root/recyclx/getpartners/$filter");
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final resdata = jsonDecode(res.body);
      for (final x in resdata) {
        partners.add(x);
      }
    } else {
      return ResponseType(
        result: null,
        message: 'Server Side Error (${res.statusCode}) => ${res.body}',
      );
    }
    return ResponseType(result: partners, message: 'success');
  }

  Future<ResponseType<List<Map>?>> getAllMyJobs(int userId) async {
    final root = await getServerLink();

    List<Map> jobs = [];
    final uri = Uri.parse("$root/recyclx/myjobs/$userId");
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      final resdata = jsonDecode(res.body);
      for (final x in resdata) {
        jobs.add(x);
      }
    } else {
      return ResponseType(
        result: null,
        message: 'Server Side Error (${res.statusCode}) => ${res.body}',
      );
    }
    return ResponseType(result: jobs, message: 'success');
  }

  Future<ResponseType<int?>> requestJob({
    required String name,
    required String status,
    required LatLng loc,
    required int userId,
    required int partnerId,
  }) async {
    final root = await getServerLink();
    final uri = Uri.parse("$root/recyclx/book_job");
    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          'name': name,
          'status': status,
          'lat': loc.latitude,
          'lng': loc.longitude,
          'uid': userId,
          'pid': partnerId
        },
      ),
    );
    if (res.statusCode == 200) {
      final resdata = jsonDecode(res.body);
      final succ = resdata['success'] ?? false;
      if (succ) {
        return ResponseType(result: resdata['id'], message: 'success');
      } else {
        print("ERROR ===> ${resdata['message']}");
        return ResponseType(result: null, message: resdata['message']);
      }
    }
    print('ERROR => ${res.body}');
    return ResponseType(result: null, message: res.body);
  }
}

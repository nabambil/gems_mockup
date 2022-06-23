import 'package:flutter/foundation.dart';
import 'package:mockup_gems/utils/preference.dart';
import 'package:mockup_gems/utils/repository/header.dart';
import 'package:http/http.dart' as http;

class Network<T> extends Pref with Header {
  final Uri url;
  final String imageLink;
  final Map<String, dynamic> param;

  Network(String link, {this.imageLink, this.param})
      : this.url = Uri.parse(link);

  Future<List<T>> get list async {
    try {
      final response = await http.get(url);
      return [];
    } catch (e) {
      throw e;
    }
  }

  Future<T> get json async {
    try {
      final a = header;
      return {} as T;
    } catch (e) {
      throw e;
    }
  }

  Future<T> get string async {
    try {
      return "" as T;
    } catch (e) {
      throw e;
    }
  }

  Future<T> get updateState async {
    try {
      return true as T;
    } catch (e) {
      throw e;
    }
  }

  Future<T> get updateValue async {
    try {
      return {} as T;
    } catch (e) {
      throw e;
    }
  }

  Future<T> get upload async {
    try {
      return true as T;
    } catch (e) {
      throw e;
    }
  }
}

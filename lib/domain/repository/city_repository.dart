import 'dart:convert';
import 'package:city_finder/core/model/city.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CityRepository {
  final Dio _dio = Dio();
  final String _cacheKey = 'cached_cities';

  Future<List<City>> getCities({String? search}) async {
    try {
      final response = await _dio.get(
        'https://odigital.pro/locations/cities/',
        queryParameters: {'search': search},
      );

      final cities =
          (response.data as List).map((e) => City.fromJson(e)).toList();
      await _cacheCities(cities);
      return cities;
      
    } catch (e) {
      return await _getCachedCities() ?? [];
    }
  }

  Future<void> _cacheCities(List<City> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final cityJsonList =
        cities.map((city) => jsonEncode(city.toJson())).toList();
    prefs.setStringList(_cacheKey, cityJsonList);
  }

  Future<List<City>?> _getCachedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final cityJsonList = prefs.getStringList(_cacheKey);
    if (cityJsonList != null) {
      return cityJsonList
          .map(
              (city) => City.fromJson(jsonDecode(city) as Map<String, dynamic>))
          .toList();
    }
    return null;
  }
}

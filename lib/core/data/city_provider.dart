
import 'package:city_finder/core/model/city.dart';
import 'package:city_finder/domain/repository/city_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cityRepositoryProvider = Provider((ref) => CityRepository());

final selectedCitiesProvider = StateProvider<List<City>>((ref) => []);

final cityListProvider = StateNotifierProvider<CityListNotifier, List<City>>((ref) {
  final cityRepository = ref.read(cityRepositoryProvider);
  return CityListNotifier(cityRepository);
});

class CityListNotifier extends StateNotifier<List<City>> {
  final CityRepository _cityRepository;

  CityListNotifier(this._cityRepository) : super([]);

  Future<void> fetchCities({String? search}) async {
    final cities = await _cityRepository.getCities(search: search);
    state = cities;
  }
}


import 'package:city_finder/core/model/city.dart';
import 'package:city_finder/domain/repository/city_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cityRepositoryProvider = Provider((ref) => CityRepository());

final cityListProvider = FutureProvider<List<City>>((ref) async {
  final cityRepository = ref.read(cityRepositoryProvider);
  return cityRepository.getCities();
});
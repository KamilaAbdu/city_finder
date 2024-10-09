import 'package:city_finder/core/model/city.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/data/city_provider.dart';

class CityListView extends HookConsumerWidget {
  final List<City> cities;

  CityListView({required this.cities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredCities =
        cities.where((city) => !city.name.startsWith('name_ru_')).toList();

    return ListView.builder(
      itemCount: filteredCities.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: ListTile(
            title: Text(
              filteredCities[index].name,
              style: TextStyle(color: Colors.brown),
            ),
            onTap: () {
              final selectedCities = ref.read(selectedCitiesProvider);
              if (!selectedCities.contains(filteredCities[index])) {
                ref.read(selectedCitiesProvider.notifier).state = [
                  ...selectedCities,
                  filteredCities[index]
                ];
              }
            },
          ),
        );
      },
    );
  }
}

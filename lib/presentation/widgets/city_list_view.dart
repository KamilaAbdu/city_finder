import 'package:city_finder/core/model/city.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/data/city_provider.dart';

class CityListView extends HookConsumerWidget {
  final List<City> cities;

  CityListView({required this.cities});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: ListTile(
            title: Text(
              cities[index].name,
              style: TextStyle(color: Colors.brown),
            ),
            onTap: () {
              // Чтение текущего состояния selectedCities
              final selectedCities = ref.read(selectedCitiesProvider);

              // Проверка, добавлен ли уже выбранный город
              if (!selectedCities.contains(cities[index])) {
                // Обновление состояния выбранных городов
                ref.read(selectedCitiesProvider.notifier).state = [
                  ...selectedCities,
                  cities[index]
                ];
              }
            },
          ),
        );
      },
    );
  }
}

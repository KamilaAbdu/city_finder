import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/data/city_provider.dart';

class SelectedCitiesList extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCities = ref.watch(selectedCitiesProvider);

    if (selectedCities.isEmpty) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Выбранные города:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          Wrap(
            spacing: 8.0,
            children: selectedCities.map((city) {
              return Chip(
                label: Text(city.name),
                backgroundColor: Colors.orangeAccent.shade100,
                labelStyle: TextStyle(color: Colors.brown),
                deleteIcon: Icon(Icons.close, color: Colors.brown),
                onDeleted: () {
                  ref.read(selectedCitiesProvider.notifier).state =
                      selectedCities.where((c) => c != city).toList();
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/data/city_provider.dart';

class CitySearchField extends HookConsumerWidget {
  final TextEditingController controller;

  CitySearchField({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: (value) {
          ref.read(cityListProvider.notifier).fetchCities(search: value);
        },
        decoration: InputDecoration(
          labelText: 'Поиск города',
          labelStyle: TextStyle(color: Colors.brown),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orangeAccent),
          ),
        ),
      ),
    );
  }
}

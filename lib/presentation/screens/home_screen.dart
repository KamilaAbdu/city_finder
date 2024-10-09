import 'package:city_finder/presentation/widgets/selected_cities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/data/city_provider.dart';
import '../widgets/city_list_view.dart';
import '../widgets/city_search_field.dart';

class HomeScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityList = ref.watch(cityListProvider);
    final searchController = useTextEditingController();

    useEffect(() {
      ref.read(cityListProvider.notifier).fetchCities();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('Найди свой город', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        color: Colors.orange.shade50,
        child: Column(
          children: [
            CitySearchField(controller: searchController),
            SelectedCitiesList(),
            Expanded(
              child: cityList.isEmpty
                  ? Center(
                      child: Text(
                        'Нет доступных городов',
                        style: TextStyle(color: Colors.brown),
                      ),
                    )
                  : CityListView(cities: cityList),
            ),
          ],
        ),
      ),
    );
  }
}

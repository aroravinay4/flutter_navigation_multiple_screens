import 'package:flutter/material.dart';
import 'package:food_flutter_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> filterData;

  FilterScreen(this.filterData, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var glutenFree = false;
  var vegetarian = false;
  var vegan = false;
  var lactoseFree = false;

  @override
  initState() {
    glutenFree = widget.filterData['gluten'];
    lactoseFree = widget.filterData['lectose'];
    vegan = widget.filterData['vegan'];
    vegetarian = widget.filterData['vegetarian'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      var currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter Screen',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, bool> filters = {
                'gluten': glutenFree,
                'lectose': lactoseFree,
                'vegan': vegan,
                'vegetarian': vegetarian
              };
              widget.saveFilters(filters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile('Gluten free',
                    'Only include gluten free meals.', glutenFree, (newValue) {
                  setState(() {
                    glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Lactose free',
                    'Only include lactose free meals.',
                    lactoseFree, (newValue) {
                  setState(() {
                    lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'vegan ', 'Only include vegan meals.', vegan, (newValue) {
                  setState(() {
                    vegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'vegetarian', 'Only include vegetarian meals.', vegetarian,
                    (newValue) {
                  setState(() {
                    vegetarian = newValue;
                  });
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  // const FiltersScreen({super.key, required this.saveFIlter});

  static const routeName = '/filters';
  final Function saveFIlter;
  final Map<String, bool> currentFilter;

  FiltersScreen(this.currentFilter, this.saveFIlter);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateVal) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updateVal);
  }

  @override
  void initState() {
    // TODO: implement initState
    _glutenFree = widget.currentFilter['gluten']!;
    _lactoseFree = widget.currentFilter['lactose']!;
    _vegan = widget.currentFilter['vegan']!;
    _vegetarian = widget.currentFilter['vegetarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter',
        ),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFIlter = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFIlter(selectedFIlter);
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            child: Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile('Gluten-Free',
                      'Only include gluten free meal', _glutenFree, (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegetarian',
                      'Only include vegetarian free meal',
                      _vegetarian, (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only include vegan meal', _vegan, (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  }),
                  _buildSwitchListTile('Loctose Free',
                      'Only include gluten free meal', _lactoseFree, (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

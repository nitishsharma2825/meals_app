import 'package:flutter/material.dart';
import '../widgets/MainDrawer.dart';

class FilterScreen extends StatefulWidget {
  final Function setFilters;
  final Map<String,bool> curFilters;
  FilterScreen(this.setFilters,this.curFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool glutonFree = false;
  bool lactoseFree = false;
  bool isVegan = false;
  bool isVeg = false;
  @override
  void initState(){
    glutonFree = widget.curFilters['gluten'];
    lactoseFree=widget.curFilters['lactose'];
    isVegan = widget.curFilters['vegan'];
    isVeg = widget.curFilters['veg'];
    super.initState();
  }
  Widget buildSwitchListTile(
      String title, String subTitle, bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten':glutonFree,
                'lactose':lactoseFree,
                'vegan':isVegan,
                'veg':isVeg
              };
              widget.setFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your filters'),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile(
                  'Gluten-Free',
                  'Only include Gluten-Free meals',
                  glutonFree,
                  (value) {
                    setState(() {
                      glutonFree = value;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Lactose-Free',
                  'Only include Lactose-Free meals',
                  lactoseFree,
                  (value) {
                    setState(() {
                      lactoseFree = value;
                    });
                  },
                ),
                buildSwitchListTile(
                  'isVegan',
                  'Only include vegan meals',
                  isVegan,
                  (value) {
                    setState(() {
                      isVegan = value;
                    });
                  },
                ),
                buildSwitchListTile(
                  'isVegetarian',
                  'Only include vegetarian meals',
                  isVeg,
                  (value) {
                    setState(() {
                      isVeg = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

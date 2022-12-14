// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:meal_app/screens/fliters_screen.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'dummy_data.dart';
import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteeMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteeMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteeMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteeMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteeMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(
                    20,
                    51,
                    51,
                    1,
                  ),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(
                    20,
                    51,
                    51,
                    1,
                  ),
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotCondensed',
                ),
              )),
      // home: CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(favoriteMeals: _favoriteeMeals),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScrenn.routeName: (context) =>
            MealDetailScrenn(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: ((context) =>
            FiltersScreen(_filters, _setFilters)),
      },
      //routes not registred
      onGenerateRoute: ((settings) {
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      }),

      //for 404 request
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: ((context) => CategoryMealScreen(_availableMeals)));
      },
    );
  }
}

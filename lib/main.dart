import 'package:flutter/material.dart';
import 'package:food_flutter_app/dummy-data.dart';
import 'package:food_flutter_app/models/meal.dart';
import 'package:food_flutter_app/screens/categories_screen.dart';
import 'package:food_flutter_app/screens/category_meals_screen.dart';
import 'package:food_flutter_app/screens/filter_screen.dart';
import 'package:food_flutter_app/screens/meal_detail_screen.dart';
import 'package:food_flutter_app/screens/tabs_screen.dart';

import 'screens/bottom_tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lectose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoritesMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      availableMeals = DUMMY_MEALS.where((meals) {
        if (filters['gluten'] && !meals.isGlutenFree) {
          return false;
        }
        if (filters['lectose'] && !meals.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meals.isVegan) {
          return false;
        }

        if (filters['vegetarian'] && !meals.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _addFavorites(String mealId) {
    final existingIndex =
        favoritesMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        favoritesMeals.removeAt(existingIndex);
      });
    } else {
      favoritesMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
  }

  bool isMealFavorite(String mealId) {
    return favoritesMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold))),
      // home: CategoriesScreen(),
      routes: {
        //'/': (ctx) => CategoriesScreen(),
        // '/': (ctx) => TabsScreen(),
        '/': (ctx) => BottomTabScreen(favoritesMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_addFavorites,isMealFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(filters, _setFilters)
      },
    );
  }
}

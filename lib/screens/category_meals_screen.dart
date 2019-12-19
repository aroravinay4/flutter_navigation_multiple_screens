import 'package:flutter/material.dart';
import 'package:food_flutter_app/models/meal.dart';
import 'package:food_flutter_app/widgets/meal_item.dart';
import '../dummy-data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> mealsList;
  var initData = false;

  @override
  void initState() {
    // init state not work when you required context related work in init state because init state called so early before
    //creating the widget

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (initData == false) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final id = routeArgs['id'];
      mealsList = widget.availableMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      initData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      mealsList.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: mealsList[index].id,
            title: mealsList[index].title,
            imageUrl: mealsList[index].imageUrl,
            duration: mealsList[index].duration,
            complexity: mealsList[index].complexity,
            affordability: mealsList[index].affordability,
           // removeItem: removeMeal,
          );
        },
        itemCount: mealsList.length,
      ),
    );
  }
}

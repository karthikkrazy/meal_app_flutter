import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:meal_app/models/meal.dart';
import '../widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favorites yet - start adding some!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, i) {
          return MealItem(
            id: favoriteMeals[i].id,
            title: favoriteMeals[i].title,
            imageUrl: favoriteMeals[i].imageUrl,
            duration: favoriteMeals[i].duration,
            complexity: favoriteMeals[i].complexity,
            affordability: favoriteMeals[i].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}

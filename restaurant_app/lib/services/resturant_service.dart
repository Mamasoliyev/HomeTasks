import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchRestaurants() async {
    List<Map<String, dynamic>> restaurantsList = [];

    QuerySnapshot restaurantSnapshot = await _firestore.collection('restaurants').get();

    for (var restaurantDoc in restaurantSnapshot.docs) {
      Map<String, dynamic> restaurantData = restaurantDoc.data() as Map<String, dynamic>;
      restaurantData['id'] = restaurantDoc.id;

      // Ovqatlarni olish
      QuerySnapshot foodsSnapshot = await restaurantDoc.reference.collection('foods').get();
      List<Map<String, dynamic>> foods = foodsSnapshot.docs.map((doc) {
        Map<String, dynamic> foodData = doc.data() as Map<String, dynamic>;
        foodData['id'] = doc.id;
        return foodData;
      }).toList();

      restaurantData['foods'] = foods;
      restaurantsList.add(restaurantData);
    }

    return restaurantsList;
  }
}

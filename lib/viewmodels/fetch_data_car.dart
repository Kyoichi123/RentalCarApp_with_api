import 'package:rental_app/models/Car_data.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class Repository {
  final String apiUrl = "https://restapicar-default-rtdb.firebaseio.com/rentalmobil.json";

  Future<List<Car>> fetchDataCar() async {
    Response response = await http.get(Uri.parse(apiUrl));
    List<Car> dataCar;
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      dataCar = jsonData.values.map((value) {
        return Car.fromJson(value);
      }).toList();
  print(dataCar);
      return dataCar;
    } else {
      throw Exception('Failed to load data places');
    }
  }
}
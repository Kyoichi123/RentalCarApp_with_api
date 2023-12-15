import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/views/desk2.dart';
import 'package:rental_app/views/login.dart';
import 'package:rental_app/models/Car_data.dart';
import 'package:rental_app/viewmodels/fetch_data_car.dart';
import 'package:rental_app/views/profile.dart';

class list_mobil extends StatelessWidget {
  const list_mobil({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/daftar_mobil',
      routes: {
        '/daftar_mobil': (context) => MyHomePage(),
        // '/deskripsi_mobil': (context) => DeskripsiMobil(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Repository repo = Repository();
  final List<Car> cars = [];
  final List<String> carImages = [
    'assets/images/ALL.png',
    'assets/images/audi.png',
    'assets/images/BMW.png',
    'assets/images/daihatsu.png',
    'assets/images/lamborghini.png',
    'assets/images/marcedes.png',
    'assets/images/toyota.png',
    'assets/images/jaguar.png',
    'assets/images/ferrari.png',
    'assets/images/honda.png',
  ];

  final List<String> carBrands = [
    'Semua Merek',
    'Audi',
    'BMW',
    'Daihatsu',
    'Lamborghini',
    'Mercedes',
    'Toyota',
    'Jaguar',
    'Ferrari',
    'Honda',
  ];
  String selectedBrand = '';

  get http => null;
  void showCarsByBrand(String brand) {
    setState(() {
      selectedBrand = brand == 'Semua Merek' ? '' : brand;
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Car> searchResults = [];
  String searchQuery = '';

  void performSearch(String query) {
    final lowercaseQuery = query.toLowerCase();
    searchResults = cars.where((car) {
      final lowercaseName = car.name.toLowerCase();
      return lowercaseName.contains(lowercaseQuery);
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bg1.jpg',
            width: 500,
            height: 300,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                            SizedBox(width: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lokasi Anda',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Lowokwaru, Malang',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));
                          },
                          child: CircleAvatar(
                            radius: 23,
                            backgroundImage:
                                AssetImage('assets/images/profil.jpg'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Cari mobil',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                    performSearch(value);
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(7),
                child: Text(
                  'Pilih Merk Mobil :',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: carImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showCarsByBrand(carBrands[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedBrand == carBrands[index]
                                ? Colors.black
                                : Colors.transparent,
                            width: 5,
                          ),
                        ),
                        child: Image.asset(carImages[index]),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                  child: FutureBuilder<List<dynamic>>(
                      future: repo.fetchDataCar(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            color: const Color.fromARGB(255, 231, 231, 231),
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final car = snapshot.data![index];

                                // final car =
                                //     searchQuery.isEmpty ? cars[index] : searchResults[index];
                                const textStyle = TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 255, 254, 254),
                                  shadows: [
                                    Shadow(
                                        offset: Offset(1, 1),
                                        color: Colors.black)
                                  ],
                                );
                                return GestureDetector(
                                  onTap: () {
                                    // Navigasi ke halaman deskripsi dengan membawa data mobil terkait
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DeskripsiMobil1(carData: car),
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    child: Card(
                                      elevation: 10.0,
                                      margin: const EdgeInsets.all(17.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            car.image,
                                            width: double.infinity,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 25, 27, 30),
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  car.name,
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        offset: Offset(1, 1),
                                                        color: Colors.black,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Text(
                                                      car.price1Hari,
                                                      style: textStyle,
                                                    ),
                                                    const SizedBox(width: 4),
                                                    const Expanded(
                                                      child: Text(
                                                        '/Hari',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          shadows: [
                                                            Shadow(
                                                              offset:
                                                                  Offset(1, 1),
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })),
            
            ],
          ),
        ],
      ),
    );
  }
}

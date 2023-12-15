import 'package:flutter/material.dart';
import 'package:rental_app/viewmodels/fetch_data_car.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   Repository repo = Repository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User LIST'),
      ),
      body: Container(
        child: FutureBuilder<List<dynamic>>(
          future: repo.fetchDataCar(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(snapshot.data[index].image),
                      ),
                      title: Text(snapshot.data[index].merek +
                          "\n" +
                          snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].price),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
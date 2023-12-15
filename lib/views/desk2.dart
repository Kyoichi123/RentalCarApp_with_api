import 'package:flutter/material.dart';
import 'package:rental_app/models/Car_data.dart';

class DeskripsiMobil1 extends StatefulWidget {
  final Car carData;

  const DeskripsiMobil1({Key? key, required this.carData}) : super(key: key);

  @override
  _DeskripsiMobil1State createState() => _DeskripsiMobil1State();
}

class _DeskripsiMobil1State extends State<DeskripsiMobil1> {
  String? selectedPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carData.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Nama Mobil di atas gambar
            Text(
              widget.carData.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Gambar Mobil
            Image.network(
              widget.carData.image,
              height: 200, // Adjust the height as needed
            ),
            // Pilih Harga Sewa
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pilih Harga Sewa:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Container dengan pilihan harga
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildPriceOption('1 Hari', widget.carData.price1Hari),
                  buildPriceOption('1 Bulan', widget.carData.price),
                  buildPriceOption('6 Bulan', widget.carData.price6Bulan),
                ],
              ),
            ),
            // Deskripsi
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Deskripsi:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.carData.description,
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Button Rental Sekarang
            ElevatedButton(
  onPressed: () {
    showRentalPopup();
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.blue, // Set the button color
    onPrimary: Colors.white, // Set the text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Set button border radius
    ),
    padding: EdgeInsets.symmetric(vertical: 15.0), // Set vertical padding
  ),
  child: Text(
    'Rental Sekarang',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  // Widget untuk membangun pilihan harga
  Widget buildPriceOption(String label, String price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: selectedPrice == label ? Colors.black : Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPrice = label;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selectedPrice == label ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(
                  fontSize: 17,
                  color:
                      selectedPrice == label ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method untuk menampilkan popup
  void showRentalPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rental Confirmation'),
          content: Text(
              'Anda yakin ingin melakukan rental sekarang dengan harga ${selectedPrice ?? "belum dipilih"}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup popup
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Implement logic for rental confirmation
                // You can add your logic here
                Navigator.of(context).pop(); // Tutup popup setelah rental
              },
              child: Text('Rental'),
            ),
          ],
        );
      },
    );
  }
}

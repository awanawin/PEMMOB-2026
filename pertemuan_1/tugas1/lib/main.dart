import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Perkenalan',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Kartu Perkenalan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Foto / Ikon
              Icon(
                Icons.person,
                size: 100,
                color: Colors.blue,
              ),

              SizedBox(height: 20),

              // Nama
              Text(
                'Gunawan Nastiar',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              // NIM
              Text(
                'NIM: 20240801114',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 10),

              // Jurusan
              Text(
                'Jurusan: Teknik Informatika',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              SizedBox(height: 10),

              // Hobi
              Text(
                'Hobi: Coding dan Bermain Game',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
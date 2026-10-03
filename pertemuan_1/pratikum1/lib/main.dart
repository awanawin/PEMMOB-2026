import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 1',
      //CENTER BAGIAN STATELESS
      home: Scaffold(
        appBar: AppBar(title: const Text('Hello Flutter')),backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.flutter_dash, size: 80, color: Colors.white),
              SizedBox(height: 16),
              Text('Halo, nama saya Gunawan Nastiar!', style: TextStyle(fontSize: 24,color: Colors.blue,)),
              Text('NIM: 20240801114'),
              Expanded(
                  child: CounterPage()
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});
  @override
  State<CounterPage> createState() => _CounterPageState();
}
class _CounterPageState extends State<CounterPage> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Saya')),backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Text('$_count', style: const TextStyle(fontSize: 48,color: Colors.blue,)),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TOMBOL TAMBAH
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: const Icon(Icons.add),
          ),

          const SizedBox(height: 10),

          // TOMBOL KURANG
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_count > 0) {
                  _count--;
                }
              });
            },
            child: const Icon(Icons.remove),
          ),

          const SizedBox(height: 10),

          // TOMBOL RESET
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _count = 0;
              });
            },
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

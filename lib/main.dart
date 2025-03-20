import 'package:flutter/material.dart';
import 'storage/storage.dart';
import 'storage/counter.dart';

void main() => runApp(const CounterApp());

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Счетчик с сохранением',
      debugShowCheckedModeBanner: false,
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _currentCount = 0;
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    _initializeCounter();
  }

  Future<void> _initializeCounter() async {
    final counter = await _storageService.loadCounter();
    setState(() {
      _currentCount = counter.count;
    });
  }

  Future<void> _updateCounter() async {
    setState(() {
      _currentCount++;
    });
    await _storageService.saveCounter(CounterModel(count: _currentCount));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2P1.11.25')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Clicked:', style: TextStyle(fontSize: 24)),
            Text('$_currentCount', style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
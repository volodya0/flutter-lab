// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<Map<String, dynamic>> fetchWeatherData([String? query]) async {
    query ??= 'Lviv';
    String url = '$APIurl/forecast?access_key=$APIkey&query=$query';

    var response = await http.get(url);
    var result = json.decode(response.body);

    return result;
  }

  List<String> parseData(data) {
    List<String> result = [];

    result.add('Location: ${data['location']['name']}');
    result.add('Time: ${data['location']['localtime']}');
    result.add('Temperature: ${data['current']['temperature']}');
    result.add('Wind spreed: ${data['current']['wind_speed']}');
    result.add('Wind spreed: ${data['current']['wind_speed']}');
    result.add('Pressure: ${data['current']['pressure']}');

    return result;
  }

  Future<List<String>> getData() async {
    Map<String, dynamic> data = await fetchWeatherData();
    List<String> parsedData = parseData(data);

    return parsedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: FutureBuilder<List<String>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Row(
                      children: [
                        Text(
                          snapshot.data[index],
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

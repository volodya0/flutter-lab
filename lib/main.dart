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
            primarySwatch: Colors.purple,
          ),
          home: const HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<String>? currentData;
  String city = 'Lviv';

  _HomePageState();

  Future<Map<String, dynamic>>? fetchWeatherData() async {
    String url = '$APIurl/forecast?access_key=$APIkey&query=$city';

    var response = await http.get(url);
    var result = json.decode(response.body);

    return result;
  }

  List<String> parseData(data) {
    List<String> result = [];

    result.add(
        'Location: ${data['location']['name']}, ${data['location']['country']}');
    result.add('Time: ${data['location']['localtime']}');
    result.add(
        'Temperature: ${data['current']['temperature']}, feels like ${data['current']['feelslike']}');
    result.add('Wind spreed: ${data['current']['wind_speed']}');
    result.add('Wind spreed: ${data['current']['visibility']}');
    result.add('Pressure: ${data['current']['pressure']}');

    return result;
  }

  void getData() async {
    Map<String, dynamic>? data = await fetchWeatherData();

    if (data == null || data['success'] == false) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    List<String> parsedData = parseData(data);

    setState(() {
      currentData = parsedData;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
        ),
        body: Column(children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(
                    width: 200,
                    child: TextFormField(
                      onChanged: (value) {
                        city = value;
                      },
                      initialValue: city,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentData = null;
                            isLoading = true;
                            getData();
                          });
                        },
                        child: const Text('Show weather')))
              ])),
          Padding(
              padding: const EdgeInsets.all(10),
              child: currentData != null
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: currentData!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    currentData![index],
                                    textAlign: TextAlign.left,
                                  ))
                            ],
                          ),
                        );
                      })
                  : Center(
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('The weather will appear here')))
        ]));
  }
}

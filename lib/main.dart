import 'dart:convert';

import 'package:dogo/model/model.dart';
import 'package:dogo/pay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Dogo());
}

class Dogo extends StatefulWidget {
  const Dogo({super.key});

  @override
  State<Dogo> createState() => _DogoState();
}

class _DogoState extends State<Dogo> {
  Future<Dogmodel> getData() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breed/eskimo/images'));
    if (response.statusCode == 200) {
      return Dogmodel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("could not fetch data");
    }
  }

  late Future<Dogmodel> get;
  @override
  void initState() {
    super.initState();
    get = getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Pay':(context) => const Pay(),
      },
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Dogmodel>(
              future: get,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  List dogRange = snapshot.data!.message.sublist(0,9);
                  int dogRangelen = dogRange.length;
                  return ListView.builder(
                      itemCount: dogRangelen,
                      itemBuilder: (context, index) {
                        
                         return Column(
                           children: [
                             Card(
                              margin: EdgeInsets.all(8.0),
                              elevation: 4,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                        snapshot.data!.message[index]),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Breed:"),
                                        Text("Dog Breed")
                                      ],
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Amount:"),
                                        Text("Dog Amount")
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Adopt:"),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  shape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      2))),
                                              onPressed: () {
                                                Navigator.pushNamed(context, '/Pay');
                                              },
                                              child: const Text("Pay"))
                                        ])
                                  ],
                                ),
                              ),
                                                         ),
                           ],
                         );
                      });
                } else {
                  print("Error: ${snapshot.error}");
                  throw Exception("Could not fetch data");
                }
              }),
        ),
      ),
    );
  }
}


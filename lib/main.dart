import 'dart:convert';
import 'dart:math';

import 'package:dogo/model/model.dart';
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
Future getData() async{ 
  final response = await http.post(Uri.parse('https://dog.ceo/api/breed/'),
  headers: {"content-type":"application/json"}
  );
  if (response.statusCode == 200) {
    return Dogmodel.fromJson(json.decode(response.body));
  }else{
    throw Exception("could not fetch data");
  }
}
late Future<Dogmodel?>? get;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(children: [
            Card(
              margin: EdgeInsets.all(8.0),
              elevation: 4,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  FutureBuilder(future: get, builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }else if(snapshot.hasData){
                    return Image.asset(snapshot.data!.message);
                    }else{
                      throw Exception("Could not fetch data");
                    }
                  }),
                  
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Breed:"),Text("Dog Breed")],),
                  const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Amount:"),Text("Dog Amount")],),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Adopt:"),ElevatedButton(style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2))), onPressed: (){}, child: const Text("Pay"))])
                ],),
              ),
            )
          ],),
        ),
      ),
    );
  }
}

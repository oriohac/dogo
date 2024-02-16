
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
TextEditingController namecontroller  = TextEditingController();
TextEditingController emailcontroller  = TextEditingController();
TextEditingController phonecontroller  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
          child: Form(child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                child: Container(
                  decoration: BoxDecoration(
                  ),
                  height: 48,
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText:"Fullname" ,
                  filled: true,
                  fillColor: Colors.white,
                    suffixIcon: Icon(Icons.draw),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                    controller: namecontroller,
                  )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                child: Container(
                  decoration: BoxDecoration(
                  ),
                  height: 48,
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                  
                    hintText:"Email" ,
                  filled: true,
                  fillColor: Colors.white,
                    suffixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                    controller: emailcontroller,
                  )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                child: Container(
                  decoration: BoxDecoration(
                  ),
                  height: 48,
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText:"Phone Number" ,
                  filled: true,
                  fillColor: Colors.white,
                    suffixIcon: Icon(Icons.phone_android),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                    controller: phonecontroller,
                  )),
              ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(onPressed: (){}, child: Text("Make Payment"),style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 182, 165, 202),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),),
              )
              
            ],
          )),
        ),
      ),
    );
  }
}
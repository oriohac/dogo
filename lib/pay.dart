import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                    child: SizedBox(
                        height: 48,
                        width: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: "Fullname",
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.draw),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: namecontroller,
                          // validator: (value) =>
                          //     value!.isNotEmpty ? null : "Enter Your Full name",
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                    child: SizedBox(
                        height: 48,
                        width: 200,
                        child: TextFormField(
                          // validator: (value) =>
                          //     value!.isNotEmpty ? null : "Enter Email",
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.mail),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: emailcontroller,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 4, 6),
                    child: SizedBox(
                        height: 48,
                        width: 200,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "Phone Number",
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: Icon(Icons.phone_android),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30))),
                          controller: phonecontroller,
                          // validator: (value) =>
                          //     value!.isNotEmpty ? null : "Enter Your Phone Number",
                        )),
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _send,
                      child: Text("Make Payment"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 182, 165, 202),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  _send() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(
        name: namecontroller.text,
        phoneNumber: phonecontroller.text,
        email: emailcontroller.text);
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWSECK_TEST-eb6a9bf46b48cf0510f1b4c20e166da2-X",
        currency: "NGN",
        txRef: Uuid().v1(),
        amount: "2500",
        redirectUrl: 'http://github.com',
        customer: customer,
        paymentOptions: "ussd, card, barter, payattitude",
        customization: Customization(title: "My Payment"),
        isTestMode: true);

    final ChargeResponse response = await flutterwave.charge();

    if (response.success == true) {
      print("${response.toJson()}");
    } else {
      print("no response");
    }
  }
}

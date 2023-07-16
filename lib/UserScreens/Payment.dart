import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khalti/khalti.dart';

class KhaltiPayment extends StatefulWidget {
  const KhaltiPayment({Key? key}) : super(key: key);

  @override
  State<KhaltiPayment> createState() => _KhaltiPaymentState();
}

class _KhaltiPaymentState extends State<KhaltiPayment> {
  TextEditingController phoneController = new TextEditingController();
  TextEditingController pinCodeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Khalti",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Phone number"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: pinCodeController,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Pin Code "),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final initiationModel = await Khalti.service.initiatePayment(
                    request: PaymentInitiationRequestModel(
                        amount: 1000,
                        mobile: phoneController.text,
                        productIdentity: "pID",
                        productName: "ProductName",
                        transactionPin: pinCodeController.text,
                        productUrl: "",
                        additionalData: {}),
                  );
                  final otp = await showDialog(
                      context: (context),
                      barrierDismissible: false,
                      builder: (context) {
                        String? _otp;
                        return AlertDialog(
                          title: Text("Enter OTP"),
                          content: TextField(
                            onChanged: (v) => _otp = v,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(label: Text("OTP")),
                          ),
                          actions: [
                            SimpleDialogOption(
                              child: Text("Submit"),
                              onPressed: () {
                                Navigator.pop(context, _otp);
                              },
                            )
                          ],
                        );
                      });
                  if (otp != null) {
                    try {
                      final model = await Khalti.service.confirmPayment(
                          request: PaymentConfirmationRequestModel(
                              confirmationCode: otp,
                              token: initiationModel.token,
                              transactionPin: pinCodeController.text));
                      showDialog(
                          context: (context),
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Payment Successful",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              content:
                                  Text("Verification Token ${model.token}"),
                            );
                          });
                    } catch (e) {
                      ScaffoldMessenger.maybeOf(context)
                          ?.showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: Text("Make Payment"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

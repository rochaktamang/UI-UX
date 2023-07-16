import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/GlobalUIViewModel.dart';
import '../../ViewModel/auth_viewmodel.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  void resetPassword() async {
    _ui.loadState(true);
    try {
      await _auth.resetPassword(_emailController.text).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Password reset link has been sent to your email.")));
        Navigator.of(context).pop();
      }).catchError((e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Image.asset(
                    "Assets/img.png",
                    height: 50,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        fontFamily: 'WorkSansSemiBold',
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: 'Email Address',
                      hintStyle: const TextStyle(
                          fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                  ),
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        resetPassword();
                      },
                      child: Text(
                        "Reset Password",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pushNamed("/Registration");
                          });
                        },
                        child: Text(
                          "Already know the password? Login",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ])),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/GlobalUIViewModel.dart';
import '../../ViewModel/auth_viewmodel.dart';
import '../../services/NotificationService.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController _emailController = new TextEditingController(
    text: "test123@gmail.com"
  );
  TextEditingController _passwordController = new TextEditingController(
    text: "@sdf1234"
  );
  bool _obscureTextPassword = true;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void login() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      return;
    }
    _ui.loadState(true);
    try {
      await _authViewModel
          .login(_emailController.text, _passwordController.text)
          .then((value) {
        Navigator.of(context).pushReplacementNamed('/dashboard');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(
              seconds: 3
            ),
            backgroundColor: Colors.green,
            content: Text("Logged in Successfully."))
        );
      }).catchError((e) {
        log(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
          print(err.toString());
    }
    _ui.loadState(false);
  }

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;
  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  showHidePassword() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.3,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
            ),
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/img.png",
                  height: 50,
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome!",
                  style: GoogleFonts.oswald(
                      fontStyle: FontStyle.normal,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidateLogin.emailValidate,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.email),
                      hintText: "pawfect@gmail.com"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: ValidateLogin.password,
                  obscureText: _obscureTextPassword,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      "Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.password),
                    hintText: "xyz@_123",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureTextPassword = !_obscureTextPassword;
                        });
                      },
                      child: Icon(
                        _obscureTextPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pushNamed("/ForgotPassword");
                        });
                      },
                      child: Text("Forgot password??",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    )),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {
                      login();
                      setState(() {
                        _loading = true;
                      });
                    },
                    child: Wrap(
                      children: [
                        const Text(
                          "Log In",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        _loading
                        ? const SizedBox(
                          width: 10,
                        )
                        : const SizedBox(
                        )
                        ,
                        _loading
                        ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        )
                        :const SizedBox()
                      ],
                    )
                    ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).pushNamed("/Registration");
                    });
                  },
                  child: Text(
                    "New to the app? Sign up!",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ValidateLogin {
  static String? emailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }
}

class AppColor{
  static const primaryColor = Color.fromARGB(255, 120, 184, 236);
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawfect/UserScreens/auth/UserLogin.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/GlobalUIViewModel.dart';
import '../../ViewModel/auth_viewmodel.dart';
import '../../model/user_model.dart';
import '../../services/NotificationService.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureConfirmTextPassword = true;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  late GlobalUIViewModel _ui;
  late AuthViewModel _authViewModel;

  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  void register() async {
    if (_formKey.currentState == null || !_formKey.currentState!.validate()) {
      
      return;
    }
    setState(() {
                        _loading = true;
                      });
    _ui.loadState(true);
    try {
      await _authViewModel
          .register(UserModel(
              email: _emailController.text,
              password: _passwordController.text,
              phone: _phoneController.text,
              username: _userNameController.text,
              name: _nameController.text))
          .then((value) {
        NotificationService.display(
          title: "Welcome to Pawfect",
          body:
              "Hello ${_authViewModel.loggedInUser?.name},\n Thank you for registering in this application.",
        );
        Navigator.of(context).pushReplacementNamed("/dashboard");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(
              seconds: 3
            ),
            backgroundColor: Colors.green,
            content: Text("Registered Successfully."))
        );
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

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
              top: MediaQuery.of(context).size.height * 0.05,
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
                  "Get Started!",
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
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    return ValidateSignup.name(value);
                  },
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
                        "First Name",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return ValidateSignup.phone(value);
                  },
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
                        "Phone number",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.phone),
                      hintText: "98xxxxxxxx"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    return ValidateSignup.username(value);
                  },
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
                        "User Name",
                        style: TextStyle(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.person_pin),
                      hintText: "username"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return ValidateSignup.emailValidate(value);
                  },
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
                  obscureText: _obscureTextPassword,
                  validator: (String? value) => ValidateSignup.password(
                      value, _confirmPasswordController),
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
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: _obscureConfirmTextPassword,
                  controller: _confirmPasswordController,
                  validator: (String? value) =>
                      ValidateSignup.password(value, _passwordController),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: Text(
                      "Confirm Password",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: "xyz@_123",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureConfirmTextPassword =
                              !_obscureConfirmTextPassword;
                        });
                      },
                      child: Icon(
                        _obscureConfirmTextPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
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
                          borderRadius: BorderRadius.circular(20))
                          ,
                    ),
                    onPressed: () {
                      register();
                      
                    },
                    child: Wrap(
                      children: [
                        const Text(
                          "Register",
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
                      Navigator.of(context).pushNamed("/UserLogin");
                    });
                  },
                  child: Text(
                    "Already have an account? Log in!",
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

class ValidateSignup {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String? emailValidate(String? value) {
    final RegExp emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    if (!emailValid.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    if (value.length != 10) {
      return "Phone number must be exactly 10 digit.";
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return "Username is required";
    }
    return null;
  }

  static String? password(String? value, TextEditingController otherPassword) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 8) {
      return "Password should be at least 8 character";
    }
    if (otherPassword.text != value) {
      return "Please make sure both the password are the same";
    }
    return null;
  }
}

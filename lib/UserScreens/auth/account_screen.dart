import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/GlobalUIViewModel.dart';
import '../../ViewModel/auth_viewmodel.dart';
import '../../Widgets/AppIcon.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logout() async {
    _ui.loadState(true);
    try {
      await _auth.logout().then((value) {
        Navigator.of(context).pushReplacementNamed('/UserLogin');
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Positioned(
                top: MediaQuery.of(context).size.width * 0.1,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.03,
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        AppIcon(icon: Icons.arrow_back),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop("/Profile");
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "Assets/img_1.png",
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "User",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Online",
                style: TextStyle(color: Colors.green),
              ),
              Container(
                child: Text(_auth.loggedInUser!.email.toString()),
              ),
              SizedBox(
                height: 10,
              ),
              makeSettings(
                icon: Icon(Icons.person),
                title: "Name",
                subtitle: _auth.loggedInUser!.name.toString(),
              ),
              makeSettings(
                icon: Icon(Icons.verified_user),
                title: "UserName",
                subtitle: _auth.loggedInUser!.username.toString(),
              ),
              makeSettings(
                icon: Icon(Icons.phone),
                title: "Phone",
                subtitle: _auth.loggedInUser!.phone.toString(),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: logout,
                  child: Text(
                    "Logout",
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  makeSettings({
    required Icon icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
          leading: icon,
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}

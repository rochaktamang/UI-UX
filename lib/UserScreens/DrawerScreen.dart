import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/constants/Colors.dart';
import 'package:pawfect/constants/configuration.dart';
import 'package:provider/provider.dart';

import '../ViewModel/GlobalUIViewModel.dart';
import '../ViewModel/auth_viewmodel.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
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

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policy'),
          content: Text(
              "Rochak Tamang built the PetShop app as an Open Source app. This SERVICE is provided by Rochak Tamang at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at PetShop unless otherwise defined in this Privacy Policy."),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _ui = Provider.of<GlobalUIViewModel>(context, listen: false);
    _auth = Provider.of<AuthViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BackColor,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage('Assets/img_1.png'),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed("/Profile");
                },
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_auth.loggedInUser!.name.toString(),
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold)),
                  Text(
                    "Online",
                    style: TextStyle(
                        color: Colors.green.shade300, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Column(
            children: drawerItems
                .map((elements) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          switch (elements['title']) {
                            case 'Adoption':
                              Navigator.pushNamed(context, '/Adoption');
                              break;
                            case 'Payment':
                              Navigator.pushNamed(context, '/Payment');
                              break;
                            case 'Favorite Dogs':
                              Navigator.pushNamed(context, '/FavoriteDogs');
                              break;

                            case 'Favorites Cats':
                              Navigator.pushNamed(context, '/FavoriteCats');
                              break;
                            case 'Profile':
                              Navigator.pushNamed(context, '/Profile');
                              break;
                            case 'Veterinary':
                              Navigator.pushNamed(context, '/Veterinary');
                              break;
                            default:
                              break;
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              elements['icons'],
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(width: 10),
                            Text(elements['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
          InkWell(
            onTap: logout,
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                InkWell(
                  child: Text("Privacy Policy",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onTap: () {
                    _showPopup();
                  },
                ),
                SizedBox(width: 10),
                Container(width: 2, height: 20, color: Colors.white),
                SizedBox(width: 10),
                Text("Log out",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

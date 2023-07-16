import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pawfect/ViewModel/DogViewModel.dart';
import 'package:pawfect/model/favDogModel.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/GlobalUIViewModel.dart';
import '../../ViewModel/auth_viewmodel.dart';
import '../../Widgets/AppColumn.dart';
import '../../Widgets/AppIcon.dart';
import '../../Widgets/ExpandableTextWidget.dart';

class SubScreen extends StatefulWidget {
  final int? index;
  final String? dogName;
  final String? dogDescription;
  final String? imageLink;
  final String? breed;
  final String? color;
  final int? price;

  SubScreen(this.index, this.dogName, this.dogDescription, this.imageLink,
      this.price, this.breed, this.color);

  @override
  State<SubScreen> createState() => _SubScreenState();
}

class _SubScreenState extends State<SubScreen> {
  late DogViewModel _dogViewModel;
  var _currentPageValue = 0.0;
  bool clicked = false;
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  PageController pageController = PageController(viewportFraction: 0.85);
  Future<void> saveFavoriteDog() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = FavoriteDogModel(
      userId: "1",
      dogId: '1',
      dogName: widget.dogName!,
      imageUrl: widget.imageLink!,
      breed: widget.breed!,
    );

    db.collection("favDog").add(data.toJson()).then((value) {
      print("Added Data with ID: ${value.id}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Dog Added to Fav",
        style: TextStyle(color: Colors.white),
      )));
    });
  }

  Future<void> saveAdoption() async {
    // FirebaseFirestore db = FirebaseFirestore.instance;
    // final data = FavoriteDogModel(
    //   userId: "1",
    //   dogId: '1',
    //   dogName: widget.dogName!,
    //   imageUrl: widget.imageLink!,
    //   breed: widget.breed!,
    // );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Dog Applied for Adoption",
        style: TextStyle(color: Colors.white),
      )));
    // db.collection("adopt").add(data.toJson()).then((value) {
    //   print("Added Data with ID: ${value.id}");
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(
    //     "Dog Applied for Adoption",
    //     style: TextStyle(color: Colors.white),
    //   )));
    // });
  }

  @override
  void initState() {
    _dogViewModel = Provider.of<DogViewModel>(context, listen: false);
    _dogViewModel.getDog();
    print("The Final Place -->${_dogViewModel.getDog()}");
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var dog = context.watch<DogViewModel>().dog;
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                    width: double.maxFinite,
                    //takes all available width
                    height: MediaQuery.of(context).size.height / 2.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(widget.imageLink!))))),
            Positioned(
                top: MediaQuery.of(context).size.width * 0.1,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.03,
                child: InkWell(
                  child: Row(
                    children: [
                      AppIcon(icon: Icons.arrow_back),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop("/SubPage");
                    // MyConstants.holdNavigatePlaceDetails = null;
                    // Navigator.of(context).pop("/SubPages");
                  },
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: MediaQuery.of(context).size.height / 2.5,
                child: Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.04,
                      right: MediaQuery.of(context).size.height * 0.03,
                      top: MediaQuery.of(context).size.height * 0.03,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        color: Colors.white),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Personality",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: ExpandableTextWidget(
                                Des_text: widget.dogDescription!,
                              ),
                            ),
                          ),
                          Center(
                            child: AppColumn(
                              Name: widget.dogName!,
                              price: widget.price!,
                              color: widget.color!,
                              breed: widget.breed!,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ]))),
          ]),
          bottomNavigationBar: Container(
              height: 75,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xfffcf4e4),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15),
                          height: 50,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(191, 134, 143, 30),
                          ),
                          child: InkWell(
                            onTap: () {
                              saveFavoriteDog();
                              setState(() {
                                clicked = !clicked;
                              });
                            },
                            child: Icon(Icons.favorite,
                                color: clicked
                                    ? Color.fromRGBO(128, 0, 0, 10)
                                    : Colors.white),
                          ),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            saveAdoption();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 134, 143, 30),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Adoption",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  )))),
    );
  }
}

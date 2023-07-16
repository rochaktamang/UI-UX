import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pawfect/ViewModel/CatViewModel.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/GlobalUIViewModel.dart';
import '../../ViewModel/auth_viewmodel.dart';
import '../../Widgets/AppColumn.dart';
import '../../Widgets/AppIcon.dart';
import '../../Widgets/ExpandableTextWidget.dart';
import '../../model/favCatModel.dart';

class SubScreenCat extends StatefulWidget {
  final int? index;
  final String? catName;
  final String? catDescription;
  final String? imageLink;
  final String? breed;
  final String? color;
  final int? price;

  SubScreenCat(this.index, this.catName, this.catDescription, this.imageLink,
      this.price, this.breed, this.color);

  @override
  State<SubScreenCat> createState() => _SubScreenCatState();
}

class _SubScreenCatState extends State<SubScreenCat> {
  late CatViewModel _catViewModel;
  var _currentPageValue = 0.0;
  PageController pageControllerCat = PageController(viewportFraction: 0.85);
  int _count = 1;
  bool clicked = false;
  late GlobalUIViewModel _ui;
  late AuthViewModel _auth;
  PageController pageController = PageController(viewportFraction: 0.85);
  Future<void> saveFavoriteCat() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = FavoriteCatModel(
      userId: "1",
      catId: '1',
      catgName: widget.catName!,
      imageUrl: widget.imageLink!,
      breed: widget.breed!,
    );

    db.collection("favCat").add(data.toJson()).then((value) {
      print("Added Data with ID: ${value.id}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
        child: Text(
          "Cat Added to Favorites",
          style: TextStyle(color: Colors.white),
        ),
      )));
    });
  }

  @override
  void initState() {
    _catViewModel = Provider.of<CatViewModel>(context, listen: false);
    _catViewModel.getCat();
    print("The Cat -->${_catViewModel.getCat()}");
    super.initState();
    pageControllerCat.addListener(() {
      setState(() {
        _currentPageValue = pageControllerCat.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var cat = context.watch<CatViewModel>().cat;
    int weight = 0;
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
                    Navigator.of(context).pop("/SubPageCat");
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
                                Des_text: widget.catDescription!,
                              ),
                            ),
                          ),
                          Center(
                            child: AppColumn(
                              Name: widget.catName!,
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
                              saveFavoriteCat();
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
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(191, 134, 143, 30),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Cat Applied for Adoption",
        style: TextStyle(color: Colors.white),
      )));
                            },
                            child: Center(
                              child: Text(
                                "Adoption",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 24),
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

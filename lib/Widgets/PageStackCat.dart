import 'package:flutter/material.dart';

import '../UserScreens/subpages/subScreenCat.dart';
import 'AppColumn.dart';

class CreatePageStackCat extends StatelessWidget {
  final int index;
  final String catName;
  final String catDescription;
  final String imageLink;
  final String breed;
  final String color;
  final int price;
  const CreatePageStackCat(
      {required this.index,
      required this.catName,
      required this.catDescription,
      required this.imageLink,
      required this.breed,
      required this.color,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubScreenCat(index, catName,
                    catDescription, imageLink, price, breed, color)));
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Stack(alignment: Alignment.topCenter, children: [
            Expanded(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: index.isEven
                        ? Color.fromRGBO(218, 252, 253, 10)
                        : Color.fromRGBO(218, 218, 254, 10),
                    image: DecorationImage(
                        fit: BoxFit.contain, image: NetworkImage(imageLink))),
              ),
            ),
            Container(
              height: 100,
              width: 200,
              margin: EdgeInsets.only(top: 100.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: AppColumn(
                Name: catName,
                breed: breed,
                color: color,
                price: price,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

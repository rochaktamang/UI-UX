import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatefulWidget {
  final String Name;
  final String breed;
  final String color;
  final int price;

  const AppColumn({
    super.key,
    required this.Name,
    required this.breed,
    required this.color,
    required this.price,
  });

  @override
  State<AppColumn> createState() => _AppColumnState();
}

class _AppColumnState extends State<AppColumn> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 128),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.Name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 7,
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.pets,
                    size: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: "Breed: "),
                        TextSpan(
                          text: widget.breed,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    size: 20,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: "Price: "),
                        TextSpan(
                          text: widget.price.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.color_lens,
                    size: 20,
                    color: Colors.purple,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: "Color: "),
                        TextSpan(
                          text: widget.color,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

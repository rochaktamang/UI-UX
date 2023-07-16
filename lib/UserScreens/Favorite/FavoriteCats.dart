import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/favoriteCatViewModel.dart';
import '../../model/favCatModel.dart';

class FavoriteCat extends StatefulWidget {
  const FavoriteCat({Key? key}) : super(key: key);

  @override
  State<FavoriteCat> createState() => _FavoriteCatState();
}

class _FavoriteCatState extends State<FavoriteCat> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late FavoriteCatViewModel _favoriteCatViewModel;

  void _deleteFavCat(String id) async {
    await db.collection('favCat').doc(id).delete();
  }

  @override
  void initState() {
    _favoriteCatViewModel =
        Provider.of<FavoriteCatViewModel>(context, listen: false);
    _favoriteCatViewModel.getCat();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favCat = context.watch<FavoriteCatViewModel>().favcat;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(191, 134, 143, 30),
            title: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Favorite Cats",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )),
        body: StreamBuilder(
            stream: favCat,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<FavoriteCatModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                return ListView(children: [
                  ...snapshot.data!.docs.map((document) {
                    FavoriteCatModel favCat = document.data();
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("/Subpage");
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("Delete favorite cat?"),
                              content: Text(
                                  "Are you sure you want to delete this favorite cat?"),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    _deleteFavCat(document.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ListTile(
                        leading: Container(
                          width: MediaQuery.of(context).size.height / 20,
                          height: MediaQuery.of(context).size.height / 20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(favCat.imageUrl!),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Delete the item from Firestore and the UI
                            FirebaseFirestore.instance
                                .collection('favCat')
                                .doc(favCat.catId)
                                .delete();
                            _favoriteCatViewModel.deleteCat(favCat.catId);
                          },
                        ),
                        title: Text(favCat.catgName,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                // Here is the explicit parent TextStyle
                                style: new TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  new TextSpan(text: "Breed :"),
                                  new TextSpan(
                                    text: favCat.breed,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ]);
              }
            }));
  }
}

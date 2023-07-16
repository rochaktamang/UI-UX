import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/ViewModel/favoriteDogViewModel.dart';
import 'package:pawfect/model/favDogModel.dart';
import 'package:provider/provider.dart';

class FavoriteDog extends StatefulWidget {
  const FavoriteDog({Key? key}) : super(key: key);

  @override
  State<FavoriteDog> createState() => _FavoriteDogState();
}

class _FavoriteDogState extends State<FavoriteDog> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late FavoriteDogViewModel _favoriteDogViewModel;

  void _deleteFavDog(String id) async {
    await db.collection('favDog').doc(id).delete();
  }

  @override
  void initState() {
    _favoriteDogViewModel =
        Provider.of<FavoriteDogViewModel>(context, listen: false);
    _favoriteDogViewModel.getDog();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favDog = context.watch<FavoriteDogViewModel>().favdog;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(191, 134, 143, 30),
            title: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Favorite Dogs",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            )),
        body: StreamBuilder(
            stream: favDog,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<FavoriteDogModel>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error");
              } else {
                return ListView(children: [
                  ...snapshot.data!.docs.map((document) {
                    FavoriteDogModel favDog = document.data();
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("/Subpage", arguments: favDog.dogId);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("Delete favorite dog?"),
                              content: Text(
                                  "Are you sure you want to delete this favorite dog?"),
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
                                    _deleteFavDog(document.id);
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
                            backgroundImage: NetworkImage(favDog.imageUrl!),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Delete the item from Firestore and the UI
                            FirebaseFirestore.instance
                                .collection('favDog')
                                .doc(favDog.dogId)
                                .delete();
                            _favoriteDogViewModel.deleteDog(favDog.dogId);
                          },
                        ),
                        title: Text(favDog.dogName,
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
                                    text: favDog.breed,
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawfect/ViewModel/DogViewModel.dart';
import 'package:pawfect/model/dogModel.dart';
import 'package:provider/provider.dart';

import '../../Widgets/PageStack.dart';

class DogListView extends StatefulWidget {
  const DogListView({Key? key}) : super(key: key);

  @override
  State<DogListView> createState() => _DogListViewState();
}

class _DogListViewState extends State<DogListView> {
  late DogViewModel _dogViewModel;
  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    _dogViewModel = Provider.of<DogViewModel>(context, listen: false);
    _dogViewModel.getDog();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dog = context.watch<DogViewModel>().dog;
    List<DogModel> dogs = [];
    return Column(
      children: [
        Expanded(
          child: Container(
            child: StreamBuilder(
                stream: dog,
                builder:
                    (context, AsyncSnapshot<QuerySnapshot<DogModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error");
                  } else {
                    for (var querySnapshotDog in snapshot.data!.docs) {
                      final DogModel dog = querySnapshotDog.data();
                      dogs.add(dog);
                    }
                    return MyPageViewController(pageController, dogs);
                  }
                }),
          ),
        ),
      ],
    );
  }
}

class MyPageViewController extends StatelessWidget {
  final PageController controller;
  final List<DogModel> dogs;

  MyPageViewController(this.controller, this.dogs);

  @override
  Widget build(BuildContext context) {
    List<DogModel> lessThan5 = [];
    List<DogModel> greaterThan5 = [];

    for (int i = 0; i <= dogs.length - 1; i++) {
      print("The total i is: -->$i");
      if (i <= 3) {
        print("The IF value of  i is: $i");
        lessThan5.add(dogs[i]);
      } else {
        print("The Else value of  i is:$i");
        greaterThan5.add(dogs[i]);
      }
    }
    return Column(
      children: [
        Expanded(child: firstPageViewController(controller, lessThan5)),
        Expanded(
          child: secondPageViewController(controller, greaterThan5),
        )
      ],
    );
  }

  Widget firstPageViewController(
      PageController pageController, List<DogModel> dogs) {
    return PageView.builder(
        controller: pageController,
        itemCount: dogs.length,
        itemBuilder: (context, position) {
          return _createPageSlider(dogs[position], position);
        });
  }

  Widget secondPageViewController(
      PageController pageController, List<DogModel> dogs) {
    return PageView.builder(
        controller: pageController,
        itemCount: dogs.length,
        itemBuilder: (context, position) {
          return _createPageSlider(dogs[position], position);
        });
  }

  Widget _createPageSlider(DogModel dog, int index) {
    return Column(
      children: [
        Flexible(
          child: CreatePageStack(
            index: index,
            dogName: dog.dogName!,
            dogDescription: dog.dogDescription!,
            imageLink: dog.imageUrl!,
            breed: dog.breed!,
            color: dog.color!,
            price: dog.estimatedPrice!,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawfect/UserScreens/ListView/CatListView.dart';
import 'package:pawfect/UserScreens/ListView/DogListView.dart';
import 'package:pawfect/constants/Colors.dart';
import 'package:pawfect/constants/configuration.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  // to find if the drawer is open so that if it is opened,
  // we can create a logic and close later
  bool isDrawerOpen = false;
  late TabController _tabController;
  late Color _indicatorColor;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _indicatorColor = Colors.black; // set initial color of the indicator
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: categories.length, vsync: this);

    return AnimatedContainer(
        //3d transformation ko lagi.. yeha z is 0 becoz we dont want 3d effect
        //we want the homescreen to shift little to right
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 15,
              right: MediaQuery.of(context).size.width / 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isDrawerOpen
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            xOffset = 0;
                            yOffset = 0;
                            // 0 halyo vane 0% size ko banxa
                            scaleFactor = 1;
                            isDrawerOpen = false;
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            xOffset = 250;
                            yOffset = MediaQuery.of(context).size.height / 4.5;
                            scaleFactor = 0.6;
                            isDrawerOpen = true;
                          });
                        },
                        icon: Icon(Icons.menu)),
                Column(
                  children: [
                    Text(
                      "Hello My",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(children: [
                      Icon(
                        Icons.pets,
                        color: BackColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Hooman!",
                          style: GoogleFonts.oswald(
                            fontStyle: FontStyle.normal,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ))
                    ])
                  ],
                ),
                InkWell(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("Assets/img_1.png"),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("/Profile");
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(children: [
              VxSwiper.builder(
                itemCount: 5,
                height: 150,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                isFastScrollingEnabled: false,
                //onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Carousel_Container(
                    back_color: CarouselColor[index],
                    carousel_text: Description[index],
                    any_image: ImageVal[index],
                    paw_image: "Assets/paw.png",
                    icon_data: icons[index],
                  );
                },
              ),
            ]),
          ),
          Container(
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                labelPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(colors: Colors.black, radius: 4),
                tabs: [
                  Tab(text: "Dog"),
                  Tab(text: "Cat"),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 480,
            child: TabBarView(
              controller: _tabController,
              children: [DogListView(), CatListView()],
              // Transportation(),
            ),
          )
        ])));
  }
}

class Carousel_Container extends StatelessWidget {
  final String? any_image;
  final String carousel_text;
  final Color back_color;
  final String paw_image;

  final Icon icon_data;
  const Carousel_Container(
      {this.any_image,
      required this.back_color,
      required this.carousel_text,
      required this.paw_image,
      required this.icon_data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: back_color.withOpacity(0.6),
          child: Stack(
            children: [
              Positioned(
                bottom: -25,
                right: -30,
                width: 150,
                height: 100,
                child: Transform.rotate(
                  angle: 12,
                  child: Image.asset(
                    paw_image,
                    height: 70,
                    color: back_color,
                  ),
                ),
              ),
              Positioned(
                top: -35,
                left: 120,
                width: 150,
                height: 100,
                child: Transform.rotate(
                  angle: -16,
                  child: Image.asset(
                    paw_image,
                    height: 70,
                    color: back_color,
                  ),
                ),
              ),
              Positioned(
                bottom: -20,
                left: -20,
                width: 150,
                height: 100,
                child: Transform.rotate(
                  angle: -12,
                  child: Image.asset(
                    paw_image,
                    height: 70,
                    color: back_color,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      carousel_text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  Center(child: icon_data)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color colors;
  double radius;
  CircleTabIndicator({required this.colors, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
// TODO: implement createBoxPainter
    return _CirclePainter(colors: Colors.black, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color colors;
  double radius;
  _CirclePainter({required this.colors, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = colors;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}

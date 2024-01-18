import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipy/pages/signin_or_signup.pages.dart';
import 'package:daily_recipy/reusable_widgets/reusable_widgits.dart';
import 'package:daily_recipy/utils/colors.utils.dart';
import 'package:daily_recipy/utils/images.utils.dart';
import 'package:daily_recipy/viewModel/viewModel.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var sliderIndex = 0;
  CarouselController carController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
          ),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.notification_important),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                GetIt.I.get<SharedPreferences>().setBool('isLogin', false);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SigniniOrSignup()));
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Bonjour, Emma",
                      style: TextStyle(
                          color: hexStringToColor("bfc3cf"),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                horisontalSpace(),
                const Text(
                  "What would you like to cook today?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                horisontalSpace(),
                Row(
                  children: [
                    Container(
                        width: 310,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: hexStringToColor("f7f8fc"),
                        ),
                        child: TextField(
                          style: TextStyle(
                            color: hexStringToColor("f55a00"),
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: hexStringToColor("bfc3cf"),
                              ),
                              labelText: "Search for recipes",
                              labelStyle: TextStyle(
                                color: hexStringToColor("bfc3cf"),
                              )),
                        )),
                    const Spacer(),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: hexStringToColor("f7f8fc"),
                      ),
                      child: const Icon(Icons.filter_2_sharp),
                    ),
                  ],
                ),
                horisontalSpace(),
                Stack(children: [
                  CarouselSlider(
                    carouselController: carController,
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 100.0,
                        viewportFraction: .75,
                        enlargeCenterPage: true,
                        enlargeFactor: .3,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, _) {
                          sliderIndex = index;
                          setState(() {});
                        }),
                    items: [1, 2, 3, 4].map((i) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(color: Colors.amber),
                          child: Text(
                            'text $i',
                            style: const TextStyle(fontSize: 16.0),
                          ));
                    }).toList(),
                  ),
                  Positioned.fill(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async {
                              await carController.previousPage();
                              setState(() {});
                            },
                            icon: const Icon(Icons.arrow_back)),
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              await carController.nextPage();
                              setState(() {});
                            },
                            icon: const Icon(Icons.arrow_forward)),
                      ],
                    ),
                  )
                ]),
                DotsIndicator(
                  dotsCount: 5,
                  position: sliderIndex,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                horisontalSpace(),
                Row(
                  children: [
                    const Text(
                      "Today's Fresh Recipes",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    richText(
                        1, ["See All"], [hexStringToColor("f55a00")], [() {}])
                  ],
                ),
                horisontalSpace(),
                Row(children: [
                  Container(
                    width: 190,
                    decoration: BoxDecoration(
                      color: hexStringToColor("f7f8fc"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.favorite_border_outlined,
                              ),
                              Transform.translate(
                                offset: const Offset(60, -40),
                                child: Expanded(
                                  child: Container(
                                    height: 130,
                                    child: Image(
                                      image: AssetImage(ImagesPath.today1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Breakfast",
                                style: TextStyle(
                                    color: hexStringToColor("128fae"),
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "French Toast with Berries",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "120 Calories",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: hexStringToColor("f55a00"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  Text(" 10 mins"),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.timer),
                                  Text(" 1 Serving"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 190,
                    decoration: BoxDecoration(
                      color: hexStringToColor("f7f8fc"),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 15, bottom: 15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.favorite_border_outlined,
                              ),
                              Transform.translate(
                                offset: const Offset(60, -40),
                                child: Expanded(
                                  child: Container(
                                    height: 130,
                                    child: Image(
                                      image: AssetImage(ImagesPath.today1),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Breakfast",
                                style: TextStyle(
                                    color: hexStringToColor("128fae"),
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "French Toast with Berries",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                              Icon(
                                Icons.star,
                                color: hexStringToColor("f55a00"),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "120 Calories",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: hexStringToColor("f55a00"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time),
                                  Text(" 10 mins"),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.timer),
                                  Text(" 1 Serving"),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ]),
            ),
          ),
        ),
      );
    });
  }
}

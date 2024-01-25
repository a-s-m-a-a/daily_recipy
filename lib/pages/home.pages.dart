import 'package:daily_recipy/pages/favorites.pages.dart';
import 'package:daily_recipy/pages/ingredients.pages.dart';
import 'package:daily_recipy/reusable_widgets/ads_widget.dart';
import 'package:daily_recipy/reusable_widgets/reusable_widgits.dart';
import 'package:daily_recipy/utils/colors.utils.dart';
import 'package:daily_recipy/utils/images.utils.dart';
import 'package:daily_recipy/utils/numbers.dart';
import 'package:daily_recipy/viewModel/app_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = FirebaseAuth.instance.currentUser?.displayName ?? "";
  late ZoomDrawerController controller;

  @override
  void initState() {
    controller = ZoomDrawerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppAuthprovider>(builder: (context, viewModel, child) {
      return ZoomDrawer(
          slideWidth: MediaQuery.of(context).size.width * 0.65,
          menuBackgroundColor: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
          disableDragGesture: true,
          mainScreenTapClose: true,
          controller: controller,
          drawerShadowsBackgroundColor: Colors.grey,
          menuScreen: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    onTap: () {
                      controller.close?.call();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const IngredientPage()));
                    },
                    leading: const Icon(Icons.food_bank),
                    title: const Text('Ingredients'),
                  ),
                  ListTile(
                    onTap: () {
                      controller.close?.call();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FavoritesPage()));
                    },
                    leading: const Icon(Icons.food_bank),
                    title: const Text('My favorits'),
                  ),
                  ListTile(
                    onTap: () {
                      Provider.of<AppAuthprovider>(context, listen: false)
                          .signOut(context);
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
          mainScreen: Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Numbers.appHorizontalPadding),
                  child: InkWell(
                      onTap: () {
                        controller.toggle!();
                      },
                      child: const Icon(Icons.menu)),
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Numbers.appHorizontalPadding),
                    child: Icon(Icons.notifications),
                  )
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Bonjour, $name ",
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
                    const AdsWidget(),
                    horisontalSpace(),
                    Stack(children: [
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
                          richText(1, ["See All"], [hexStringToColor("f55a00")],
                              [() {}])
                        ],
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Row(children: [
                        Container(
                          width: 190,
                          decoration: BoxDecoration(
                            color: hexStringToColor("f7f8fc"),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, bottom: 15),
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
                                            image:
                                                AssetImage(ImagesPath.today1),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.only(
                                top: 15, left: 15, bottom: 15),
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
                                            image:
                                                AssetImage(ImagesPath.today1),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                  ]),
                ),
              )));
    });
  }
}

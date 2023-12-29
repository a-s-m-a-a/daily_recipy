import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(children: [
          Stack(children: [
            CarouselSlider(
              carouselController: carController,
              options: CarouselOptions(
                  autoPlay: true,
                  height: 200.0,
                  viewportFraction: .75,
                  enlargeCenterPage: true,
                  enlargeFactor: .3,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, _) {
                    sliderIndex = index;
                    setState(() {});
                  }),
              items: [1, 2, 3, 4, 5].map((i) {
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
          )
        ])),
      ),
    );
  }
}

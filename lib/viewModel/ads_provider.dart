import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipy/model/ad.model.dart';
import 'package:flutter/material.dart';

class AdsProvider extends ChangeNotifier {
  List<Ad>? _adsList;

  List<Ad>? get adsList => _adsList;
  CarouselController? carouselController;

  int sliderIndex = 0;

  void initCarousel() {
    carouselController = CarouselController();
  }

  void onPageChanged(int index) {
    sliderIndex = index;
    notifyListeners();
  }

  void disposeCarousel() {
    carouselController = null;
  }

  void onPressArrowLift() async {
    await carouselController!.previousPage();
    notifyListeners();
  }

  void onPressArrowRight() async {
    await carouselController!.nextPage();
    notifyListeners();
  }

  void onDotTapped(int possition) async {
    await carouselController?.animateToPage(possition);
    sliderIndex = possition;
    notifyListeners();
  }

  Future<void> getAds() async {
    try {
      var result = await FirebaseFirestore.instance.collection("ads").get();
      if (result.docs.isNotEmpty) {
        _adsList = List<Ad>.from(
            result.docs.map((doc) => Ad.fromJson(doc.data(), doc.id)));
      } else {
        _adsList = [];
      }
      notifyListeners();
    } catch (e) {
      _adsList = [];
      notifyListeners();
    }
  }
}

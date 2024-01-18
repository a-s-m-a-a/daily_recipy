import 'dart:convert';

import 'package:daily_recipy/model/Image.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewModel extends ChangeNotifier {
  List<ImagesData> imageList = [];
  Future<List> getAds() async {
    var adsData = await rootBundle.loadString('assets/data/imagesData.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);

    return imageList = dataDecoded.map((e) => ImagesData.fromJson(e)).toList();
  }
}

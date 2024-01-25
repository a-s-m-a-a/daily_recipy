import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_recipy/model/recipe.model.dart';
import 'package:daily_recipy/reusable_widgets/toast_message.dart';
import 'package:daily_recipy/utils/toast_message_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

class RecipeProvider extends ChangeNotifier {
  List<Recipe>? _recipesList;
  List<Recipe>? get recipesList => _recipesList;
  List<Recipe>? _favoriteList;
  List<Recipe>? get favoriteList => _favoriteList;

  Future<void> getRecipes() async {
    try {
      var result = await FirebaseFirestore.instance.collection('recipes').get();

      if (result.docs.isNotEmpty) {
        _recipesList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _recipesList = [];
      }
      notifyListeners();
    } catch (e) {
      // _ingredientList = [];
      notifyListeners();
    }
  }

  Future<void> getFavorites() async {
    try {
      var result = await FirebaseFirestore.instance
          .collection('ingredients')
          .where(FirebaseAuth.instance.currentUser!.uid, isEqualTo: "users_ids")
          .get();

      if (result.docs.isNotEmpty) {
        _favoriteList = List<Recipe>.from(
            result.docs.map((doc) => Recipe.fromJson(doc.data(), doc.id)));
      } else {
        _favoriteList = [];
      }
      notifyListeners();
    } catch (e) {
      const Text("an Error to catch favorit recipes");
      notifyListeners();
    }
  }

  Future<void> addUserToRecipes(bool isAdd, String recipeId) async {
    try {
      OverlayLoadingProgress.start();
      if (isAdd) {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "users_ids":
              FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid])
        });
      } else {
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .update({
          "users_ids":
              FieldValue.arrayRemove([FirebaseAuth.instance.currentUser?.uid])
        });
      }
      OverlayLoadingProgress.stop();
      getRecipes();
    } catch (e) {
      OverlayLoadingProgress.stop();
      OverlayToastMessage.show(
        widget: ToastMessageWidget(
          message: 'Error : ${e.toString()}',
          toastMessageStatus: ToastMessageStatus.faild,
        ),
      );
    }
  }
}

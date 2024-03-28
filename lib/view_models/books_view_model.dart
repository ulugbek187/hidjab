import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../data/models/hidjab_model.dart';
import '../utils/constants/app_constants.dart';
import '../utils/utility_functions.dart';

class BooksViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  List<HidjabModel> categoryProduct = [];

  Stream<List<HidjabModel>> listenProducts() =>
      FirebaseFirestore.instance.collection(AppConstants.books).snapshots().map(
            (event) => event.docs
                .map((doc) => HidjabModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<HidjabModel>> listenProductsByCategory(
          {required String categoryDocId}) =>
      FirebaseFirestore.instance
          .collection(AppConstants.books)
          .where("category_id", isEqualTo: categoryDocId)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs
              .map((doc) => HidjabModel.fromJson(doc.data()))
              .toList());

  insertProducts(HidjabModel productModel, BuildContext context) async {
    try {
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .doc(cf.id)
          .update({"doc_id": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnack(
        context: context,
        message: error.code,
      );
    }
  }

  updateProduct(HidjabModel productModel, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .doc(productModel.docId)
          .update(productModel.toJsonForUpdate());

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnack(
        context: context,
        message: error.code,
      );
    }
  }

  deleteProduct(String docId, BuildContext context) async {
    try {
      _notify(true);
      await FirebaseFirestore.instance
          .collection(AppConstants.books)
          .doc(docId)
          .delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnack(
        context: context,
        message: error.code,
      );
    }
  }

  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}

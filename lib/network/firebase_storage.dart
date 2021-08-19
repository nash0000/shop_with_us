import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:shop_with_us/models/product.dart';
import 'package:shop_with_us/network/cloud_firestore.dart';

class FirebaseStorageService {
  static FirebaseStorage storage;

  FirebaseStorageService() {
    storage = FirebaseStorage.instance;
  }

  static uploadImageAndSaveProduct(
      {ProductModel product, File imageFile}) async {
    return await storage
        .ref()
        .child('Pics/${Uri.file(imageFile.path).pathSegments.last}')
        .putFile(imageFile)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFireStoreService.createCollectionAndAddProduct(
          product: product,
          imageUrl: value.toString(),
        );
      });
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_with_us/models/product.dart';
import 'package:shop_with_us/network/firebase_auth.dart';
import 'package:shop_with_us/shared/constant.dart';
import 'package:shop_with_us/models/user.dart';
import 'package:flutter/cupertino.dart';

class FirebaseFireStoreService {
  static FirebaseFirestore fireStoreInstance;

  FirebaseFireStoreService() {
    fireStoreInstance = FirebaseFirestore.instance;
  }

  static Future<DocumentReference> createCollectionAndAddProduct(
      {ProductModel product, imageUrl}) async {
    return await fireStoreInstance.collection(KProductsCollection).add({
      KProductImageUrl: imageUrl,
      KProductName: product.pName,
      KProductDescription: product.pDescription,
      KProductColor: product.pColor,
      KProductCategory: product.pCategory,
      KProductPrice: product.pPrice,
    });
  }

  static Future<DocumentReference> storeUserCartDetails(
      {ProductModel product}) async {
    return await fireStoreInstance
        .collection(KCartCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(KCartDetailsCollection)
        .add({
      KProductImageUrl: product.pImageUrl,
      KProductName: product.pName,
      KProductQuantity: product.pQuantity,
      KProductPrice: product.pPrice,
    });
  }

  static Future<DocumentReference> storeOrders(
      {totalPrice, shippingAddress, phone}) async {
    return await fireStoreInstance.collection(KOrderCollection).add({
      KUserID: FirebaseAuthService.getUserId(),
      KAddress: shippingAddress,
      KPhone: phone,
      KTotalPrice: totalPrice,
    });
  }

  static storeOrdersDetails({List<ProductModel> products}) async {
    var docReference = fireStoreInstance
        .collection(KOrderDetailsCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(KOrderDetailsCollection);

    for (var product in products) {
      docReference.add({
        KProductImageUrl: product.pImageUrl,
        KProductName: product.pName,
        KProductQuantity: product.pQuantity,
        KProductPrice: product.pPrice,
      });
    }
  }

  static Future<QuerySnapshot> getProducts() async {
    return await fireStoreInstance.collection(KProductsCollection).get();
  }

  //save user details after login

  static storeUsers({@required User user}) async {
    return await fireStoreInstance
        .collection(KUsersCollection)
        .doc(FirebaseAuthService.getUserId())
        .set({
      KUserID: user.userID,
      KUserName: user.userName,
      KUserEmail: user.userEmail,
      KUserPhone: user.userPhone,
      KUserPassword: user.userPassword,
    });
  }

  static Future<QuerySnapshot> getOrders() async {
    return await fireStoreInstance.collection(KOrderCollection).get();
  }

  static Future<QuerySnapshot> getOrdersDetails(
      {@required String userId}) async {
    return await fireStoreInstance
        .collection(KOrderDetailsCollection)
        .doc(userId)
        .collection(KOrderDetailsCollection)
        .get();
  }

  static Future<QuerySnapshot> getCartProducts() async {
    return await fireStoreInstance
        .collection(KCartCollection)
        .doc(FirebaseAuthService.getUserId())
        .collection(KCartDetailsCollection)
        .get();
  }

  static deleteUserCart() async {
    getCartProducts().then((value) {
      for (var doc in value.docs) {
        fireStoreInstance
            .collection(KCartCollection)
            .doc(FirebaseAuthService.getUserId())
            .collection(KCartDetailsCollection)
            .doc(doc.id)
            .delete();
      }
    });
  }

  static Future<void> deleteProduct({documentId}) async {
    return await fireStoreInstance
        .collection(KProductsCollection)
        .doc(documentId)
        .delete();
  }

  static Future<void> editProduct({productData, documentId}) async {
    return await fireStoreInstance
        .collection(KProductsCollection)
        .doc(documentId)
        .update(productData);
  }
}

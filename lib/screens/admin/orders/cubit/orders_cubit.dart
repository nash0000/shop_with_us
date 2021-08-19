import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/models/order.dart';
import 'package:shop_with_us/models/product.dart';
import 'package:shop_with_us/network/cloud_firestore.dart';
import 'package:shop_with_us/screens/admin/orders/cubit/orders_states.dart';
import 'package:shop_with_us/shared/constant.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);
  List<OrderModel> orders = [];
  List<ProductModel> userOrderProducts = [];
  List<String> userIDs = [];

  loadOrders() {
    emit(OrdersLoadingState());

    FirebaseFireStoreService.getOrders().then((value) {
      for (var doc in value.docs) {
        var data = doc.data();
        orders.add(OrderModel(
          oUserID: data[KUserID],
          oPhone: data[KPhone],
          oAddress: data[KAddress],
          oTotalPrice: data[KTotalPrice],
        ));
        userIDs.add(data[KUserID]);
        //loadOrdersDetails(data[KUserID]);
      }
      print("User IDs============= ${userIDs.length}");
      emit(OrdersSuccessState());
    }).catchError((onError) {
      print("Error ==========$onError");
      emit(OrdersErrorState(onError));
    });
  }

  loadOrdersDetails({index}) {
    FirebaseFireStoreService.getOrdersDetails(userId: userIDs[index])
        .then((value) {
      for (var doc in value.docs) {
        var data = doc.data();
        userOrderProducts.add(ProductModel(
            pId: doc.id,
            pName: data[KProductName],
            pQuantity: data[KProductQuantity],
            pImageUrl: data[KProductImageUrl]));
      }
      emit(OrdersSuccessState());
    });
  }
}

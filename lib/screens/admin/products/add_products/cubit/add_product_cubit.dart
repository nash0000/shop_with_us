import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_with_us/models/product.dart';
import 'package:shop_with_us/network/firebase_storage.dart';
import 'package:shop_with_us/screens/admin/products/add_products/cubit/add_product_states.dart';

class AddProductCubit extends Cubit<AddProductStates> {
  AddProductCubit() : super(AddProductInitialState());

  static AddProductCubit get(context) => BlocProvider.of(context);

  String imageLink = '';
  File imageFileFromUser;

  selectImage() {
    imageLink = 'pick image from select image method';
    ImagePicker().getImage(source: ImageSource.gallery).then((pickedFile) {
      imageFileFromUser = File(pickedFile.path);
      imageLink = pickedFile.path;

      emit(AddProductImagePickedState());
    }).catchError((e) {
      emit(AddProductErrorState(e.toString()));
    });
  }

  saveProduct({ProductModel product}) {
    emit(AddProductLoadingState());

    FirebaseStorageService.uploadImageAndSaveProduct(
            product: product, imageFile: imageFileFromUser)
        .then((value) {
      emit(AddProductSuccessState());
    }).catchError((e) {
      emit(AddProductErrorState(e.toString()));
    });
  }
}

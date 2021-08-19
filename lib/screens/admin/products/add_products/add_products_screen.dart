import 'dart:io';
import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shop_with_us/models/product.dart';
import 'package:shop_with_us/screens/admin/products/add_products/cubit/add_product_cubit.dart';
import 'package:shop_with_us/screens/admin/products/add_products/cubit/add_product_states.dart';
import 'package:shop_with_us/shared/colors/colors.dart';
import 'package:shop_with_us/shared/components/components.dart';
import 'package:shop_with_us/shared/constant.dart';

Color currentColor = KProductColorLocal;
String categorySelected = 'jackets';

class AddProductScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          String imageLink = AddProductCubit.get(context).imageLink;

          return ConditionalBuilder(
            condition: state is! AddProductLoadingState,
            builder: (context) {
              return Scaffold(
                backgroundColor: KMainColor,
                body: SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: KSecondaryColor,
                                  size: 30,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          imageLink != ''
                              ? CircleAvatar(
                                  radius: 110,
                                  backgroundColor: KSecondaryColor,
                                  child: CircleAvatar(
                                    backgroundColor: KMainColor,
                                    child: ClipOval(
                                      child: Image.file(
                                        File(imageLink),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    radius: 100,
                                  ),
                                )
                              : MaterialButton(
                                  onPressed: () {
                                    AddProductCubit.get(context).selectImage();
                                  },
                                  color: KMainColor,
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    //replace with a row for horizontal icon + TextInputType.text
                                    children: <Widget>[
                                      Icon(
                                        Icons.camera,
                                        size: 120,
                                        color: KSecondaryColor,
                                      ),
                                      Text(
                                        "Choose Image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                              color: KTextLightColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 19,
                          ),
                          buildTextField(
                            icon: Icons.edit,
                            hint: 'Product name',
                            controller: nameController,
                            type: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildTextField(
                            icon: Icons.edit,
                            hint: 'Product Price',
                            controller: priceController,
                            type: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          buildTextField(
                            icon: Icons.edit,
                            hint: 'Product description',
                            controller: descriptionController,
                            type: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PickColor(),
                          SizedBox(
                            height: 20,
                          ),
                          DropDown(),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: buildDefaultButton(
                                onPressed: () {
                                  String name = nameController.text;
                                  String price = priceController.text;
                                  String description =
                                      descriptionController.text;

                                  if (name.isEmpty ||
                                      price.isEmpty ||
                                      imageLink == '' ||
                                      description.isEmpty) {
                                    showToast(
                                        message: "please fill your data",
                                        error: true);
                                  } else {
                                    AddProductCubit.get(context).saveProduct(
                                        product: ProductModel(
                                            pName: name,
                                            pPrice: price,
                                            pDescription: description,
                                            pCategory: categorySelected,
                                            pColor: currentColor
                                                .toString()
                                                .replaceAll('Color(', '')
                                                .replaceAll(')', '')));

                                    AddProductCubit.get(context).imageLink = '';
                                    showToast(
                                        message: "Product Saved Successfully",
                                        error: false);
                                  }
                                },
                                text: 'Submit',
                                textColor: KSecondaryColor,
                                backgroundColor: KMainColor,
                                borderColor: KSecondaryColor),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
/////
class PickColor extends StatefulWidget {
  @override
  _PickColorState createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  void changeColor(Color color) {
    setState(() {
      return currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 62,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          'Choose Color '.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "Pacifico",
          ),
        ),
        color: currentColor,
        textColor: KMainColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(16.0),
                content: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      BlockPicker(
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: buildDefaultButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            text: 'Submit',
                            textColor: KSecondaryColor,
                            backgroundColor: KMainColor,
                            borderColor: KSecondaryColor),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


////
class DropDown extends StatefulWidget {
  @override
  DropDownState createState() => DropDownState();
}

 //////// Company ///////
  class Company {
  int id;
  String name;
  Company(this.id ,this.name);

  static List<Company> getCompanies(){
    return <Company> [
      Company(1 , KBags),
      Company(2 , KJackets),
      Company(3 , KTrousers),
      Company(4, KTShirts),
      Company(5, KShoes),
    ];
    }
  }   //////// Company ///////


class    DropDownState extends  State<DropDown> {
    List <Company> _companies = Company.getCompanies();

  List <DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;


  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();

    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    categorySelected = _selectedCompany.name;
    print(categorySelected);
    return Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DropDownButton(
            style: TextStyle(
              color: KBlackColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: " Pacifico",
            ),
            value: _selectedCompany,
            items: _dropdownMenuItems,
            onChanged: onChangeDropdownItem,
          ),
        ],
    );
  }

}




////////////////

//class _PickColorState {}

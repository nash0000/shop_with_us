import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_with_us/shared/colors/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:shop_with_us/';

import '../constant.dart';

// 1-app db configuration
void initApp() {
  //FirebaseAuthService();
  //FirebaseFireStoreService();
  //FirebaseStorageService();
}

// 2- toast message
void showToast({@required String message, @required bool error}) =>
    Fluttertoast.showToast(
      msg: " $message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: error ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );

//3-navigation

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToReplaceMe(context, widget) => Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

//4-alert dialog

void showAlertDialoag({context, text, error = false}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (!error) CircularProgressIndicator(),
                if (!error)
                  SizedBox(
                    width: 20.0,
                  ),
                Expanded(
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
            if (error)
              SizedBox(
                height: 20.0,
              ),
            //if (error)
            // buildDefaultButton(
            //   onPressed: () => Navigator.pop(context),
            //   text: " Cancel",
            // ),
          ],
        ),
      ),
    );

// 5-custom logo

Widget showLogo({@required screenHeight}) => Container(
      height: screenHeight * .2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/icons/buyicon.png'),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              'Cloths Shop',
              style: TextStyle(
                  fontFamily: 'Pacifico', fontSize: 25, color: KSloganColor),
            ),
          ),
          SizedBox(
            width: double.infinity,
          ),
        ],
      ),
    );

// 6- custom appbar
Widget drawAppbar(
        {@required context,
        @required actionWidget,
        @required leadingWidget,
        @required title}) =>
    AppBar(
      iconTheme: IconThemeData(
        color: KWhiteColor, //change your color here ),
      ),
      centerTitle: true,
      backgroundColor: KMainColor,
      title: title,
      leading: leadingWidget,
      actions: [
        actionWidget,
        SizedBox(
          width: 20.0,
        ),
      ],
      elevation: 0.0,
    );

// 7-custom text field

Widget buildTextField({
  @required TextEditingController controller,
  @required icon,
  @required hint,
  @required TextInputType type,
  bool isPassword = false,
  Color color = KSecondaryColor,
}) =>
    TextField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      cursorColor: KSecondaryColor,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: KGreyColor,
        ),
        prefixIcon: Icon(icon, color: KSecondaryColor),
        filled: true,
        fillColor: KMainColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: color)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: color)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: color)),
      ),
    );

//7- custom text

Widget writeQuickText(
        {@required String text,
        double fontSize = 16.0,
        Color color = KTextDarkColor,
        FontWeight fontWeight = FontWeight.normal,
        TextAlign textAlign = TextAlign.center}) =>
    Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
        fontFamily: 'Pacifico',
      ),
    );

//8-  custom text form field
Widget buildTextFormField(
        {@required String title,
        @required TextEditingController controller,
        @required IconData icon,
        TextInputType keyboardType = TextInputType.text,
        bool obscureText = false,
        Function onChange}) =>
    TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      onChanged: onChange,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        } else if (title == KTextFormName && value.length < 2) {
          return 'enter at least 2 Characters';
        } else if (title == KTextFormEmail && !value.contains('@')) {
          return 'Please enter valid Email';
        } else if (title == KTextFormEmail && !value.contains('.')) {
          return 'Please enter valid Email';
        } else if (title == KTextFormPassword && value.length < 6) {
          return 'enter at least 6 Characters';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Enter your $title",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(icon),
        labelStyle: TextStyle(
          fontSize: 16.0,
        ),
        hintStyle: TextStyle(color: KGreyColor, fontSize: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: KSloganColor, width: 2),
          gapPadding: 10,
        ),
      ),
      style: TextStyle(fontSize: 14.0, color: KSecondaryColor),
    );

//9-  custom button not used
Widget buildBtn({@required Function onPressed, @required String title}) =>
    FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: onPressed,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 9),
        child: Text(
          title,
          style: TextStyle(color: KWhiteColor, fontSize: 14),
        ),
      ),
    );

// 10 -custom button i use MaterialButton because flat button now not used
Widget buildButton({title, onPressed}) => MaterialButton(
      onPressed: onPressed,
      color: KSloganColor,
      textColor: Colors.white,
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: ' Playfair_Display',
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

// 11- custom default button
Widget buildDefaultButton(
        {@required Function onPressed,
        @required String text,
        Color textColor = KMainColor,
        Color backgroundColor = KSecondaryColor,
        Color borderColor = KMainColor}) =>
    Container(
      width: double.infinity,
      height: 58.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: backgroundColor,
          border: Border.all(
            width: 3,
            color: borderColor,
          )),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textColor: textColor,
        onPressed: onPressed,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: 'Playfair_Display',
          ),
        ),
      ),
    );

// 12- custom expanded card
Widget buildExpandedCard({
  @required Function startToday,
  @required String price,
  @required ImageProvider<Object> image,
  @required String title,
  @required String startDate,
  @required String description,
  bool initiallyExpanded = false,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          15.0,
        ),
      ),
      child: ExpansionTileCard(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        finalPadding: EdgeInsets.zero,
        baseColor: KWhiteColor,
        initiallyExpanded: initiallyExpanded,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: KMainColor,
                image: DecorationImage(image: image, fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: KTextLightColor),
                  ),
                ],
              ),
            ),
          ],
        ),
        onExpansionChanged: (value) {},
        children: <Widget>[
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: writeQuickText(
                            textAlign: TextAlign.start,
                            text: "Starts at ",
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: writeQuickText(
                            textAlign: TextAlign.start,
                            text: "$startDate ",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        writeQuickText(
                            text: "Price",
                            fontSize: 10,
                            textAlign: TextAlign.start),
                        writeQuickText(
                            text: "\$$price",
                            fontSize: 20,
                            textAlign: TextAlign.start),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 160,
                  height: 46.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.circular(16.0),
                    ),
                    color: KMainColor,
                  ),
                  child: MaterialButton(
                    onPressed: startToday,
                    child: writeQuickText(
                      text: "Start Today",
                      color: KWhiteColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

//buildDefaultButton({void Function() onPressed, String text}) {}

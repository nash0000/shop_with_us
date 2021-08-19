import 'package:conditional_builder/conditional_builder.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_with_us/models/order.dart';
import 'package:shop_with_us/models/product.dart';
import 'package:shop_with_us/screens/admin/orders/cubit/orders_cubit.dart';
import 'package:shop_with_us/screens/admin/orders/cubit/orders_states.dart';
import 'package:shop_with_us/shared/colors/colors.dart';
import 'package:shop_with_us/shared/components/components.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<OrderModel> orders = OrdersCubit.get(context).orders;
        List<ProductModel> ordersDetails =
            OrdersCubit.get(context).userOrderProducts;
        return ConditionalBuilder(
          condition: state is! OrdersLoadingState,
          builder: (context) => ConditionalBuilder(
            condition: orders.length != 0,
            builder: (context) => Scaffold(
              backgroundColor: KMainColor,
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          writeQuickText(
                            text: "Orders",
                            textAlign: TextAlign.start,
                            fontSize: 28,
                          ),
                          writeQuickText(
                            fontSize: 22,
                            color: KMainColor,
                          ),
                        ],
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: KSecondaryColor,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            child: ExpansionTileCard(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              finalPadding: EdgeInsets.zero,
                              baseColor: KWhiteColor,
                              initiallyExpanded: false,
                              elevation: 0.0,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //image
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              //address
                                              child: Text(
                                                '${orders[index].oAddress}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        //phone

                                        Text(
                                          '${orders[index].oPhone}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: KTextLightColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              onExpansionChanged: (value) {
                                print("value =========$value");
                                //================================
                                if (value == true) {
                                  ordersDetails.clear();
                                  OrdersCubit.get(context)
                                      .loadOrdersDetails(index: index);
                                  //================================
                                } else {
                                  OrdersCubit.get(context)
                                      .userOrderProducts
                                      .clear();
                                }
                              },
                              children: <Widget>[
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 2,
                                            color: KSecondaryColor,
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          ConditionalBuilder(
                                            condition:
                                                ordersDetails.length != 0,
                                            builder: (context) => SizedBox(
                                              height: 300,
                                              child: GridView.builder(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 20,
                                                  crossAxisSpacing: 20,
                                                ),
                                                itemCount: ordersDetails.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      border: Border.all(
                                                        color: KSecondaryColor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: 80.0,
                                                          height: 80.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10.0,
                                                            ),
                                                            color: KMainColor,
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    '${ordersDetails[index].pImageUrl}'),
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 4.0,
                                                        ),
                                                        writeQuickText(
                                                            text:
                                                                '${ordersDetails[index].pName}',
                                                            fontSize: 10,
                                                            textAlign: TextAlign
                                                                .start),
                                                        SizedBox(
                                                          height: 4.0,
                                                        ),
                                                        //total price
                                                        writeQuickText(
                                                            text:
                                                                '${ordersDetails[index].pQuantity}',
                                                            fontSize: 14,
                                                            textAlign: TextAlign
                                                                .start),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            fallback: (context) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Container(
                                            height: 2,
                                            color: KSecondaryColor,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              writeQuickText(
                                                  text: "Total Price",
                                                  fontSize: 10,
                                                  textAlign: TextAlign.start),
                                              //total price
                                              writeQuickText(
                                                  text:
                                                      'JOD${orders[index].oTotalPrice}',
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
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.zero,
                                            bottomLeft: Radius.zero,
                                            bottomRight: Radius.circular(10.0),
                                          ),
                                          color: KSecondaryColor,
                                        ),
                                        child: MaterialButton(
                                          onPressed: () {
                                            showToast(
                                                message: 'Test', error: true);
                                          },
                                          child: writeQuickText(
                                            text: "Confirm",
                                            color: KMainColor,
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
                        },
                        itemCount: orders.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 15.0,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(
              child: Text(
                'Your have no Orders'.toUpperCase(),
                style: TextStyle(
                  color: KSecondaryColor,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

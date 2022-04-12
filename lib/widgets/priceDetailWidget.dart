import 'package:bookmrk/api/cart_api.dart';
import 'package:bookmrk/model/cart_details_model.dart';
import 'package:bookmrk/model/get_details_coupan.dart';
import 'package:bookmrk/model/no_data_cart_model.dart';
import 'package:bookmrk/res/controller.dart';
import 'package:bookmrk/res/utility.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bookmrk/screens/tabs/cart.dart';

CommanGextController _commanGextController = Get.put(CommanGextController());

String msg = "";
CartState cartState = CartState();
Widget PriceDetail(
    {height,
    width,
    int itemCount,
    String totalOfItem,
    String tax,
    String deliverCharge,
    String mainTotal,
    TextEditingController coupanCodeController,
    String isScreenCall,
    Function isRefresh}) {
  Utility.couponCode = "";
  return Container(
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    height: height / 2,
    width: width,
    child: Column(
      children: [
        priceDetail(),
        SizedBox(
          height: 15,
        ),
        priceRow(title: "Price :", price: totalOfItem),
        priceRow(title: "Tax :", price: tax),
        priceRow(title: "Delivery Charges :", price: deliverCharge),
        Divider(
          indent: 10,
          thickness: 1,
          endIndent: 10,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: const Color(0xff000000),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                '₹ $mainTotal',
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 18, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        isScreenCall == "cart"
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        child: TextField(
                          textAlign: TextAlign.justify,
                          controller: coupanCodeController,
                          decoration: InputDecoration(
                              hintText: 'Coupon Code',
                              contentPadding: EdgeInsets.all(8), // Added this
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            if (coupanCodeController.text != null &&
                                coupanCodeController.text != "") {
                              NewCartDetailsModel _cartDetailModel =
                                  await getCartDetails_(
                                      coupanCodeController.text);
                              if (_cartDetailModel.response[0].cartInfo[0]
                                      .couponCodeStatus ==
                                  "200") {
                                Utility.couponCode = coupanCodeController.text;
                                Utility.isCouponCodeAPICall = "yes";
                                _commanGextController.isCouponStatus.value = "";

                                isRefresh();
                                // cartState.isRefrash();
                              } else {
                                Utility.couponCode = "";
                              }

                              _commanGextController.isCouponMsg.value =
                                  _cartDetailModel
                                      .response[0].cartInfo[0].couponCodeMsg;
                              _commanGextController.isCouponStatus.value =
                                  _cartDetailModel
                                      .response[0].cartInfo[0].couponCodeStatus;
                            } else {
                              _commanGextController.isCouponMsg.value = "";
                              Get.showSnackbar(GetBar(
                                message: 'Coupon code cannot be empty',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: colorPalette.navyBlue,
                                duration: Duration(seconds: 2),
                              ));
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                "Apply Code",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              )
            : SizedBox(),
        SizedBox(
          height: 15,
        ),
        Obx(() {
          print("STATUS VALUE ${_commanGextController.isCouponStatus.value}");
          return Center(
              child: Text(
            _commanGextController.isCouponMsg.value,
            style: TextStyle(
                color: _commanGextController.isCouponStatus.value == "200"
                    ? Colors.green
                    : Colors.red),
          ));
        })
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
}

/// get cart details of user...
Future getCartDetails_(String couponCode) async {
  dynamic response = await CartAPI.getApplayCoupon(couponCode);

  if (response['response'][0].length == 0) {
    NoDataCartModel _noDataCart = NoDataCartModel.fromJson(response);
    return _noDataCart;
  } else {
    NewCartDetailsModel _cartDetailModel =
        NewCartDetailsModel.fromJson(response);
    print(
        "COUPON STATUS ${_cartDetailModel.response[0].cartInfo[0].couponCodeMsg}");

    return _cartDetailModel;
  }
}

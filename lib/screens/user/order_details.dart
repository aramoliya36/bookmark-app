import 'package:bookmrk/api/order_history_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/no_data_cart_model.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/order_details_model.dart';
import 'package:bookmrk/model/track_order_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'commanWebView.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  OrderDetails(this.orderId);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  ColorPalette colorPalette = ColorPalette();

  /// get orderDetails...
  Future getOrderDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await OrderHistoryAPI.getOrderDetailsFromOrderId(
        widget.orderId.toString(), userId.toString());
    if (response['response'][0].length == 0) {
      NoDataCartModel _noOrderModel = NoDataCartModel.fromJson(response);
      return _noOrderModel;
    } else {
      OrderDetailsModel _orderDetailsModel =
          OrderDetailsModel.fromJson(response);
      return _orderDetailsModel;
    }
  }

  /// get Information to track order details...
  Future getTrackingInformation(String orderIdToTrack) async {
    int userId = prefs.read<int>('userId');
    dynamic response = await OrderHistoryAPI.getTrackingDetailsOfOrder(
        userId.toString(), orderIdToTrack);

    TrackOrderModel _trackOrderModel = TrackOrderModel.fromJson(response);
    return _trackOrderModel;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String orderId;
  String subOrderId;

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getOrderDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            OrderDetailsModel _orderDetailsModel = snapshot.data;
            try {
              if (snapshot.data.response[0].length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/no_notification.svg',
                        height: 100,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Order not found!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: colorPalette.navyBlue,
                        ),
                      ),
                      SizedBox(height: 100.0),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                            snapshot.data.response[0].orderData.length,
                            (index) {
                          var total = 0.0;
                          snapshot.data.response[0].orderData[index].orderDetail
                              .forEach((e) {
                            try {
                              total =
                                  total + (double.parse(e.productSalePrice));
                              total = total.floorToDouble();
                            } catch (e) {
                              total = total + (int.parse(e.productSalePrice));
                            }
                          });
                          return Container(
                            height: snapshot.data.response[0].orderData[index]
                                        .orderDetail.length ==
                                    1
                                ? width / 2.0
                                : width / 1.5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: colorPalette.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorPalette.purple,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  height: width / 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: width / 24),
                                        child: Text(
                                          'Order Id : ${snapshot.data.response[0].orderData[index].subOrderNo}\n${snapshot.data.response[0].orderData[index].orderConfirmedDate}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Spacer(),
                                      snapshot.data.response[0].orderData[index]
                                                  .isManual !=
                                              "0"
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      colorPalette.pinkOrange,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  )),
                                              height: width / 16,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 7.0),
                                              child: Text(
                                                'Manual Shipping ',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              alignment: Alignment.center,
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 15),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, indexP) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/preload.png",
                                                  height: width / 5.5,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                    '${snapshot.data.response[0].orderData[index].orderDetail[indexP].productName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                      color: const Color(
                                                          0xff000000),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '₹ ${snapshot.data.response[0].orderData[index].orderDetail[indexP].productSalePrice}',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                    color:
                                                        const Color(0xff9f9f9f),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data.response[0]
                                        .orderData[index].orderDetail.length,
                                  ),
                                ),
                                Divider(
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Consumer<OrderProvider>(
                                        builder: (_, _orderProvider, child) =>
                                            BlueOutlineButton(
                                          width: width,
                                          onTap: snapshot
                                                      .data
                                                      .response[0]
                                                      .orderData[index]
                                                      .isManual ==
                                                  "1"
                                              ? () {
                                                  _orderProvider
                                                      .orderTrackExpandListSingleUpdate(
                                                          index,
                                                          !_orderProvider
                                                                  .orderTrackExpandList[
                                                              index]);
                                                }
                                              : () {
                                                  try {
                                                    _orderProvider
                                                            .orderIdToTrack =
                                                        "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                    _orderProvider
                                                            .userDeliveryAddress =
                                                        LatLng(
                                                      double.parse(snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .userDeliveryAddress[
                                                                          0]
                                                                      .latitudes ==
                                                                  "" ||
                                                              snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .userDeliveryAddress[
                                                                          0]
                                                                      .latitudes ==
                                                                  null
                                                          ? "21.969138705424697"
                                                          : snapshot
                                                              .data
                                                              .response[0]
                                                              .userDeliveryAddress[
                                                                  0]
                                                              .longitude),
                                                      double.parse(snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .userDeliveryAddress[
                                                                          0]
                                                                      .longitude ==
                                                                  "" ||
                                                              snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .userDeliveryAddress[
                                                                          0]
                                                                      .longitude ==
                                                                  null
                                                          ? "77.69074838608503"
                                                          : snapshot
                                                              .data
                                                              .response[0]
                                                              .userDeliveryAddress[
                                                                  0]
                                                              .longitude),
                                                    );
                                                    homeProvider
                                                            .selectedString =
                                                        "OrderTracking";
                                                  } catch (e) {
                                                    _orderProvider
                                                            .orderIdToTrack =
                                                        "${snapshot.data.response[0].orderData[index].subOrderNo}";

                                                    homeProvider
                                                            .showMapInTrackingPage =
                                                        false;
                                                    homeProvider
                                                            .selectedString =
                                                        "OrderTracking";
                                                  }
                                                },
                                          title: "TRACK",
                                        ),
                                      ),
                                      snapshot.data.response[0].orderData[index]
                                                  .isInvoiceMade ==
                                              "1"
                                          ? BlueOutlineButton(
                                              width: width,
                                              onTap: () async {
                                                _launchInBrowser(
                                                    "${snapshot.data.response[0].orderData[index].invoiceLink}");
                                              },
                                              title: "INVOICE",
                                            )
                                          : SizedBox(),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Total : ",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: const Color(0xff000000),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "₹ $total",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: const Color(0xff515c6f),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 15, bottom: 15, left: 15),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xffb7b7b7),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].fname} ${snapshot.data.response[0].userDeliveryAddress[0].lname} \n${snapshot.data.response[0].userDeliveryAddress[0].mobile} ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: const Color(0xff000000),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].address1},\n${snapshot.data.response[0].userDeliveryAddress[0].address2} \n${snapshot.data.response[0].userDeliveryAddress[0].city}, ${snapshot.data.response[0].userDeliveryAddress[0].state},\n${snapshot.data.response[0].userDeliveryAddress[0].pincode}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: const Color(0xffa9a9aa),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        height: width / 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Payment Mode : ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${snapshot.data.response[0].order[0].paymentMethod}",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff515c6f),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PriceDetail(
                        width: width,
                        height: height,
                        itemCount: snapshot.data.response[0].orderData.length,
                        totalOfItem:
                            '${snapshot.data.response[0].orderSummary[0].finalPrice}',
                        tax:
                            '${snapshot.data.response[0].orderSummary[0].finalTaxPrice}',
                        deliverCharge:
                            '${snapshot.data.response[0].orderSummary[0].finalDeliveryPrice}',
                        mainTotal:
                            '${snapshot.data.response[0].orderSummary[0].finalTotalPrice}',
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                );
              }
            } catch (e) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Consumer<OrderProvider>(
                  builder: (_, _orderProvider, child) => Column(
                    children: [
                      Column(
                        children: List.generate(
                            snapshot.data.response[0].orderData.length,
                            (index) {
                          List<bool> expand = [];
                          var total = 0.0;
                          snapshot.data.response[0].orderData[index].orderDetail
                              .forEach((e) {
                            try {
                              total =
                                  total + (double.parse(e.productSalePrice));
                              total = total.floorToDouble();
                            } catch (e) {
                              total = total + (int.parse(e.productSalePrice));
                            }
                            _orderProvider.orderTrackExpandList.add(false);
                          });
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: colorPalette.grey,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: colorPalette.purple,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      height: width / 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: width / 24),
                                            child: Text(
                                              'Order Id : ${snapshot.data.response[0].orderData[index].subOrderNo}\n${snapshot.data.response[0].orderData[index].orderConfirmedDate}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Spacer(),
                                          snapshot
                                                      .data
                                                      .response[0]
                                                      .orderData[index]
                                                      .isManual !=
                                                  "0"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: colorPalette
                                                          .pinkOrange,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      )),
                                                  height: width / 16,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.0),
                                                  child: Text(
                                                    'Manual Shipping ',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  alignment: Alignment.center,
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, indexP) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Container(
                                            // color: Colors.red,
                                            // height: 300,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 5, top: 5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 80,
                                                        width: 80,

                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  _orderDetailsModel
                                                                      .response[
                                                                          0]
                                                                      .orderData[
                                                                          index]
                                                                      .orderDetail[
                                                                          indexP]
                                                                      .productImg),
                                                              fit: BoxFit
                                                                  .contain,
                                                              alignment:
                                                                  Alignment
                                                                      .center),
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15.0),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      15.0)),
                                                        ),
                                                        // padding: EdgeInsets.all(3),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        child: Text(
                                                          '${snapshot.data.response[0].orderData[index].orderDetail[indexP].productName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.035,
                                                            color: const Color(
                                                                0xff000000),
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Text(
                                                        '₹ ${snapshot.data.response[0].orderData[index].orderDetail[indexP].productSalePrice}',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                          color: const Color(
                                                              0xff9f9f9f),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .orderDetail[
                                                                      indexP]
                                                                  .orderReplaceBtn ==
                                                              "1"
                                                          ? Expanded(
                                                              child:
                                                                  BlueOutlineButton(
                                                                width:
                                                                    width * 2,
                                                                height: 30.0,
                                                                onTap:
                                                                    () async {
                                                                  print(
                                                                      "EXACHANGE ${_orderDetailsModel.response[0].orderData[index].orderDetail[indexP].orderReplaceLinkShow}");
                                                                  print(
                                                                      "EXACHANGE PRICE ${_orderDetailsModel.response[0].orderData[index].orderDetail[indexP].productSalePrice}");
                                                                  if (_orderDetailsModel
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              index]
                                                                          .orderDetail[
                                                                              indexP]
                                                                          .orderReplaceLinkShow ==
                                                                      "0") {
                                                                    Get.showSnackbar(
                                                                        GetBar(
                                                                      message: _orderDetailsModel
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              index]
                                                                          .orderDetail[
                                                                              indexP]
                                                                          .orderReplaceLinkShowError,
                                                                      snackPosition:
                                                                          SnackPosition
                                                                              .TOP,
                                                                      backgroundColor:
                                                                          colorPalette
                                                                              .navyBlue,
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                    ));
                                                                  } else if (_orderDetailsModel
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              index]
                                                                          .orderDetail[
                                                                              indexP]
                                                                          .orderReplaceLinkShow ==
                                                                      "1") {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => CommanWebView(
                                                                            url:
                                                                                _orderDetailsModel.response[0].orderData[index].orderDetail[indexP].orderReplaceLink,
                                                                            title: "Exchange"),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                title:
                                                                    "Exchange",
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .orderDetail[
                                                                      indexP]
                                                                  .orderReturnBtn ==
                                                              "1"
                                                          ? Expanded(
                                                              child:
                                                                  BlueOutlineButton(
                                                                width:
                                                                    width * 2,
                                                                height: 30.0,
                                                                onTap:
                                                                    () async {
                                                                  print(
                                                                      "EXACHANGE ${_orderDetailsModel.response[0].orderData[index].orderDetail[indexP].orderReplaceLinkShow}");
                                                                  print(
                                                                      "EXACHANGE PRICE ${_orderDetailsModel.response[0].orderData[index].orderDetail[indexP].productSalePrice}");

                                                                  if (_orderDetailsModel
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              index]
                                                                          .orderDetail[
                                                                              indexP]
                                                                          .orderReturnLinkShow ==
                                                                      "0") {
                                                                    Get.showSnackbar(
                                                                        GetBar(
                                                                      message: _orderDetailsModel
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              index]
                                                                          .orderDetail[
                                                                              indexP]
                                                                          .orderReturnLinkShowError,
                                                                      snackPosition:
                                                                          SnackPosition
                                                                              .TOP,
                                                                      backgroundColor:
                                                                          colorPalette
                                                                              .navyBlue,
                                                                      duration: Duration(
                                                                          seconds:
                                                                              1),
                                                                    ));
                                                                  } else if (_orderDetailsModel
                                                                          .response[
                                                                              0]
                                                                          .orderData[
                                                                              index]
                                                                          .orderDetail[
                                                                              indexP]
                                                                          .orderReturnLinkShow ==
                                                                      "1") {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => CommanWebView(
                                                                            url:
                                                                                _orderDetailsModel.response[0].orderData[index].orderDetail[indexP].orderReturnLink,
                                                                            title: "Return"),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                title: "Return",
                                                              ),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .orderDetail[
                                                                      indexP]
                                                                  .replaceDaysAvailableTillDate !=
                                                              ""
                                                          ? Text(
                                                              "Exchange available till: ${_orderDetailsModel.response[0].orderData[index].orderDetail[indexP].replaceDaysAvailableTillDate}")
                                                          : SizedBox(),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .orderDetail[
                                                                      indexP]
                                                                  .returnDaysAvailableTillDate !=
                                                              ""
                                                          ? Expanded(
                                                              flex: 2,
                                                              child: Text(
                                                                  "Return available till: ${_orderDetailsModel.response[0].orderData[index].orderDetail[indexP].returnDaysAvailableTillDate}"),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: snapshot.data.response[0]
                                          .orderData[index].orderDetail.length,
                                    ),
                                    Divider(
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    _orderDetailsModel
                                                .response[0]
                                                .orderData[index]
                                                .isCancelDone ==
                                            "0"
                                        ? Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Consumer<OrderProvider>(
                                                  builder: (_, _orderProvider,
                                                          child) =>
                                                      BlueOutlineButton(
                                                    width: width,
                                                    onTap:
                                                        snapshot
                                                                    .data
                                                                    .response[0]
                                                                    .orderData[
                                                                        index]
                                                                    .isManual ==
                                                                "1"
                                                            ? () {
                                                                _orderProvider.orderTrackExpandListSingleUpdate(
                                                                    index,
                                                                    !_orderProvider
                                                                            .orderTrackExpandList[
                                                                        index]);
                                                              }
                                                            : () {
                                                                try {
                                                                  _orderProvider
                                                                          .orderIdToTrack =
                                                                      "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                                  _orderProvider
                                                                          .userDeliveryAddress =
                                                                      LatLng(
                                                                    double.parse(snapshot.data.response[0].userDeliveryAddress[0].latitudes ==
                                                                                "" ||
                                                                            snapshot.data.response[0].userDeliveryAddress[0].latitudes ==
                                                                                null
                                                                        ? "21.969138705424697"
                                                                        : snapshot
                                                                            .data
                                                                            .response[0]
                                                                            .userDeliveryAddress[0]
                                                                            .longitude),
                                                                    double.parse(snapshot.data.response[0].userDeliveryAddress[0].longitude ==
                                                                                "" ||
                                                                            snapshot.data.response[0].userDeliveryAddress[0].longitude ==
                                                                                null
                                                                        ? "77.69074838608503"
                                                                        : snapshot
                                                                            .data
                                                                            .response[0]
                                                                            .userDeliveryAddress[0]
                                                                            .longitude),
                                                                  );
                                                                  homeProvider
                                                                          .selectedString =
                                                                      "OrderTracking";
                                                                } catch (e) {
                                                                  _orderProvider
                                                                          .orderIdToTrack =
                                                                      "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                                  homeProvider
                                                                          .showMapInTrackingPage =
                                                                      false;
                                                                  homeProvider
                                                                          .selectedString =
                                                                      "OrderTracking";
                                                                }
                                                              },
                                                    title: "TRACK",
                                                  ),
                                                ),
                                                snapshot
                                                            .data
                                                            .response[0]
                                                            .orderData[index]
                                                            .isInvoiceMade ==
                                                        "1"
                                                    ? BlueOutlineButton(
                                                        width: width,
                                                        onTap: () async {
                                                          _launchInBrowser(
                                                              "${snapshot.data.response[0].orderData[index].invoiceLink}");
                                                        },
                                                        title: "INVOICE",
                                                      )
                                                    : SizedBox(),
                                                SizedBox(
                                                  width: 20.0,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "Total : ",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 15,
                                                          color: const Color(
                                                              0xff000000),
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "₹ $total",
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 15,
                                                          color: const Color(
                                                              0xff515c6f),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.only(
                                                right: 15,
                                                bottom: 15,
                                                left: 15),
                                          )
                                        : SizedBox(),
                                    _orderDetailsModel
                                                .response[0]
                                                .orderData[index]
                                                .userReqCancel ==
                                            "1"
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child:
                                                      Consumer<OrderProvider>(
                                                    builder: (_, _orderProvider,
                                                            child) =>
                                                        BlueOutlineButton(
                                                      width: width,
                                                      onTap: snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .isManual ==
                                                              "1"
                                                          ? () {
                                                              _orderProvider.orderTrackExpandListSingleUpdate(
                                                                  index,
                                                                  !_orderProvider
                                                                          .orderTrackExpandList[
                                                                      index]);
                                                            }
                                                          : () {
                                                              try {
                                                                _orderProvider
                                                                        .orderIdToTrack =
                                                                    "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                                _orderProvider
                                                                        .userDeliveryAddress =
                                                                    LatLng(
                                                                  double.parse(snapshot.data.response[0].userDeliveryAddress[0].latitudes ==
                                                                              "" ||
                                                                          snapshot.data.response[0].userDeliveryAddress[0].latitudes ==
                                                                              null
                                                                      ? "21.969138705424697"
                                                                      : snapshot
                                                                          .data
                                                                          .response[
                                                                              0]
                                                                          .userDeliveryAddress[
                                                                              0]
                                                                          .longitude),
                                                                  double.parse(snapshot.data.response[0].userDeliveryAddress[0].longitude ==
                                                                              "" ||
                                                                          snapshot.data.response[0].userDeliveryAddress[0].longitude ==
                                                                              null
                                                                      ? "77.69074838608503"
                                                                      : snapshot
                                                                          .data
                                                                          .response[
                                                                              0]
                                                                          .userDeliveryAddress[
                                                                              0]
                                                                          .longitude),
                                                                );
                                                                _orderProvider
                                                                        .orderDatum =
                                                                    _orderDetailsModel
                                                                        .response[
                                                                            0]
                                                                        .orderData[index];
                                                                homeProvider
                                                                        .selectedString =
                                                                    "OrderTrackingStatus";
                                                              } catch (e) {
                                                                _orderProvider
                                                                        .orderIdToTrack =
                                                                    "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                                homeProvider
                                                                        .showMapInTrackingPage =
                                                                    false;
                                                                homeProvider
                                                                        .selectedString =
                                                                    "OrderTrackingStatus";
                                                              }
                                                            },
                                                      title: "ORDER STATUS",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _orderDetailsModel
                                                      .response[0]
                                                      .orderData[index]
                                                      .userReqCancel ==
                                                  "1"
                                              ? _orderDetailsModel
                                                          .response[0]
                                                          .orderData[index]
                                                          .cancelApproved ==
                                                      "0"
                                                  ? Expanded(
                                                      child: BlueOutlineButton(
                                                        width: width * 2,
                                                        height: 30.0,
                                                        onTap: () async {
                                                          subOrderId =
                                                              _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .subOrderNo;
                                                          orderId =
                                                              _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .orderNo;

                                                          var data =
                                                              await OrderHistoryAPI
                                                                  .cancelOrderRequestFromOrderId(
                                                                      orderId,
                                                                      subOrderId);
                                                          OrderDetailsModel
                                                              orderResponse =
                                                              OrderDetailsModel
                                                                  .fromJson(
                                                                      data);
                                                          Get.showSnackbar(
                                                              GetBar(
                                                            message:
                                                                orderResponse
                                                                    .message,
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
                                                            backgroundColor:
                                                                colorPalette
                                                                    .navyBlue,
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ));
                                                          setState(() {});
                                                        },
                                                        title:
                                                            "ORDER REQUESTED CANCEL",
                                                      ),
                                                    )
                                                  : SizedBox()
                                              : _orderDetailsModel
                                                          .response[0]
                                                          .orderData[index]
                                                          .isCancelAvailable ==
                                                      "1"
                                                  ? Expanded(
                                                      child: BlueOutlineButton(
                                                        width: width * 2,
                                                        height: 30.0,
                                                        onTap: () async {
                                                          subOrderId =
                                                              _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .subOrderNo;
                                                          orderId =
                                                              _orderDetailsModel
                                                                  .response[0]
                                                                  .orderData[
                                                                      index]
                                                                  .orderNo;

                                                          var data =
                                                              await OrderHistoryAPI
                                                                  .cancelOrderFromOrderId(
                                                                      orderId,
                                                                      subOrderId);
                                                          OrderDetailsModel
                                                              orderResponse =
                                                              OrderDetailsModel
                                                                  .fromJson(
                                                                      data);
                                                          Get.showSnackbar(
                                                              GetBar(
                                                            message:
                                                                orderResponse
                                                                    .message,
                                                            snackPosition:
                                                                SnackPosition
                                                                    .TOP,
                                                            backgroundColor:
                                                                colorPalette
                                                                    .navyBlue,
                                                            duration: Duration(
                                                                seconds: 1),
                                                          ));
                                                          setState(() {});
                                                        },
                                                        title: "ORDER CANCEL",
                                                      ),
                                                    )
                                                  : SizedBox(),
                                        ],
                                      ),
                                    ),
                                    /*  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: BlueOutlineButton(
                                          width: width,
                                          onTap: () {
                                            _orderProvider.orderIdToTrack =
                                                "${snapshot.data.response[0].orderData[index].subOrderNo}";

                                            homeProvider.showMapInTrackingPage =
                                                false;
                                            homeProvider.selectedString =
                                                "OrderTrackingStatus";
                                          },
                                          title: "Order Status",
                                        ),
                                      ),
                                    ),*/
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                              _orderProvider.orderTrackExpandList[index]
                                  ? FutureBuilder(
                                      future: getTrackingInformation(
                                          "${snapshot.data.response[0].orderData[index].subOrderNo}"),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Order Packed Date : ${snapshot.data.response[0].orderPackedDate}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          colorPalette.navyBlue,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Order Tracking Number : ${snapshot.data.response[0].trackingNumber}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          colorPalette.navyBlue,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Order Shipping Date : ${snapshot.data.response[0].shippingInfoDate}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          colorPalette.navyBlue,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Order Shipping Info : ${snapshot.data.response[0].shippingInfo}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          colorPalette.navyBlue,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                SizedBox(height: 20),
                                                Divider(
                                                  height: 20,
                                                  color: colorPalette.navyBlue,
                                                  thickness: 2,
                                                  indent: width / 2.5,
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      colorPalette.navyBlue),
                                            ),
                                          );
                                        }
                                      })
                                  : SizedBox(),
                            ],
                          );
                        }),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xffb7b7b7),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].fname} ${snapshot.data.response[0].userDeliveryAddress[0].lname} \n${snapshot.data.response[0].userDeliveryAddress[0].mobile} ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: const Color(0xff000000),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].address1},\n${snapshot.data.response[0].userDeliveryAddress[0].address2} \n${snapshot.data.response[0].userDeliveryAddress[0].city}, ${snapshot.data.response[0].userDeliveryAddress[0].state},\n${snapshot.data.response[0].userDeliveryAddress[0].pincode}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: const Color(0xffa9a9aa),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        height: width / 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Payment Mode : ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${snapshot.data.response[0].order[0].paymentMethod}",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff515c6f),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PriceDetail(
                        width: width,
                        height: height,
                        itemCount: snapshot.data.response[0].orderData.length,
                        totalOfItem:
                            '${snapshot.data.response[0].orderSummary[0].finalPrice}',
                        tax:
                            '${snapshot.data.response[0].orderSummary[0].finalTaxPrice}',
                        deliverCharge:
                            '${snapshot.data.response[0].orderSummary[0].finalDeliveryPrice}',
                        mainTotal:
                            '${snapshot.data.response[0].orderSummary[0].finalTotalPrice}',
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                ),
              ),
            );
          }
        });
  }
}

import 'package:bookmrk/model/order_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class OrderStatus extends StatefulWidget {
  final OrderDatum orderData;
  OrderStatus(this.orderData);

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Text(
            'Order Status',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              color: const Color(0xff3a3a3c),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: widget.orderData.cancelApproved == "2"
                  ? Column(
                      children: [
                        OrderTrackIcons(
                            context: context,
                            title: "User requested to cancel",
                            time: widget.orderData.userReqCancelDate,
                            flag: widget.orderData.userReqCancel == "1"
                                ? true
                                : false),
                        DottedDivider(),
                        OrderTrackIcons(
                            context: context,
                            title: "Admin reject cancel from user",
                            time: widget.orderData.cancelApprovedDate,
                            flag: widget.orderData.cancelApproved == "2"
                                ? true
                                : false),
                        DottedDivider(),
                        OrderTrackIcons(
                            context: context,
                            title: "Reject reason ",
                            time: widget.orderData.cancelApprovedDate,
                            flag: widget.orderData.cancelApproved == "2"
                                ? true
                                : false),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Cancel Reason : ${widget.orderData.cancelReason}")),
                      ],
                    )
                  : Column(
                      children: [
                        OrderTrackIcons(
                            context: context,
                            title: "User requested to cancel",
                            time: widget.orderData.userReqCancelDate,
                            flag: widget.orderData.userReqCancel == "1"
                                ? true
                                : false),
                        DottedDivider(),
                        OrderTrackIcons(
                            context: context,
                            title: "Admin accept cancel from user",
                            time: widget.orderData.cancelApprovedDate,
                            flag: widget.orderData.cancelApproved == "1"
                                ? true
                                : false),
                        DottedDivider(),
                        OrderTrackIcons(
                            context: context,
                            title: "Is refunded",
                            time: widget.orderData.refundedDate,
                            flag: widget.orderData.isRefundInitiate == "1"
                                ? true
                                : false),
                        DottedDivider(),
                        OrderTrackIcons(
                            context: context,
                            title: "Cancel Done",
                            time: widget.orderData.isCancelDate,
                            flag: widget.orderData.isCancelDone == "1"
                                ? true
                                : false),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Refund Info : ${widget.orderData.refundInfo}")),
                      ],
                    ),
            ),
          ),
        ),

        /*     Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'your verification code is ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                            color: const Color(0xff3a3a3c),
                          ),
                        ),
                        TextSpan(
                          text: '${snapshot.data.response[0].userVerifyCode} ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            color: const Color(0xff3a3a3c),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ]),
                    ),
                  ),*/
        /*
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        )*/
      ],
    );
  }

  Widget OrderTrackIcons({context, flag, title, time, onTap}) {
    return Row(
      children: [
        flag
            ? SvgPicture.asset(
                "assets/icons/check.svg",
                height: 50,
                width: 50,
              )
            : SvgPicture.asset(
                "assets/icons/notCheck.svg",
                height: 50,
                width: 50,
              ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: const Color(0xff3a3a3c),
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffb8b8b8),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        )
      ],
    );
  }

  Widget DottedDivider() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Color(0xff707070),
            thickness: 4,
            width: 50,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Colors.transparent,
            thickness: 4,
            width: 50,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Color(0xff707070),
            thickness: 4,
            width: 50,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Colors.transparent,
            thickness: 4,
            width: 50,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Color(0xff707070),
            thickness: 4,
            width: 50,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Colors.transparent,
            thickness: 4,
            width: 50,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 5,
          child: VerticalDivider(
            color: Color(0xff707070),
            thickness: 4,
            width: 50,
          ),
        ),
      ],
    );
  }
}

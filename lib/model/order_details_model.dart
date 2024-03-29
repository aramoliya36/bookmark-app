// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.order,
    this.userDeliveryAddress,
    this.orderData,
    this.orderSummary,
  });

  List<Order> order;
  List<UserDeliveryAddress> userDeliveryAddress;
  List<OrderDatum> orderData;
  List<OrderSummary> orderSummary;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
        userDeliveryAddress: List<UserDeliveryAddress>.from(
            json["user_delivery_address"]
                .map((x) => UserDeliveryAddress.fromJson(x))),
        orderData: List<OrderDatum>.from(
            json["order_data"].map((x) => OrderDatum.fromJson(x))),
        orderSummary: List<OrderSummary>.from(
            json["order_summary"].map((x) => OrderSummary.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order": List<dynamic>.from(order.map((x) => x.toJson())),
        "user_delivery_address":
            List<dynamic>.from(userDeliveryAddress.map((x) => x.toJson())),
        "order_data": List<dynamic>.from(orderData.map((x) => x.toJson())),
        "order_summary":
            List<dynamic>.from(orderSummary.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.orderNo,
    this.userId,
    this.paymentMethod,
    this.orderTotalCost,
    this.orderDateTime,
    this.orderCompleted,
    this.orderStatus,
    this.userMetaId,
  });

  String orderNo;
  String userId;
  String paymentMethod;
  String orderTotalCost;
  DateTime orderDateTime;
  String orderCompleted;
  String orderStatus;
  String userMetaId;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderNo: json["order_no"],
        userId: json["user_id"],
        paymentMethod: json["payment_method"],
        orderTotalCost: json["order_total_cost"],
        orderDateTime: DateTime.parse(json["order_date_time"]),
        orderCompleted: json["order_completed"],
        orderStatus: json["order_status"],
        userMetaId: json["user_meta_id"],
      );

  Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "user_id": userId,
        "payment_method": paymentMethod,
        "order_total_cost": orderTotalCost,
        "order_date_time": orderDateTime.toIso8601String(),
        "order_completed": orderCompleted,
        "order_status": orderStatus,
        "user_meta_id": userMetaId,
      };
}

class OrderDatum {
  OrderDatum(
      {this.subOrderNo,
      this.orderConfirmed,
      this.orderConfirmedDate,
      this.isManual,
      this.orderPacked,
      this.orderPackedDate,
      this.delivered,
      this.deliveredDate,
      this.trackingNumber,
      this.shippingInfo,
      this.shippingInfoDate,
      this.isInvoiceMade,
      this.invoiceLink,
      this.orderDetail,
      this.isCancelAvailable,
      this.orderCancelBtn,
      this.userReqCancel,
      this.userReqCancelDate,
      this.cancelApproved,
      this.cancelApprovedDate,
      this.cancelReason,
      this.orderNo,
      this.isRefundInitiate,
      this.refundedDate,
      this.refundInfo,
      this.refundPrice,
      this.isRefundComplete,
      this.isCancelDone,
      this.isCancelDate});

  String orderNo;
  String subOrderNo;
  String orderConfirmed;
  String orderConfirmedDate;
  String isManual;
  String orderPacked;
  String orderPackedDate;
  String delivered;
  String deliveredDate;
  String trackingNumber;
  String shippingInfo;
  String shippingInfoDate;
  String isInvoiceMade;
  String invoiceLink;
  String isCancelAvailable;
  String orderCancelBtn;
  String userReqCancel;
  String userReqCancelDate;
  String cancelApproved;
  String cancelApprovedDate;
  String cancelReason;
  String isRefundInitiate;
  String refundedDate;
  String refundInfo;
  String refundPrice;
  String isRefundComplete;
  String isCancelDone;
  String isCancelDate;
  List<OrderDetail> orderDetail;

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        orderNo: json["order_no"],
        subOrderNo: json["sub_order_no"],
        orderConfirmed: json["order_confirmed"],
        orderConfirmedDate: json["order_confirmed_date"],
        isManual: json["is_manual"],
        orderPacked: json["order_packed"],
        orderPackedDate: json["order_packed_date"],
        delivered: json["delivered"],
        isCancelAvailable: json['is_cancel_available'],
        orderCancelBtn: json['order_cancel_btn'],
        userReqCancel: json['user_req_cancel'],
        userReqCancelDate: json['user_req_cancel_date'],
        cancelApproved: json['cancel_approved'],
        cancelApprovedDate: json['cancel_approved_date'],
        cancelReason: json['cancel_reason'],
        deliveredDate: json["delivered_date"],
        trackingNumber: json["tracking_number"],
        shippingInfo: json["shipping_info"],
        shippingInfoDate: json["shipping_info_date"],
        isInvoiceMade: json["is_invoice_made"],
        invoiceLink: json["invoice_link"],
        isRefundInitiate: json['is_refund_initiate'],
        refundedDate: json['refunded_date'],
        refundInfo: json['refund_info'],
        refundPrice: json['refund_price'],
        isRefundComplete: json['is_refund_complete'],
        isCancelDone: json['is_cancel_done'],
        isCancelDate: json['is_cancel_date'],
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "sub_order_no": subOrderNo,
        "order_confirmed": orderConfirmed,
        "order_confirmed_date": orderConfirmedDate,
        "is_manual": isManual,
        "order_packed": orderPacked,
        "order_packed_date": orderPackedDate,
        "delivered": delivered,
        "delivered_date": deliveredDate,
        "tracking_number": trackingNumber,
        "shipping_info": shippingInfo,
        "shipping_info_date": shippingInfoDate,
        "is_invoice_made": isInvoiceMade,
        "invoice_link": invoiceLink,
        'is_cancel_available': isCancelAvailable,
        'order_cancel_btn': orderCancelBtn,
        'user_req_cancel': userReqCancel,
        'user_req_cancel_date': userReqCancelDate,
        'cancel_approved': cancelApproved,
        'cancel_approved_date': cancelApprovedDate,
        'cancel_reason': cancelReason,
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
        'is_refund_initiate': this.isRefundInitiate,
        'refunded_date': this.refundedDate,
        'refund_info': this.refundInfo,
        'refund_price': this.refundPrice,
        'is_refund_complete': this.isRefundComplete,
        'is_cancel_done': this.isCancelDone,
        'is_cancel_date': this.isCancelDate,
      };
}

class OrderDetail {
  OrderDetail({
    this.productId,
    this.productSlug,
    this.productName,
    this.productQty,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productGst,
    this.vendorSlug,
    this.schoolSlug,
    this.type,
    this.productType,
    this.variation,
    this.additionalSet,
    this.categoryName,
    this.productImg,
    this.vendorCompanyName,
    this.studentName,
    this.studentRoll,
    this.orderReturnBtn,
    this.orderReplaceBtn,
    this.orderReturnLinkShow,
    this.orderReplaceLinkShow,
    this.orderReturnLink,
    this.orderReplaceLink,
    this.orderReturnLinkShowError,
    this.orderReplaceLinkShowError,
    this.returnDaysAvailableTillDate,
    this.replaceDaysAvailableTillDate,
  });

  String productId;
  String productSlug;
  String productName;
  String productQty;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productGst;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String variation;
  String additionalSet;
  String categoryName;
  String productImg;
  String vendorCompanyName;
  String studentName;
  String studentRoll;
  String orderReturnBtn;
  String orderReplaceBtn;
  String orderReturnLinkShow;
  String orderReplaceLinkShow;
  String orderReturnLink;
  String orderReplaceLink;
  String orderReturnLinkShowError;
  String orderReplaceLinkShowError;
  String returnDaysAvailableTillDate;
  String replaceDaysAvailableTillDate;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        productName: json["product_name"],
        productQty: json["product_qty"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productGst: json["product_gst"],
        vendorSlug: json["vendor_slug"],
        schoolSlug: json["school_slug"],
        type: json["type"],
        productType: json["product_type"],
        variation: json["variation"],
        additionalSet: json["additional_set"],
        categoryName: json["category_name"],
        productImg: json["product_img"],
        vendorCompanyName: json["vendor_company_name"],
        studentName: json["student_name"],
        studentRoll: json["student_roll"],
        orderReturnBtn: json['order_return_btn'],
        orderReplaceBtn: json['order_replace_btn'],
        orderReturnLinkShow: json['order_return_link_show'],
        orderReplaceLinkShow: json['order_replace_link_show'],
        orderReturnLink: json['order_return_link'],
        orderReplaceLink: json['order_replace_link'],
        orderReturnLinkShowError: json['order_return_link_show_error'],
        orderReplaceLinkShowError: json['order_replace_link_show_error'],
        returnDaysAvailableTillDate: json['return_days_available_till_date'],
        replaceDaysAvailableTillDate: json['replace_days_available_till_date'],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "product_name": productName,
        "product_qty": productQty,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_gst": productGst,
        "vendor_slug": vendorSlug,
        "school_slug": schoolSlug,
        "type": type,
        "product_type": productType,
        "variation": variation,
        "additional_set": additionalSet,
        "category_name": categoryName,
        "product_img": productImg,
        "vendor_company_name": vendorCompanyName,
        "student_name": studentName,
        "student_roll": studentRoll,
        'order_return_btn': this.orderReturnBtn,
        'order_replace_btn': this.orderReplaceBtn,
        'order_return_link_show': this.orderReturnLinkShow,
        'order_replace_link_show': this.orderReplaceLinkShow,
        'order_return_link': this.orderReturnLink,
        'order_replace_link': this.orderReplaceLink,
        'order_return_link_show_error': this.orderReturnLinkShowError,
        'order_replace_link_show_error': this.orderReplaceLinkShowError,
        'return_days_available_till_date': this.returnDaysAvailableTillDate,
        'replace_days_available_till_date': this.replaceDaysAvailableTillDate,
      };
}

class OrderSummary {
  OrderSummary({
    this.finalPrice,
    this.finalTaxPrice,
    this.finalDeliveryPrice,
    this.finalTotalPrice,
  });

  String finalPrice;
  String finalTaxPrice;
  String finalDeliveryPrice;
  String finalTotalPrice;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        finalPrice: json["final_price"],
        finalTaxPrice: json["final_tax_price"],
        finalDeliveryPrice: json["final_delivery_price"],
        finalTotalPrice: json["final_total_price"],
      );

  Map<String, dynamic> toJson() => {
        "final_price": finalPrice,
        "final_tax_price": finalTaxPrice,
        "final_delivery_price": finalDeliveryPrice,
        "final_total_price": finalTotalPrice,
      };
}

class UserDeliveryAddress {
  UserDeliveryAddress({
    this.fname,
    this.mname,
    this.lname,
    this.email,
    this.mobile,
    this.address1,
    this.address2,
    this.countries,
    this.state,
    this.city,
    this.pincode,
    this.latitudes,
    this.longitude,
  });

  String fname;
  String mname;
  String lname;
  String email;
  String mobile;
  String address1;
  String address2;
  String countries;
  String state;
  String city;
  String pincode;
  String latitudes;
  String longitude;

  factory UserDeliveryAddress.fromJson(Map<String, dynamic> json) =>
      UserDeliveryAddress(
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        email: json["email"],
        mobile: json["mobile"],
        address1: json["address1"],
        address2: json["address2"],
        countries: json["countries"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        latitudes: json["latitudes"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "email": email,
        "mobile": mobile,
        "address1": address1,
        "address2": address2,
        "countries": countries,
        "state": state,
        "city": city,
        "pincode": pincode,
        "latitudes": latitudes,
        "longitude": longitude,
      };
}

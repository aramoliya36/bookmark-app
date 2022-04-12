class NewCartDetailsModel {
  int status;
  String message;
  int count;
  List<Response> response;

  NewCartDetailsModel({this.status, this.message, this.count, this.response});

  NewCartDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      response = new List<Response>();
      json['response'].forEach((v) {
        response.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.response != null) {
      data['response'] = this.response.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  List<CartNew> cart;
  List<CartInfoNew> cartInfo;

  Response({this.cart, this.cartInfo});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = new List<CartNew>();
      json['cart'].forEach((v) {
        cart.add(new CartNew.fromJson(v));
      });
    }
    if (json['cart_info'] != null) {
      cartInfo = new List<CartInfoNew>();
      json['cart_info'].forEach((v) {
        cartInfo.add(new CartInfoNew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    if (this.cartInfo != null) {
      data['cart_info'] = this.cartInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartNew {
  String cartId;
  String productType;
  String additionalSet;
  String variation;
  String productId;
  String productName;
  String productSlug;
  String productImg;
  String productPrice;
  String qty;
  String productDiscount;
  String productSalePrice;
  String productPriceWithoutTax;
  String productGst;
  String productGstQtyTotal;
  String productFinalTotal;
  String productSavingTotal;
  String studentName;
  String studentRoll;
  String pvsmId;
  String variationsOptionsName;
  List<String> variationsDetails;
  String additionalSetIds;
  List<String> additionalSetDetails;
  String productStockStatus;

  CartNew(
      {this.cartId,
      this.productType,
      this.additionalSet,
      this.variation,
      this.productId,
      this.productName,
      this.productSlug,
      this.productImg,
      this.productPrice,
      this.qty,
      this.productDiscount,
      this.productSalePrice,
      this.productPriceWithoutTax,
      this.productGst,
      this.productGstQtyTotal,
      this.productFinalTotal,
      this.productSavingTotal,
      this.studentName,
      this.studentRoll,
      this.pvsmId,
      this.variationsOptionsName,
      this.variationsDetails,
      this.additionalSetIds,
      this.additionalSetDetails,
      this.productStockStatus});

  CartNew.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    productType = json['product_type'];
    additionalSet = json['additional_set'];
    variation = json['variation'];
    productId = json['product_id'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    productImg = json['product_img'];
    productPrice = json['product_price'];
    qty = json['qty'];
    productDiscount = json['product_discount'];
    productSalePrice = json['product_sale_price'];
    productPriceWithoutTax = json['product_price_without_tax'];
    productGst = json['product_gst'];
    productGstQtyTotal = json['product_gst_qty_total'];
    productFinalTotal = json['product_final_total'];
    productSavingTotal = json['product_saving_total'];
    studentName = json['student_name'];
    studentRoll = json['student_roll'];
    pvsmId = json['pvsm_id'];
    variationsOptionsName = json['variations_options_name'];
    variationsDetails = json['variations_details'].cast<String>();
    additionalSetIds = json['additional_set_ids'];
    additionalSetDetails = json['additional_set_details'].cast<String>();
    productStockStatus = json['product_stock_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['product_type'] = this.productType;
    data['additional_set'] = this.additionalSet;
    data['variation'] = this.variation;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_slug'] = this.productSlug;
    data['product_img'] = this.productImg;
    data['product_price'] = this.productPrice;
    data['qty'] = this.qty;
    data['product_discount'] = this.productDiscount;
    data['product_sale_price'] = this.productSalePrice;
    data['product_price_without_tax'] = this.productPriceWithoutTax;
    data['product_gst'] = this.productGst;
    data['product_gst_qty_total'] = this.productGstQtyTotal;
    data['product_final_total'] = this.productFinalTotal;
    data['product_saving_total'] = this.productSavingTotal;
    data['student_name'] = this.studentName;
    data['student_roll'] = this.studentRoll;
    data['pvsm_id'] = this.pvsmId;
    data['variations_options_name'] = this.variationsOptionsName;
    data['variations_details'] = this.variationsDetails;
    data['additional_set_ids'] = this.additionalSetIds;
    data['additional_set_details'] = this.additionalSetDetails;
    data['product_stock_status'] = this.productStockStatus;
    return data;
  }
}

class CartInfoNew {
  dynamic isCouponCodeApplicable;
  dynamic isCouponCodeInsert;
  String couponCodeMsg;
  String couponCodeStatus;
  String ccCcId;
  String ccCouponCode;
  String ccDiscount;
  String ccCouponFor;
  String ccCouponForId;
  String ccDiscountType;
  String ccMinPrice;
  String ccStartDate;
  String ccEndDate;
  String couponDiscountPrice;
  String couponDiscountMinusPrice;
  String finalPrice;
  String finalTaxPrice;
  String finalDeliveryPrice;
  String finalTotalPrice;
  String crFinalPrice;
  String crFinalTaxPrice;
  String crFinalCartPrice;
  String crFinalDeliveryPrice;
  String crFinalTotalPrice;
  String hideCheckoutButton;
  String userAddressSelected;

  CartInfoNew(
      {this.isCouponCodeApplicable,
      this.isCouponCodeInsert,
      this.couponCodeMsg,
      this.couponCodeStatus,
      this.ccCcId,
      this.ccCouponCode,
      this.ccDiscount,
      this.ccCouponFor,
      this.ccCouponForId,
      this.ccDiscountType,
      this.ccMinPrice,
      this.ccStartDate,
      this.ccEndDate,
      this.couponDiscountPrice,
      this.couponDiscountMinusPrice,
      this.finalPrice,
      this.finalTaxPrice,
      this.finalDeliveryPrice,
      this.finalTotalPrice,
      this.crFinalPrice,
      this.crFinalTaxPrice,
      this.crFinalCartPrice,
      this.crFinalDeliveryPrice,
      this.crFinalTotalPrice,
      this.hideCheckoutButton,
      this.userAddressSelected});

  CartInfoNew.fromJson(Map<String, dynamic> json) {
    isCouponCodeApplicable = json['is_coupon_code_applicable'];
    isCouponCodeInsert = json['is_coupon_code_insert'];
    couponCodeMsg = json['coupon_code_msg'];
    couponCodeStatus = json['coupon_code_status'];
    ccCcId = json['cc_cc_id'];
    ccCouponCode = json['cc_coupon_code'];
    ccDiscount = json['cc_discount'];
    ccCouponFor = json['cc_coupon_for'];
    ccCouponForId = json['cc_coupon_for_id'];
    ccDiscountType = json['cc_discount_type'];
    ccMinPrice = json['cc_min_price'];
    ccStartDate = json['cc_start_date'];
    ccEndDate = json['cc_end_date'];
    couponDiscountPrice = json['coupon_discount_price'];
    couponDiscountMinusPrice = json['coupon_discount_minus_price'];
    finalPrice = json['final_price'];
    finalTaxPrice = json['final_tax_price'];
    finalDeliveryPrice = json['final_delivery_price'];
    finalTotalPrice = json['final_total_price'];
    crFinalPrice = json['cr_final_price'];
    crFinalTaxPrice = json['cr_final_tax_price'];
    crFinalCartPrice = json['cr_final_cart_price'];
    crFinalDeliveryPrice = json['cr_final_delivery_price'];
    crFinalTotalPrice = json['cr_final_total_price'];
    hideCheckoutButton = json['hide_checkout_button'];
    userAddressSelected = json['user_address_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_coupon_code_applicable'] = this.isCouponCodeApplicable;
    data['is_coupon_code_insert'] = this.isCouponCodeInsert;
    data['coupon_code_msg'] = this.couponCodeMsg;
    data['coupon_code_status'] = this.couponCodeStatus;
    data['cc_cc_id'] = this.ccCcId;
    data['cc_coupon_code'] = this.ccCouponCode;
    data['cc_discount'] = this.ccDiscount;
    data['cc_coupon_for'] = this.ccCouponFor;
    data['cc_coupon_for_id'] = this.ccCouponForId;
    data['cc_discount_type'] = this.ccDiscountType;
    data['cc_min_price'] = this.ccMinPrice;
    data['cc_start_date'] = this.ccStartDate;
    data['cc_end_date'] = this.ccEndDate;
    data['coupon_discount_price'] = this.couponDiscountPrice;
    data['coupon_discount_minus_price'] = this.couponDiscountMinusPrice;
    data['final_price'] = this.finalPrice;
    data['final_tax_price'] = this.finalTaxPrice;
    data['final_delivery_price'] = this.finalDeliveryPrice;
    data['final_total_price'] = this.finalTotalPrice;
    data['cr_final_price'] = this.crFinalPrice;
    data['cr_final_tax_price'] = this.crFinalTaxPrice;
    data['cr_final_cart_price'] = this.crFinalCartPrice;
    data['cr_final_delivery_price'] = this.crFinalDeliveryPrice;
    data['cr_final_total_price'] = this.crFinalTotalPrice;
    data['hide_checkout_button'] = this.hideCheckoutButton;
    data['user_address_selected'] = this.userAddressSelected;
    return data;
  }
}

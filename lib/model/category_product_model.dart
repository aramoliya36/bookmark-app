import 'dart:core';

class CategoryProductsModel {
  int status;
  String message;
  int count;
  List<Response> response;

  CategoryProductsModel({this.status, this.message, this.count, this.response});

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
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
  List<Category> category;
  List<SubCategory> subCategory;
  List<Product> product;
  Response({this.category, this.subCategory, this.product});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      subCategory = new List<SubCategory>();
      json['sub_category'].forEach((v) {
        subCategory.add(new SubCategory.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = new List<Product>();
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.subCategory != null) {
      data['sub_category'] = this.subCategory.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }


    return data;
  }
}

class Category {
  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;
  String allProductsCount;
  int isFilterExits;

  Category(
      {this.categoryId,
      this.catSlug,
      this.categoryName,
      this.categoryImg,
      this.allProductsCount,this.isFilterExits});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    catSlug = json['cat_slug'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    isFilterExits = json['is_filter_exits'];

    allProductsCount = json['all_products_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['cat_slug'] = this.catSlug;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['is_filter_exits'] = this.isFilterExits;

    data['all_products_count'] = this.allProductsCount;
    return data;
  }
}

class SubCategory {
  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;

  SubCategory(
      {this.categoryId, this.catSlug, this.categoryName, this.categoryImg});

  SubCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    catSlug = json['cat_slug'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['cat_slug'] = this.catSlug;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    return data;
  }
}

class Product {
  String productId;
  String productSlug;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String variation;
  String additionalSet;
  String categoryName;
  String productImg;
  String productName;
  List<String> author;
  List<Publisher> publisher;
  List<ClassFilter> classFilter;
  List<Subject> subject;
  String language;
  String bookType;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String quantity;
  String vendorCompanyName;
  String productStockStatus;
  String productInUserWishlist;
  String productShareLink;

  Product(
      {this.productId,
      this.productSlug,
      this.vendorSlug,
      this.schoolSlug,
      this.type,
      this.productType,
      this.variation,
      this.additionalSet,
      this.categoryName,
      this.productImg,
      this.productName,
      this.author,
      this.publisher,
      this.classFilter,
      this.subject,
      this.language,
      this.bookType,
      this.productPrice,
      this.productDiscount,
      this.productSalePrice,
      this.quantity,
      this.vendorCompanyName,
      this.productStockStatus,
      this.productInUserWishlist,
      this.productShareLink});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productSlug = json['product_slug'];
    vendorSlug = json['vendor_slug'];
    schoolSlug = json['school_slug'];
    type = json['type'];
    productType = json['product_type'];
    variation = json['variation'];
    additionalSet = json['additional_set'];
    categoryName = json['category_name'];
    productImg = json['Product_img'];
    productName = json['product_name'];
    if (json['author'] != null) {
      author = json['author'].cast<String>();
    }
    if (json['publisher'] != null) {
      publisher = new List<Publisher>();
      json['publisher'].forEach((v) {
        publisher.add(new Publisher.fromJson(v));
      });
    }
    if (json['class'] != null) {
      classFilter = new List<ClassFilter>();
      json['class'].forEach((v) {
        classFilter.add(new ClassFilter.fromJson(v));
      });
    }
    if (json['subject'] != null) {
      subject = new List<Subject>();
      json['subject'].forEach((v) {
        subject.add(new Subject.fromJson(v));
      });
    }
    language = json['language'];
    bookType = json['book_type'];
    productPrice = json['product_price'];
    productDiscount = json['product_discount'];
    productSalePrice = json['product_sale_price'];
    quantity = json['quantity'];
    vendorCompanyName = json['vendor_company_name'];
    productStockStatus = json['product_stock_status'];
    productInUserWishlist = json['product_in_user_wishlist'];
    productShareLink = json['product_share_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_slug'] = this.productSlug;
    data['vendor_slug'] = this.vendorSlug;
    data['school_slug'] = this.schoolSlug;
    data['type'] = this.type;
    data['product_type'] = this.productType;
    data['variation'] = this.variation;
    data['additional_set'] = this.additionalSet;
    data['category_name'] = this.categoryName;
    data['Product_img'] = this.productImg;
    data['product_name'] = this.productName;
    if (this.author != null) {
      data['author'] = this.author;
    }
    if (this.publisher != null) {
      data['publisher'] = this.publisher.map((v) => v.toJson()).toList();
    }
    if (this.classFilter != null) {
      data['class'] = this.classFilter.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.map((v) => v.toJson()).toList();
    }
    data['language'] = this.language;
    data['book_type'] = this.bookType;
    data['product_price'] = this.productPrice;
    data['product_discount'] = this.productDiscount;
    data['product_sale_price'] = this.productSalePrice;
    data['quantity'] = this.quantity;
    data['vendor_company_name'] = this.vendorCompanyName;
    data['product_stock_status'] = this.productStockStatus;
    data['product_in_user_wishlist'] = this.productInUserWishlist;
    data['product_share_link'] = this.productShareLink;
    return data;
  }
}

class Publisher {
  String publisherId;
  String publisherSlug;
  String publisherName;
  String publisherImg;
  String filterType;

  Publisher(
      {this.publisherId,
      this.publisherSlug,
      this.publisherName,
      this.publisherImg,
      this.filterType});

  Publisher.fromJson(Map<String, dynamic> json) {
    publisherId = json['publisher_id'];
    publisherSlug = json['publisher_slug'];
    publisherName = json['publisher_name'];
    publisherImg = json['publisher_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publisher_id'] = this.publisherId;
    data['publisher_slug'] = this.publisherSlug;
    data['publisher_name'] = this.publisherName;
    data['publisher_img'] = this.publisherImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}

class Class {
  String classId;
  String classSlug;
  String className;
  String classImg;
  String filterType;

  Class(
      {this.classId,
      this.classSlug,
      this.className,
      this.classImg,
      this.filterType});

  Class.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    classSlug = json['class_slug'];
    className = json['class_name'];
    classImg = json['class_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['class_slug'] = this.classSlug;
    data['class_name'] = this.className;
    data['class_img'] = this.classImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}

class Subject {
  String subjectId;
  String subjectSlug;
  String subjectName;
  String subjectImg;
  String filterType;

  Subject(
      {this.subjectId,
      this.subjectSlug,
      this.subjectName,
      this.subjectImg,
      this.filterType});

  Subject.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    subjectSlug = json['subject_slug'];
    subjectName = json['subject_name'];
    subjectImg = json['subject_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_slug'] = this.subjectSlug;
    data['subject_name'] = this.subjectName;
    data['subject_img'] = this.subjectImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}

class Filters {
  List<Publisher> publisher;
  List<ClassFilter> classFilter;
  List<Subject> subject;

  Filters({this.publisher, this.classFilter, this.subject});

  Filters.fromJson(Map<String, dynamic> json) {
    if (json['publisher'] != null) {
      publisher = new List<Publisher>();
      json['publisher'].forEach((v) {
        publisher.add(new Publisher.fromJson(v));
      });
    }
    if (json['class'] != null) {
      classFilter = new List<ClassFilter>();
      json['class'].forEach((v) {
        classFilter.add(new ClassFilter.fromJson(v));
      });
    }
    if (json['subject'] != null) {
      subject = new List<Subject>();
      json['subject'].forEach((v) {
        subject.add(new Subject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publisher != null) {
      data['publisher'] = this.publisher.map((v) => v.toJson()).toList();
    }
    if (this.classFilter != null) {
      data['class'] = this.classFilter.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClassFilter {
  String classId;
  String classSlug;
  String className;
  String classImg;
  String filterType;

  ClassFilter(
      {this.classId,
      this.classSlug,
      this.className,
      this.classImg,
      this.filterType});

  ClassFilter.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'];
    classSlug = json['class_slug'];
    className = json['class_name'];
    classImg = json['class_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class_id'] = this.classId;
    data['class_slug'] = this.classSlug;
    data['class_name'] = this.className;
    data['class_img'] = this.classImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}





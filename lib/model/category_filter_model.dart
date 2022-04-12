import 'category_product_model.dart';

class CategoryFilterModel {
  int status;
  String message;
  int count;
  List<Response> response;

  CategoryFilterModel({this.status, this.message, this.count, this.response});

  CategoryFilterModel.fromJson(Map<String, dynamic> json) {
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
  List<Category> categoryList;
  List<Filters> filtersList;
  List<SubCategory> subCategoryList;

  Response({this.categoryList, this.filtersList, this.subCategoryList});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      categoryList = new List<Category>();
      json['category'].forEach((v) {
        categoryList.add(new Category.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filtersList = new List<Filters>();
      json['filters'].forEach((v) {
        filtersList.add(new Filters.fromJson(v));
      });
    }
    if (json['sub_category'] != null) {
      subCategoryList = new List<SubCategory>();
      json['sub_category'].forEach((v) {
        subCategoryList.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categoryList != null) {
      data['category'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    if (this.filtersList != null) {
      data['filters'] = this.filtersList.map((v) => v.toJson()).toList();
    }
    if (this.subCategoryList != null) {
      data['sub_category'] = this.subCategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;
  int isFilterExits;

  Category(
      {this.categoryId, this.catSlug, this.categoryName, this.categoryImg,this.isFilterExits});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    catSlug = json['cat_slug'];
    categoryName = json['category_name'];
    categoryImg = json['category_img'];
    isFilterExits = json['is_filter_exits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['cat_slug'] = this.catSlug;
    data['category_name'] = this.categoryName;
    data['category_img'] = this.categoryImg;
    data['is_filter_exits'] = this.isFilterExits;
    return data;
  }
}

class Filters {
  String filterName;
  List<FilterData> filterDataList;

  Filters({this.filterName, this.filterDataList});

  Filters.fromJson(Map<String, dynamic> json) {
    filterName = json['filter_name'];
    if (json['filter_data'] != null) {
      filterDataList = new List<FilterData>();
      json['filter_data'].forEach((v) {
        filterDataList.add(new FilterData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_name'] = this.filterName;
    if (this.filterDataList != null) {
      data['filter_data'] = this.filterDataList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilterData {
  String filterId;
  String filterSlug;
  String filterName;
  String filterImg;
  String filterType;

  FilterData(
      {this.filterId,
        this.filterSlug,
        this.filterName,
        this.filterImg,
        this.filterType});

  FilterData.fromJson(Map<String, dynamic> json) {
    filterId = json['filter_id'];
    filterSlug = json['filter_slug'];
    filterName = json['filter_name'];
    filterImg = json['filter_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_id'] = this.filterId;
    data['filter_slug'] = this.filterSlug;
    data['filter_name'] = this.filterName;
    data['filter_img'] = this.filterImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}
class FilterCategoriesResponse {
  int status;
  String message;
  int count;
  List<ResponseFilterCategory> listResponseFilterCategory;

  FilterCategoriesResponse(
      {this.status, this.message, this.count, this.listResponseFilterCategory});

  FilterCategoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      listResponseFilterCategory = new List<ResponseFilterCategory>();
      json['response'].forEach((v) {
        listResponseFilterCategory.add(new ResponseFilterCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.listResponseFilterCategory != null) {
      data['response'] =
          this.listResponseFilterCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseFilterCategory {
  List<Publisher> publisher;
  List<Class> classData;
  List<Subject> subject;
  List<Brand> brand;

  ResponseFilterCategory(
      {this.publisher, this.classData, this.subject, this.brand});

  ResponseFilterCategory.fromJson(Map<String, dynamic> json) {
    if (json['publisher'] != null) {
      publisher = new List<Publisher>();
      json['publisher'].forEach((v) {
        publisher.add(new Publisher.fromJson(v));
      });
    }
    if (json['class'] != null) {
      classData = new List<Class>();
      json['class'].forEach((v) {
        classData.add(new Class.fromJson(v));
      });
    }
    if (json['subject'] != null) {
      subject = new List<Subject>();
      json['subject'].forEach((v) {
        subject.add(new Subject.fromJson(v));
      });
    }
    if (json['brand'] != null) {
      brand = new List<Brand>();
      json['brand'].forEach((v) {
        brand.add(new Brand.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.publisher != null) {
      data['publisher'] = this.publisher.map((v) => v.toJson()).toList();
    }
    if (this.classData != null) {
      data['class'] = this.classData.map((v) => v.toJson()).toList();
    }
    if (this.subject != null) {
      data['subject'] = this.subject.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand.map((v) => v.toJson()).toList();
    }
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

class Brand {
  String brandId;
  String brandSlug;
  String brandName;
  String brandImg;
  String filterType;

  Brand(
      {this.brandId,
      this.brandSlug,
      this.brandName,
      this.brandImg,
      this.filterType});

  Brand.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandSlug = json['brand_slug'];
    brandName = json['brand_name'];
    brandImg = json['brand_img'];
    filterType = json['filter_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_slug'] = this.brandSlug;
    data['brand_name'] = this.brandName;
    data['brand_img'] = this.brandImg;
    data['filter_type'] = this.filterType;
    return data;
  }
}

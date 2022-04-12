class HelpResponseModel {
  int status;
  String message;
  int count;
  List<HelpResponse> helpResponseList;

  HelpResponseModel(
      {this.status, this.message, this.count, this.helpResponseList});

  HelpResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      helpResponseList = new List<HelpResponse>();
      json['response'].forEach((v) {
        helpResponseList.add(new HelpResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.helpResponseList != null) {
      data['response'] = this.helpResponseList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HelpResponse {
  String hasId;
  String type;
  String title;
  String videoLink;
  String description;
  String image;

  HelpResponse(
      {this.hasId,
      this.type,
      this.title,
      this.videoLink,
      this.description,
      this.image});

  HelpResponse.fromJson(Map<String, dynamic> json) {
    hasId = json['has_id'];
    type = json['type'];
    title = json['title'];
    videoLink = json['video_link'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_id'] = this.hasId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['video_link'] = this.videoLink;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}

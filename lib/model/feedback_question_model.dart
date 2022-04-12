class FeedBackQuestionModel {
  int status;
  String message;
  int count;
  List<ResponseFeedBack> responseFeedBackList;

  FeedBackQuestionModel(
      {this.status, this.message, this.count, this.responseFeedBackList});

  FeedBackQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    count = json['count'];
    if (json['response'] != null) {
      responseFeedBackList = new List<ResponseFeedBack>();
      json['response'].forEach((v) {
        responseFeedBackList.add(new ResponseFeedBack.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['count'] = this.count;
    if (this.responseFeedBackList != null) {
      data['response'] =
          this.responseFeedBackList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseFeedBack {
  String fqaId;
  String questions;
  String answer;

  ResponseFeedBack({this.fqaId, this.questions, this.answer});

  ResponseFeedBack.fromJson(Map<String, dynamic> json) {
    fqaId = json['fqa_id'];
    questions = json['questions'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fqa_id'] = this.fqaId;
    data['questions'] = this.questions;
    data['answer'] = this.answer;
    return data;
  }
}

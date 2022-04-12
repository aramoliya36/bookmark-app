import 'package:bookmrk/api/feedback_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/feedback_question_model.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  /// TextField
  TextEditingController _feedBackController = TextEditingController();
  List<ResponseFeedBack> responseFeedBackList;
  String selectedValue = "Select Query";
  ColorPalette colorPalette = ColorPalette();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, _userProvider, child) => Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: FeedBackAPI.getFeedBackQuestion(),
                  builder: (context, snapSort) {
                    if (snapSort.hasData) {
                      if (snapSort.data != null) {
                        FeedBackQuestionModel feedBackQuestionModel =
                            snapSort.data;
                        if (feedBackQuestionModel.responseFeedBackList.length >
                            0) {
                          List<ResponseFeedBack> responseFeedBackList =
                              feedBackQuestionModel.responseFeedBackList;
                          List<String> listQuestion = [];
                          for (int i = 0;
                              i < responseFeedBackList.length;
                              i++) {
                            listQuestion.add(responseFeedBackList[i].questions);
                          }
                          if (listQuestion.length > 0) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PopupMenuButton<String>(
                                    itemBuilder: (context) {
                                      return listQuestion.map((str) {
                                        return PopupMenuItem(
                                          value: str,
                                          child: Text(str,
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 16,
                                                color: const Color(0xff747474),
                                                fontWeight: FontWeight.w700,
                                              )),
                                        );
                                      }).toList();
                                    },
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                            width: Get.width / 1.5,
                                            child: Text(selectedValue,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff747474),
                                                ))),
                                        Icon(Icons.arrow_drop_down),
                                      ],
                                    ),
                                    onSelected: (v) {
                                      setState(() {
                                        print('!!!===== $v');
                                        selectedValue = v;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return SizedBox();
                      }
                    } else {
                      return SizedBox();
                    }
                  }),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  'Feedback',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: const Color(0xff747474),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: colorPalette.grey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _feedBackController,
                  maxLines: 9,
                  decoration: InputDecoration(
                    hintMaxLines: 7,
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Mention Feedback Here.",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: NavyBlueButton(
                  title: "SEND",
                  context: context,
                  onClick: () async {
                    _userProvider.feedbackInProgress = true;

                    int userId = prefs.read<int>('userId');
                    dynamic response = await FeedBackAPI.giveFeedBack(
                        userId.toString(),
                        _feedBackController.text,
                        selectedValue);
                    FocusScope.of(context).requestFocus(FocusNode());

                    if (response['status'] == 200) {
                      _userProvider.feedbackInProgress = false;
                      Get.showSnackbar(GetBar(
                        message: 'feedback submit successfully !',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: colorPalette.navyBlue,
                        duration: Duration(seconds: 1),
                      ));
                    } else {
                      _userProvider.feedbackInProgress = false;

                      Get.showSnackbar(GetBar(
                        message: '${response['message']}',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: colorPalette.navyBlue,
                        duration: Duration(seconds: 1),
                      ));
                    }
                  },
                ),
              )
            ],
          ),
          Visibility(
            visible: _userProvider.feedbackInProgress,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

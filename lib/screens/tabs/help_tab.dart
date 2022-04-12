import 'dart:convert';

import 'package:bookmrk/api/help_api.dart';
import 'package:bookmrk/model/help_response_model.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/screens/video_player_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: Get.height,
        padding: EdgeInsets.only(bottom: 70),
        child: FutureBuilder(
          future: HelpArticleSectionAPI.getHelpArticle(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                HelpResponseModel helpResponseModel = snapshot.data;
                if (helpResponseModel.helpResponseList.length > 0) {
                  List<HelpResponse> helpResponseList =
                      helpResponseModel.helpResponseList;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: helpResponseList.length,
                    itemBuilder: (context, index) {
                      log("${helpResponseList[index].title}");

                      return GestureDetector(
                        onTap: () async {},
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                              color: Color(0xfff3f3f3),
                              borderRadius: BorderRadius.circular(10)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: helpResponseList[index].image,
                                  height: 90,
                                  fit: BoxFit.fill,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) => Container(
                                    // margin: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/preload.png'),
                                          fit: BoxFit.fill,
                                          colorFilter: ColorFilter.mode(
                                              Colors.white,
                                              BlendMode.colorBurn)),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    // margin: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/preload.png'),
                                          fit: BoxFit.fill,
                                          colorFilter: ColorFilter.mode(
                                              Colors.white,
                                              BlendMode.colorBurn)),
                                    ),
                                  ),
                                ),
                                // padding: EdgeInsets.all(3),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        helpResponseList[index].title != null
                                            ? '${helpResponseList[index].title}'
                                            : '',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        helpResponseList[index].description !=
                                                null
                                            ? '${helpResponseList[index].description}'
                                            : '',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 14,
                                          color: Colors.black45,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Align(
                                          alignment: Alignment.bottomRight,
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(VideoPlayerScreen(),
                                                  arguments:
                                                      helpResponseList[index]);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 70,
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: ColorPalette().orange,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "See More",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No Data found !"));
                }
              } else {
                return Center(child: Text("No Data found !"));
              }
            } else {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(ColorPalette().navyBlue),
              ));
            }
          },
        ),
      ),
    );
  }
}

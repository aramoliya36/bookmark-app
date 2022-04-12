import 'package:better_player/better_player.dart';
import 'package:bookmrk/model/help_response_model.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  HelpResponse helpResponse;

  @override
  void initState() {
    // TODO: implement initState
    helpResponse = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: SafeArea(
          child: AppBar(
            backgroundColor: Colors.white,
            // iconTheme: IconDat,
            title: Text(
              helpResponse.title != null
                  ? "${helpResponse.title}".capitalizeFirst
                  : "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xff301869),
              ),
              textAlign: TextAlign.left,
            ),
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: ColorPalette().navyBlue,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(
              helpResponse.title != null
                  ? "${helpResponse.title}".capitalizeFirst
                  : "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xff301869),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          helpResponse.videoLink != null && helpResponse.videoLink != ""
              ? AspectRatio(
                  aspectRatio: 16 / 9,
                  child: BetterPlayer.network(
                    helpResponse.videoLink,
                    betterPlayerConfiguration: BetterPlayerConfiguration(
                      aspectRatio: 16 / 9,
                    ),
                  ),
                )
              : Container(
                  height: 150,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15.0)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: helpResponse.image,
                    height: 100,
                    fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) => Container(
                      // margin: EdgeInsets.all(6),
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
                            image: AssetImage('assets/images/preload.png'),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      // margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/preload.png'),
                            fit: BoxFit.fill,
                            colorFilter: ColorFilter.mode(
                                Colors.white, BlendMode.colorBurn)),
                      ),
                    ),
                  ),
                  // padding: EdgeInsets.all(3),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Text(helpResponse.description != null
                ? helpResponse.description
                : ""),
          )
        ],
      ),
    );
  }
}

import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

Widget SearchBar(
    {width,
    title,
    onTap,
    onChanged,
    controller,
    onSearchTap,
    bool showSearchTap = true}) {
  return Material(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.only(left: 5, top: 3),
      height: width / 8,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xfff3f3f3),
        // color: Colors.red,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTap: onTap,
              onChanged: onChanged,
              controller: controller,
              onSubmitted: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 18,
                  color: Color(0xff515C6F),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xff515C6F),
                ),
              ),
            ),
          ),
          showSearchTap
              ? InkWell(
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xff301869),
                      child: Icon(
                        Icons.forward,
                        size: 15,
                      )),
                  onTap: onSearchTap,
                )
              : SizedBox()
        ],
      ),
    ),
  );
}

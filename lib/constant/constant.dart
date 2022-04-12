import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

/// API base url
// final String kBaseURL = "https://www.bookmrk.in/stage/api_";
final String kBaseURL = "https://www.bookmrk.in/api_"; //LIVE URL......
final String kMapKey = "AIzaSyAEtrOxUKf67dNmthObzJtDL3mxiFLUWa8";
final String data = "";

/// base url....
final String kSiteURL = "https://www.bookmrk.in/";

/// store data in local....
GetStorage prefs = GetStorage();

/// store key salt....
final String easeBuzzKey = "DDACQ4S667";
final String easeBuzzSalt = "B9RSMMOVG4";

// final String easeBuzzKeyTest = "EC5JN2NB7Q";
// final String easeBuzzSaltTest = "NMWDQJ2D1S";
///chnage app version
/// app version.....
final String kAppVersion = "2.0.13";
const TextStyle textFilter =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal);

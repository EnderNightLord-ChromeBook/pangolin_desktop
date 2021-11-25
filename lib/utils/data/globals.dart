/*
Copyright 2021 The dahliaOS Authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import 'dart:io';

import 'package:http/http.dart';
import 'package:pangolin/utils/api_models/bing_wallpaper_api_model.dart';
import 'package:pangolin/utils/data/models/accent_color_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pangolin/utils/wm/wm.dart';

String totalVersionNumber = "21XXXX";
String headingFeatureString =
    "dahliaOS Linux-Based " + totalVersionNumber + " ...";
String longName = "dahliaOS Linux-Based " + totalVersionNumber + " PRE-RELEASE";
String get kernel {
  if (!kIsWeb) {
    if (!Platform.isWindows) {
      ProcessResult result = Process.runSync('uname', ['-sr']);
      var kernelString = result.stdout;
      return kernelString.toString().replaceAll('\n', '');
    } else
      return "Windows";
  } else
    return "Web Build";
}

String pangolinCommit = "8c5eea993a89446b3bb0b9e313cdea1d06bf8477";
String fullPangolinVersion = "$pangolinCommit";

double horizontalPadding(BuildContext context, double size) =>
    WindowHierarchy.of(context).wmBounds.width / 2 - size / 2;

double verticalPadding(BuildContext context, double size) =>
    WindowHierarchy.of(context).wmBounds.height / 2 - size / 3.5;

List<String> timeZones = [];

List<String> wallpapers = [
  "assets/images/wallpapers/dahliaOS_white_logo_pattern_wallpaper.png",
  "assets/images/wallpapers/dahliaOS_white_wallpaper.png",
  "assets/images/wallpapers/Gradient_logo_wallpaper.png",
  "assets/images/wallpapers/Three_Bubbles.png",
  "assets/images/wallpapers/Bubbles_wallpaper.png",
  "assets/images/wallpapers/Mountains_wallpaper.png",
  "assets/images/wallpapers/mountain.jpg",
  "assets/images/wallpapers/forest.jpg",
  "assets/images/wallpapers/modern.png",
  "assets/images/wallpapers/modern_dark.png",
  "assets/images/wallpapers/wood.jpg",
  "assets/images/wallpapers/beach.jpg",
];

List<AccentColorData> accentColors = [
  AccentColorData(color: Colors.deepOrange, title: "Orange"),
  AccentColorData(color: Colors.red.shade700, title: "Red"),
  AccentColorData(color: Colors.greenAccent.shade700, title: "Green"),
  AccentColorData(color: Colors.blue, title: "Blue"),
  AccentColorData(color: Colors.purple, title: "Purple"),
  AccentColorData(color: Colors.cyan, title: "Cyan"),
  AccentColorData(color: Colors.amber, title: "Amber"),
  AccentColorData(color: null, title: "Custom Accent Color"),
];

Future<BingWallpaper> getBingWallpaper() async {
  final response = await get(
      Uri.parse(
          'http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US'),
      headers: {
        "Access-Control-Allow-Origin": "true",
        "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      });
  if (response.statusCode == 200) {
    return bingWallpaperFromJson(response.body);
  } else {
    throw Exception(
        "Failed to fetch data from the Bing's Wallpaper of the Day API.");
  }
}
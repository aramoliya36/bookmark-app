import 'package:bookmrk/api/getSubjectAPI.dart';
import 'package:bookmrk/model/filterCategoriesResponse.dart';

import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSubjects extends StatefulWidget {
  @override
  _AllSubjectsState createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {
  List<Subject> listSubjects;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return FutureBuilder(
            future: GetSubjectAPI.getSubjectPageList(),
            builder: (context, snapShot) {
              if (snapShot.hasData) {
                if (snapShot.data != null) {
                  FilterCategoriesResponse filterCategoriesResponse =
                      snapShot.data;

                  listSubjects = filterCategoriesResponse
                      .listResponseFilterCategory[0].subject;
                  if (listSubjects.length > 0) {
                    return Column(
                      children: [
                        SizedBox(height: 5.0),
                        Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: listSubjects.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 2.3),
                            itemBuilder: (context, index) {
                              return Consumer<CategoryProvider>(
                                  builder: (_, _categoryProvider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    /// FilterSPC for filter category Subject, Publisher, Class wise....
                                    data.selectedTitle =
                                        "${listSubjects[index].subjectName}";
                                    data.selectedString = "FilterS";
                                    data.selectedBottomIndex = 0;
                                    Provider.of<FilterCategoryProvider>(context,
                                                listen: false)
                                            .selectedFilterCategorySubjectSlug =
                                        listSubjects[index].subjectSlug;
                                  },
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      /* CachedNetworkImage(
                                        imageUrl:
                                            '${listSubjects[index].subjectImg}',
                                        height: height / 5.2,
                                        fit: BoxFit.fill,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          margin: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          margin: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                          margin: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/images/preload.png'),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.white,
                                                    BlendMode.colorBurn)),
                                          ),
                                        ),
                                      ),*/
                                      Container(
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: ColorPalette().navyBlue,
                                        ),
                                        child: Text(
                                          '${listSubjects[index].subjectName}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 18,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                      ],
                    );
                  } else {
                    return noDataFound();
                  }
                } else {
                  return noDataFound();
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ColorPalette().navyBlue),
                  ),
                );
              }
            });
      },
    );
  }

  noDataFound() {
    return Center(child: Text("No Data Found !"));
  }
}

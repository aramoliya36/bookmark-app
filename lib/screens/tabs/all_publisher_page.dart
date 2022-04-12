import 'package:bookmrk/api/getSubjectAPI.dart';
import 'package:bookmrk/model/filterCategoriesResponse.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPublisher extends StatefulWidget {
  @override
  _AllPublisherState createState() => _AllPublisherState();
}

class _AllPublisherState extends State<AllPublisher> {
  List<Publisher> listPublisher;

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

                  listPublisher = filterCategoriesResponse
                      .listResponseFilterCategory[0].publisher;
                  // print("listPublisher LEN ${listPublisher.length}");
                  if (listPublisher.length > 0) {
                    return Column(
                      children: [
                        SizedBox(height: 5.0),
                        Expanded(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: listPublisher.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 1.2),
                            itemBuilder: (context, index) {
                              return Consumer<CategoryProvider>(
                                  builder: (_, _categoryProvider, child) {
                                return GestureDetector(
                                  onTap: () {
                                    /// FilterSPC for filter category Subject, Publisher, Class wise....
                                    data.selectedTitle =
                                        "${listPublisher[index].publisherName}";
                                    data.selectedString = "FilterP";
                                    data.selectedBottomIndex = 0;
                                    Provider.of<FilterCategoryProvider>(context,
                                                listen: false)
                                            .selectedFilterCategoryPublisherSlug =
                                        listPublisher[index].publisherSlug;
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    height: height / 5,
                                    width: height / 5,
                                    decoration: BoxDecoration(
                                        // color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.grey)),
                                    child: Column(
                                      // fit: StackFit.expand,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${listPublisher[index].publisherImg}',
                                            height: 100,
                                            fit: BoxFit.contain,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/preload.png'),
                                                    fit: BoxFit.contain,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.white,
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/preload.png'),
                                                    fit: BoxFit.contain,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.white,
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 15),
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.all(0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // color: Colors.black.withOpacity(0.7),
                                          ),
                                          child: Text(
                                            '${listPublisher[index].publisherName}',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /* child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                        '${listPublisher[index].publisherImg}',
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
                                                    fit: BoxFit.fill,
                                                    colorFilter: ColorFilter.mode(
                                                        Colors.white,
                                                        BlendMode.colorBurn)),
                                              ),
                                            ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 15),
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        child: Text(
                                          '${listPublisher[index].publisherName}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 18,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),*/
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

import 'dart:convert';

import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_filter_model.dart';

import 'package:bookmrk/model/category_with_subcategory_model.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_controller.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:bookmrk/res/utility.dart';

class FilterSettingScreen extends StatefulWidget {
  final VoidCallback isRefresh;

  const FilterSettingScreen({Key key, this.isRefresh}) : super(key: key);

  @override
  _FilterSettingScreenState createState() => _FilterSettingScreenState();
}

class _FilterSettingScreenState extends State<FilterSettingScreen> {
  List<String> getArgumentValue = [];
  FilterController filterScreenController = Get.put(FilterController());
  Map<String, List<String>> filterMapList = <String, List<String>>{};
  String categorySlug, isCheckFilter;
  @override
  void initState() {
    // TODO: implement initState

    // print("IS INIT DATA $categorySlug  $isCheckFilter");
    getArgumentValue = Get.arguments;
    categorySlug = getArgumentValue[0];
    if (getArgumentValue.length > 1) {
      isCheckFilter = getArgumentValue[1];
    }
    if (prefs.read(categorySlug) != null && prefs.read(categorySlug) != "") {
      var list = prefs.read(categorySlug) as List;

      for (int i = 0; i < list.length; i++) {
        var listNew = list[i];
        if (listNew.length > 0) {
          var mapData = jsonDecode(prefs.read(categorySlug)[1][0]) as Map;
          var result = mapData.map((key, value) =>
              MapEntry<String, List<String>>(key, List<String>.from(value)));
          filterScreenController.initData(result);
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 50,
                width: Get.width,
                color: ColorPalette().navyBlue,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filters",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    InkWell(
                        onTap: () {
                          filterScreenController.clearFilterMap();
                          prefs.write(categorySlug, [[], []]);
                        },
                        child: Text(
                          "CLEAR",
                          style: textFilter,
                        )),
                  ],
                ),
              ),
              FutureBuilder(
                future: isCheckFilter == 'subject' ||
                        isCheckFilter == 'class' ||
                        isCheckFilter == 'publisher' ||
                        isCheckFilter == 'brand'
                    ? getFilterSubjectClass()
                    : getFilterData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      CategoryFilterModel categoryProductsModel = snapshot.data;
                      List<Filters> filtersList =
                          categoryProductsModel.response[0].filtersList;
                      print("IS MY DATA");
                      if (filtersList.length > 0) {
                        return Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: Column(
                                children:
                                    List.generate(filtersList.length, (index) {
                                  return filtersList[index]
                                              .filterDataList
                                              .length >
                                          0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            filtersList[index]
                                                        .filterDataList
                                                        .length >
                                                    0
                                                ? Container(
                                                    height: 40,
                                                    width: Get.width,
                                                    color: Colors.grey,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        filtersList[index]
                                                            .filterName
                                                            .capitalizeFirst,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ))
                                                : Text("NO DATA"),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: filtersList[index]
                                                  .filterDataList
                                                  .length,
                                              itemBuilder:
                                                  (context, indexFilter) {
                                                List<FilterData>
                                                    filterDataList =
                                                    filtersList[index]
                                                        .filterDataList;
                                                String filterName =
                                                    filtersList[index]
                                                        .filterName;
                                                String filterSlug =
                                                    filterDataList[indexFilter]
                                                        .filterSlug;
                                                String filterWiseName =
                                                    filterDataList[indexFilter]
                                                        .filterName;

                                                ///mydata
                                                return GetBuilder<
                                                        FilterController>(
                                                    builder: (FilterController
                                                        filtercontroller) {
                                                  return Container(
                                                    height: 30,
                                                    width: Get.width,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 5),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            filterWiseName,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Utility.isMultiFilter ==
                                                                "yes"
                                                            ? Expanded(
                                                                flex: 1,
                                                                child: Checkbox(
                                                                    activeColor:
                                                                        ColorPalette()
                                                                            .navyBlue,
                                                                    value: filtercontroller
                                                                            .filterMapList
                                                                            .isEmpty
                                                                        ? false
                                                                        : !filtercontroller.filterMapList.value.containsKey(
                                                                                filterName)
                                                                            ? false
                                                                            : filtercontroller.filterMapList.value[filterName].contains(
                                                                                    filterSlug)
                                                                                ? true
                                                                                : false,
                                                                    onChanged:
                                                                        (newValue) {
                                                                      filterScreenController.addFilterMap(
                                                                          key:
                                                                              filterName,
                                                                          value:
                                                                              filterSlug);
                                                                    }),
                                                              )
                                                            : Expanded(
                                                                flex: 1,
                                                                child: Radio(
                                                                  activeColor:
                                                                      ColorPalette()
                                                                          .navyBlue,
                                                                  groupValue: filtercontroller
                                                                          .filterMapList
                                                                          .isEmpty
                                                                      ? null
                                                                      : !filtercontroller
                                                                              .filterMapList
                                                                              .value
                                                                              .containsKey(filterName)
                                                                          ? null
                                                                          : filtercontroller.filterMapList.value[filterName].contains(filterSlug)
                                                                              ? filterSlug
                                                                              : null,
                                                                  value:
                                                                      filterSlug,
                                                                  onChanged:
                                                                      (value) {
                                                                    filterScreenController.addRadioFilterMap(
                                                                        key:
                                                                            filterName,
                                                                        value:
                                                                            filterSlug);
                                                                  },
                                                                ),
                                                              )
                                                      ],
                                                    ),
                                                  );
                                                });
                                              },
                                            ),
                                          ],
                                        )
                                      : SizedBox();
                                }),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return noProduct();
                      }
                    } else {
                      return noProduct();
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(ColorPalette().navyBlue),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: Get.width,
              height: 50,
              color: ColorPalette().navyBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                        widget.isRefresh();
                      },
                      child: filterButton(buttonText: 'CLOSE'),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        List<Map> listFilterEncode = [];
                        Map<String, List<String>> mapData;
                        filterScreenController.filterMapList
                            .forEach((key, value) {
                          List<String> _list = [];
                          String filterKey = jsonEncode("filter");
                          String filterSlugKey = jsonEncode("filter_slug");
                          String filterValue = jsonEncode("$key");
                          value.forEach((element) {
                            _list.add(jsonEncode(element));
                          });
                          print(
                              "IS MAP LIST ${filterScreenController.filterMapList.value}");
                          listFilterEncode.add(
                              {filterKey: filterValue, filterSlugKey: _list});
                          mapData = filterScreenController.filterMapList.value;
                        });
                        if (filterScreenController.filterMapList.length > 0) {
                          prefs.write(categorySlug, [
                            listFilterEncode,
                            [jsonEncode(mapData)]
                          ]);
                        } else {
                          prefs.write(categorySlug, [listFilterEncode, []]);
                        }
                        print("CATEGORY SLUG $categorySlug");
                        print("STORE DATA ${prefs.read(categorySlug)}");
                        Get.back();
                        widget.isRefresh();
                      },
                      child: filterButton(buttonText: 'APPLY'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

/*  Radio(
  activeColor:
  ColorPalette()
      .navyBlue,
  groupValue: filtercontroller
      .filterMapList
      .isEmpty
  ? null
      : !filtercontroller
      .filterMapList
      .value
      .containsKey(
  filterName)
  ? null
      : filtercontroller
      .filterMapList
      .value[filterName]
      .contains(filterSlug)
  ? filterSlug
      : null,
  value: filterSlug,
  onChanged:
  (value) {
  filterScreenController
      .addRadioFilterMap(
  key:
  filterName,
  value:
  filterSlug);
  },
  )*/
  Widget filterButton({String buttonText}) {
    return Center(
      child: Text(
        buttonText,
        style: textFilter,
      ),
    );
  }

  Widget noProduct() {
    return Center(
      child: Text(
        'No Products !',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Future<CategoryFilterModel> getFilterSubjectClass() async {
    int userId = prefs.read<int>('userId');

    dynamic categoryProductsDetails = await HomePageApi.subjectClassFilter(
        userId: userId.toString(),
        filterType: isCheckFilter,
        filterSlug: categorySlug,
        isFilterData: "YES",
        page: "0",
        perPage: "15",
        filterMap: "");

    if (categoryProductsDetails['response'].length == "0") {
      NoDataOrderModel _noDataModel =
          NoDataOrderModel.fromJson(categoryProductsDetails);
      return null;
    } else {
      CategoryFilterModel _categoryProductModelDetails =
          CategoryFilterModel.fromJson(categoryProductsDetails);
      print("IS CALLED");
      return _categoryProductModelDetails;
    }
  }

  Future<CategoryFilterModel> getFilterData() async {
    int userId = prefs.read<int>('userId');

    dynamic categoryProductsDetails =
        await CategoryAPI.postCategoryBySubCategoryProduct(
            userId: userId.toString(),
            categorySlug: categorySlug,
            isFilterData: "YES",
            page: "0",
            perPage: "15",
            filterMap: "");

    if (categoryProductsDetails['response'].length == "0") {
      NoDataOrderModel _noDataModel =
          NoDataOrderModel.fromJson(categoryProductsDetails);
      return null;
    } else {
      CategoryFilterModel _categoryProductModelDetails =
          CategoryFilterModel.fromJson(categoryProductsDetails);
      print("IS CALLED");
      return _categoryProductModelDetails;
    }
  }
}

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  ColorPalette colorPalette = ColorPalette();

  /// get list of category with subcategory to filter....
  Future getListOfCategoryWithSubCategory() async {
    int userId = prefs.read<int>('userId');
    dynamic response =
        await CategoryAPI.getListOfCategoryWithSubCategory(userId.toString());
    CategoryWithSubcategoryListModel _categoryWithSubcategoryModel =
        CategoryWithSubcategoryListModel.fromJson(response);
    return _categoryWithSubcategoryModel;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false)
        .selectedFilterCategoryList
        .clear();
  }

  List catList = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<CategoryProvider>(
        builder: (_, _categoryProvider, child) => FutureBuilder(
            future: getListOfCategoryWithSubCategory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: colorPalette.grey,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 16, bottom: 16),
                                  child: Text(
                                    '${snapshot.data.response[index].categoryName}',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: List.generate(
                                        snapshot.data.response[index]
                                            .subCategory.length, (subIndex) {
                                      snapshot.data.response.forEach((cat) {
                                        List subCatList = [];
                                        cat.subCategory.forEach((subCat) {
                                          subCatList.add(false);
                                        });
                                        catList.add(subCatList);
                                      });

                                      return GestureDetector(
                                        child: CheckboxListTile(
                                          value: catList[index][subIndex],
                                          onChanged: (value) {
                                            catList[index][subIndex] = value;

                                            /// state to check either category selected by user is already in filter list or not...
                                            bool _containsCategory = false;

                                            /// if selected category is already in filter list then, index to remove that category...
                                            int indexToRemove = 0;

                                            /// logic to check either category in filter list or not...
                                            for (int i = 0;
                                                i <
                                                    _categoryProvider
                                                        .selectedFilterCategoryList
                                                        .length;
                                                i++) {
                                              if (_categoryProvider
                                                  .selectedFilterCategoryList[i]
                                                  .toString()
                                                  .contains(snapshot
                                                      .data
                                                      .response[index]
                                                      .subCategory[subIndex]
                                                      .categoryName)) {
                                                _containsCategory = true;
                                                indexToRemove = i;
                                              }
                                            }

                                            /// if selected category already in filter list then remove that category...
                                            if (_containsCategory) {
                                              _categoryProvider
                                                  .selectedFilterCategoryList
                                                  .removeAt(indexToRemove);
                                            } else {
                                              /// if selected category is not in filter list then add it to filter list...
                                              _categoryProvider
                                                  .selectedFilterCategoryListAddSingle(
                                                      snapshot
                                                          .data
                                                          .response[index]
                                                          .subCategory[subIndex]
                                                          .categoryName);
                                            }

                                            setState(() {});
                                          },
                                          activeColor: Colors.transparent,
                                          checkColor: colorPalette.navyBlue,
                                          title: Text(
                                            '${snapshot.data.response[index].subCategory[subIndex].categoryName}',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              color: const Color(0xff000000),
                                              letterSpacing: 0.9100000000000001,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data.response.length,
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                    ),
                  ),
                );
              }
            }));
  }
}

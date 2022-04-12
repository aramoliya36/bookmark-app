import 'package:get/get.dart';

class FilterController extends GetxController {
  RxMap<String, List<String>> filterMapList = <String, List<String>>{}.obs;

  void addFilterMap({String key, String value}) {
    if (filterMapList.containsKey(key)) {
      if (filterMapList[key].contains(value)) {
        filterMapList[key].remove(value);
      } else {
        filterMapList[key].add(value);
      }
    } else {
      //   filterMapList.add(key, <String>[value]);
      filterMapList.addAll({
        key: <String>[value]
      });
    }
    update();
  }

  void addRadioFilterMap({String key, String value}) {
    if (filterMapList.containsKey(key)) {
      filterMapList[key].clear();
      filterMapList[key].add(value);
    } else {
      // filterMapList.add(key, <String>[value]);
      filterMapList.addAll({
        key: <String>[value]
      });
    }
    print("ADD RADIO FILTER $filterMapList");
    update();
  }

  void initData(Map<String, List<String>> filterData) {
    filterMapList = filterData.obs;
    update();
  }

  void clearFilterMap({String key, String value}) {
    filterMapList.clear();
    update();
  }
}

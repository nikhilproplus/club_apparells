import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:news_api/model/model.dart';
import 'package:news_api/service/service.dart';

class GetDataController extends GetxController {
  var isDataLoading = false.obs;

  RxList<WelcomeSuccess?> saveData = <WelcomeSuccess?>[].obs;

  var itemName = 'adiddas'.obs;
  var searchItemController = TextEditingController().obs;

  Future<bool> getDataApi() async {
    isDataLoading(true);
    try {
      saveData.clear();
      debugPrint('api called');
      var welcomeSuccessList = await DataService().getData();
      debugPrint('welcomeSuccessList fetched...');

      saveData.addAll([welcomeSuccessList]);
      debugPrint('save data list $saveData');
      if (saveData.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to get data in controller $e');
    } finally {
      isDataLoading(false);
    }
  }
}

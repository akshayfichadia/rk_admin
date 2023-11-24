import 'dart:convert';

import 'package:get/get.dart';
import 'package:rk_admin/model/call_reminder_managers.dart';
import 'package:rk_admin/resource/api_collection.dart';
import 'package:rk_admin/resource/extension.dart';
import 'package:rk_admin/resource/session_string.dart';
import 'package:rk_admin/shared/api_repository.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/shared/get_storage_repository.dart';

class ReminderCallMAnagersController extends GetxController {
  final GetStorageRepository _getStorageRepository;
  final ApiRepository _apiRepository;
  ReminderCallMAnagersController(
      this._getStorageRepository, this._apiRepository);

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  static ReminderCallMAnagersController get to => Get.find();

  @override
  void onInit() {
    getReminderCallManagerApi();
    super.onInit();
  }

  final _callReminderListDataRx =
      Rx<CallReminderManager>(CallReminderManager());
  CallReminderManager get callReminderDataList => _callReminderListDataRx.value;

  getReminderCallManagerApi() {
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository.getApi(
      reminderCallManagers,
      headers: {
        'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ',
        'Accept': 'application/json',
      },
      queryParameters: {"admin_id": _getStorageRepository.read(userIdSession)},
      success: (response) {
        _callReminderListDataRx.value = CallReminderManager.fromJson(response);
        // print("responce => $response");
        // print("callRemiderData => $callReminderDataList");
        _stateStatusRx.value = StateStatus.SUCCESS;
      },
      error: (e) {
        _stateStatusRx.value = StateStatus.FAILURE;
        Get.showErrorSnackbar(e!.message);
      },
    );
  }

  getReminderCallManagerCompleteApi(String callManagerId, String type) {
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository.postApi(
      reminderCallManagersComplete,
      headers: {
        'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ',
        'Accept': 'application/json',
      },
      data: {
        "call_manager_id": callManagerId,
        "type": type,
      },
      success: (response) {
        _stateStatusRx.value = StateStatus.SUCCESS;
        Get.back();
        getReminderCallManagerApi();
        Get.showSuccessSnackbar("Call Delete Successfully");
      },
      error: (e) {
        _stateStatusRx.value = StateStatus.FAILURE;
        Get.showErrorSnackbar(e!.message);
      },
    );
  }
}

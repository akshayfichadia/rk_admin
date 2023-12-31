import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rk_admin/model/history_list_entity.dart';
import 'package:rk_admin/resource/api_collection.dart';
import 'package:rk_admin/resource/extension.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/shared/api_repository.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/shared/get_storage_repository.dart';

class CallDetailsController extends GetxController {
  final GetStorageRepository _getStorageRepository;
  final ApiRepository _apiRepository;
  CallDetailsController(this._getStorageRepository, this._apiRepository);

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  var i = 0.obs;
  var id = 0.obs;
  String name = '';
  @override
  void onInit() {
    super.onInit();
    i.value = Get.arguments[0];
    id.value = Get.arguments[1];
    getHistoryApi();
  }

  final _historyListDataRx = Rx<HistoryListEntity>(HistoryListEntity());
  HistoryListEntity get historyListData => _historyListDataRx.value;

  getHistoryApi() {
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository.getApi(historyListApi,
        headers: {'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ'},
        queryParameters: {"call_manager_id": id.value.toString()},
        success: (response) {
      _historyListDataRx.value = HistoryListEntity.fromJson(response);
      _stateStatusRx.value = StateStatus.SUCCESS;
    }, error: (e) {
      _stateStatusRx.value = StateStatus.FAILURE;

      Get.showErrorSnackbar(e!.message);
    });
  }

  TextEditingController shortDetailsController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  DateTime todayDate = DateTime.now();

  DateTime selectedDate = DateTime.now();
  var date = '2023-01-01'.obs;
  selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: selectedDate,
        firstDate: DateTime(1949, 8),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    date.value = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  TextEditingController reminderDateController = TextEditingController();
  chooseReminderDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      helpText: "Select Date",
      cancelText: "Close",
      confirmText: "Confirm",
      errorFormatText: "Enter valid date",
      errorInvalidText: "Enter valid date Range",
      fieldLabelText: "Enter Date",
      fieldHintText: "Month/Date/Year",
      selectableDayPredicate: disableDate,
    );
    if (pickedDate != null) {
      reminderDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      print("reminderDateController => ${reminderDateController.text}");
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 365))))) {
      return true;
    }
    return false;
  }

  TextEditingController reminderTimeController = TextEditingController();
  chooseReminderTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      reminderTimeController.text = DateFormat.Hm().format(dt).toString();
      print("reminderTimeController => ${reminderTimeController.text}");
    }
  }

  void SubmitNewCall() {
    var NewDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository.postApi(
        'https://rklawfirm.in/new/api/v1/save/call-manager-data',
        headers: {
          'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ',
          'Accept': 'application/json',
        },
        data: {
          'call_manager_id': id.toString(),
          'date': NewDate.toString(),
          'next_date': date.value.toString(),
          'short_details': shortDetailsController.text,
          'remarks': remarksController.text,
          'next_reminder_date': reminderDateController.text,
          'next_reminder_time': reminderTimeController.text,
        }, success: (response) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      Get.back();
      getHistoryApi();
      Get.showSuccessSnackbar("Call Added Successfully");
    }, error: (e) {
      _stateStatusRx.value = StateStatus.FAILURE;
      Get.showErrorSnackbar(e!.message);
    });
  }

  var interviewKey = GlobalKey<FormState>();

  String? isEmptyValid(String? value) => value!.trim().validateEmpty();

  final _autoValidateRx = Rx<bool>(false);
  checkAutoValidate() {
    _autoValidateRx.value = true;
  }

  editValidate() {
    switch (interviewKey.currentState!.validate()) {
      case true:
        interviewKey.currentState!.save();
        SubmitNewCall();
        break;
      case false:
        checkAutoValidate();
        break;
    }
  }
}

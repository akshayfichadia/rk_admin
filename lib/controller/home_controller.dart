import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rk_admin/model/call_list_entity.dart';
import 'package:rk_admin/model/call_log_list.dart';
import 'package:rk_admin/resource/api_collection.dart';
import 'package:rk_admin/resource/extension.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/resource/session_string.dart';
import 'package:rk_admin/route/route.dart';
import 'package:rk_admin/shared/api_repository.dart';
import 'package:rk_admin/shared/common/state_status.dart';
import 'package:rk_admin/shared/get_storage_repository.dart';
import 'package:call_log/call_log.dart';

class HomeController extends GetxController {
  // IMPORT PACKAGE

// GET WHOLE CALL LOG

// QUERY CALL LOG (ALL PARAMS ARE OPTIONAL)
  RxList<Map<String, String>> callLogList = RxList<Map<String, String>>();
  Rx<Map<String, String>?> selectedContact = Rx<Map<String, String>>({});

  void setSelectedContact(Map<String, String>? contact) {
    selectedContact.value = contact;
  }

  String getCallName() {
    return selectedContact.value!['name'] ?? "";
  }

  String getCallNumber() {
    return selectedContact.value!['number'] ?? "";
  }

  int fromDate =
      DateTime.now().subtract(Duration(days: 2)).millisecondsSinceEpoch;
  int toDate = DateTime.now().millisecondsSinceEpoch;

  getCall() async {
    // Iterable<CallLogEntry> entrie = await CallLog.get();
    Iterable<CallLogEntry> entries = await CallLog.query(
      dateFrom: fromDate,
      dateTo: toDate,
    );
    print("entries => ${entries.length}");
    for (int i = 0; i < entries.length; i++) {
      String? name = entries.toList()[i].name;
      String? number = entries.toList()[i].number;
      Map<String, String> callInfo = {
        'name': name ?? "",
        'number': number!,
      };
      callLogList.add(callInfo);
      selectedContact.value = callLogList.first;
    }
    print("callloglist => $callLogList");
    print("callloglist length => ${callLogList.length}");
  }

  final GetStorageRepository _getStorageRepository;
  final ApiRepository _apiRepository;
  HomeController(this._getStorageRepository, this._apiRepository);

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  String name = '';
  @override
  void onInit() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    super.onInit();
    name = _getStorageRepository.read(userNameSession);
    getCallApi();
    getCall();
  }

  TextEditingController dateController = TextEditingController();
  chooseDate() async {
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
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      print("dateController => ${dateController.text}");
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 365))))) {
      return true;
    }
    return false;
  }

  TextEditingController timeController = TextEditingController();
  chooseTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      timeController.text = DateFormat.Hm().format(dt).toString();
      print("timeController => ${timeController.text}");
    }
  }

  static HomeController get to => Get.find();

  final _callListDataRx = Rx<CallListEntity>(CallListEntity());
  CallListEntity get testimonialData => _callListDataRx.value;

  getCallApi() {
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository.getApi(callListApi, headers: {
      'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ'
    }, queryParameters: {
      "admin_id": _getStorageRepository.read(userIdSession).toString()
    }, success: (response) async {
      print("Obj : $response");
      _callListDataRx.value = await CallListEntity.fromJson(response);
      listAfterFilter.value = _callListDataRx.value.data!;
      _stateStatusRx.value = StateStatus.SUCCESS;
    }, error: (e) {
      _stateStatusRx.value = StateStatus.FAILURE;

      Get.showErrorSnackbar(e!.message);
    });
  }

  TextEditingController receivedController = TextEditingController();
  TextEditingController shortController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  TextEditingController shortBriefController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  var callForListRx = Rx<List<String>>([
    'First Time New Case Inquiry',
    'Repeat Call For New Case Inquiry',
    'Running Case Related Call',
    'Appointment Related Call',
    'Formal Call',
    'Others'
  ]);
  RxString selectedCallFor = "First Time New Case Inquiry".obs;
  RxString finalSelectedCallFor = 'first_time_new_case_inquiry'.obs;

  // first_time_new_case_inquiry, repeat_call_for_new_case_inquiry , running_case_related_call , appointment_related_call , formal_call , others (You must type this lowercase and using underscore)

  onSelectedApplyingFor(value) {
    selectedCallFor.value = value;
    if (value == 'First Time New Case Inquiry') {
      finalSelectedCallFor.value = 'first_time_new_case_inquiry';
    } else if (value == 'Repeat Call For New Case Inquiry') {
      finalSelectedCallFor.value = 'repeat_call_for_new_case_inquiry';
    } else if (value == 'Running Case Related Call') {
      finalSelectedCallFor.value = 'running_case_related_call';
    } else if (value == 'Appointment Related Call') {
      finalSelectedCallFor.value = 'appointment_related_call';
    } else if (value == 'Formal Call') {
      finalSelectedCallFor.value = 'formal_call';
    } else {
      finalSelectedCallFor.value = 'others';
    }
    print(finalSelectedCallFor.value.toString());
  }

  var filterCallListMenu = Rx<List<String>>([
    'All',
    'First Time New Case Inquiry',
    'Repeat Call For New Case Inquiry',
    'Running Case Related Call',
    'Appointment Related Call',
    'Formal Call',
    'Others'
  ]);

  RxString selectedFilterCallValue = "All".obs;
  RxList<Datum> listAfterFilter = RxList();

  onSelectedFilterCallValue(value) {
    selectedFilterCallValue.value = value;
    filterAndDisplayData();
  }

  filterAndDisplayData() {
    if (selectedFilterCallValue.value == 'All') {
      listAfterFilter.addAll(testimonialData.data!);
    } else {
      List<Datum> tempList = [];

      for (var oldCall in testimonialData.data!) {
        print("old call => ${oldCall.managerStatus}");
        if (oldCall.callFor == selectedFilterCallValue.value) {
          tempList.add(oldCall);
        }
      }
      listAfterFilter.value = tempList;
      print("listAfterFilter => $listAfterFilter");
      print("listAfterFilter => ${listAfterFilter.length}");
    }
  }

  var statusListRx = Rx<List<String>>(['Pending', 'Running', 'Completed']);
  RxString selectedStatus = "Pending".obs;
  RxString finalSelectedStatus = 'pending'.obs;

  onSelectedStatus(value) {
    selectedStatus.value = value;
    if (value == 'Pending') {
      finalSelectedStatus.value = 'pending';
    } else if (value == 'Running') {
      finalSelectedStatus.value = 'running';
    } else {
      finalSelectedStatus.value = 'completed';
    }
    print(finalSelectedStatus.value.toString());
  }

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

  void SubmitCall() {
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository
        .postApi('https://rklawfirm.in/new/api/v1/save/call-manager', headers: {
      'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ',
      'Accept': 'application/json',
    }, data: {
      'admin_id': _getStorageRepository.read(userIdSession).toString(),
      'date': date.value.toString(),
      'received_by': _getStorageRepository.read(userNameSession).toString(),
      'short_order': shortController.text,
      'call_for': finalSelectedCallFor.value.toString(),
      'name': getCallName(),
      'company_name': companyController.text,
      'city': cityController.text,
      'mobile_no': getCallNumber(),
      'reference_by': referenceController.text,
      'short_brief': shortBriefController.text,
      'remarks': remarksController.text,
      'status': finalSelectedStatus.value.toString(),
      'next_reminder_date': dateController.text,
      'next_reminder_time': timeController.text,
    }, success: (response) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      Get.back();
      Get.showSuccessSnackbar("Call Added Successfully");
      getCallApi();
    }, error: (e) {
      _stateStatusRx.value = StateStatus.FAILURE;
      Get.showErrorSnackbar(e!.message);
    });
  }

  logoutApiCall() {
    _stateStatusRx.value = StateStatus.LOADING;
    _apiRepository.postApi(
      logoutApi,
      headers: {
        "Authorization": "ixvAdaTLLftJmf3CUhp7BbREZy8ADJ",
        'Accept': 'application/json',
      },
      data: {
        'device_token': _getStorageRepository.read(tokenSession).toString(),
      },
      success: (success) {
        _stateStatusRx.value = StateStatus.SUCCESS;
        print(
            "LogOut Token => ${_getStorageRepository.read(tokenSession).toString()}");
        _getStorageRepository.erase();
        Get.offAllNamed(AppRoute.login);
      },
      error: (error) {
        debugPrint("error $error");
      },
    );
  }

  var interviewKey = GlobalKey<FormState>();

  String? isEmptyValid(String? value) => value!.trim().validateEmpty();
  String? isMobileValid(String? value) => value!.trim().validateMobile();

  final _autoValidateRx = Rx<bool>(false);
  checkAutoValidate() {
    _autoValidateRx.value = true;
  }

  editValidate() {
    switch (interviewKey.currentState!.validate()) {
      case true:
        if (date.value != '15 Augustus 1999') {
          interviewKey.currentState!.save();
          SubmitCall();
        }
        break;
      case false:
        checkAutoValidate();
        break;
    }
  }
}

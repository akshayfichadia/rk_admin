import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rk_admin/resource/api_collection.dart';
import 'package:rk_admin/resource/extension.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/shared/api_repository.dart';
import 'package:rk_admin/shared/get_storage_repository.dart';

import '../shared/common/state_status.dart';

class AddReminderController extends GetxController {
  ApiRepository apiRepository;
  GetStorageRepository storageRepository;

  AddReminderController(this.apiRepository, this.storageRepository);

  late TextEditingController notesController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  late GlobalKey<FormState> formKey;

  Contact? selectedContact;

  RxList<Contact> contactList = RxList([]);

  void setSelectedContact(Contact? contact) {
    selectedContact = contact!;
  }

  String? isFieldValid(String? value) => value!.trim().validateEmpty();
  String? isContactSelected(Contact? value) {
    if (value == null) {
      return 'Please select contact';
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    _askPermissions();
    notesController = TextEditingController();
    formKey = GlobalKey();
  }

  addReminder() {
    _stateStatusRx.value = StateStatus.LOADING;
    String abc = selectedContact!.phones!.first.value!.replaceAll(" ", "");
    String number = abc.substring(abc.length -
        10); //change number 10 according to the preferred number of digits of Phone Number Excluding country code
    print(number);
    apiRepository.postApi(saveReminderCall,
        headers: {
          'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ',
          'Accept': 'application/json'
        },
        data: d.FormData.fromMap({
          'name': selectedContact!.displayName,
          'contact_no': number.toString(),
          'date': dateController.text.trim(),
          'time': timeController.text.trim(),
          'notes': notesController.text.trim()
        }), success: (response) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      Get.back();
      Get.showSuccessSnackbar("Reminder Added Successfully");
    }, error: (e) {
      log(e!.message);
      _stateStatusRx.value = StateStatus.FAILURE;
      Get.showErrorSnackbar(e!.message);
    });
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

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    }
    if (permissionStatus == PermissionStatus.granted) {
      List<Contact> finalList = [];
      List<Contact> data = await ContactsService.getContacts(withThumbnails: false);
      finalList.addAll(data);
      
      print(" final Contacts : ${finalList.length}");
      contactList.value = finalList.obs;
      print("Contacts : ${contactList.length}");
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = GetSnackBar(message: 'Access to contact data denied');
      Get.showSnackbar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
          GetSnackBar(message: 'Contact data not available on device');
      Get.showSnackbar(snackBar);
    }
  }
}

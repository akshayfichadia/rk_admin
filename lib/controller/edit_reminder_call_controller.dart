import 'dart:developer';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rk_admin/controller/reminder_call_manager_controller.dart';
import 'package:rk_admin/model/call_reminder_managers.dart';
import 'package:rk_admin/resource/api_collection.dart';
import 'package:rk_admin/resource/extension.dart';
import 'package:rk_admin/resource/extensions.dart';
import 'package:rk_admin/shared/api_repository.dart';
import 'package:rk_admin/shared/get_storage_repository.dart';

import '../shared/common/state_status.dart';

class EditReminderCallController extends GetxController {
  ApiRepository apiRepository;
  GetStorageRepository storageRepository;

  EditReminderCallController(this.apiRepository, this.storageRepository);

  late TextEditingController notesController;

  final _stateStatusRx = Rx<StateStatus>(StateStatus.INITIAL);
  StateStatus get stateStatus => _stateStatusRx.value;

  late GlobalKey<FormState> formKey;

  String? isFieldValid(String? value) => value!.trim().validateEmpty();

  late Data reminderCallData;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey();
    notesController = TextEditingController();

    if (Get.arguments != null) {
      if (Get.arguments['reminder_call'] != null) {
        reminderCallData = Get.arguments["reminder_call"];
        notesController.text = reminderCallData.notes.toString();

        if (reminderCallData.nextReminderTime != null) {
          String nextReminderTime =
              reminderCallData.nextReminderTime.toString();
          timeController.text = nextReminderTime.substring(0, 5);
        }

        if (reminderCallData.nextReminderDate != null) {
          String nextReminderDate =
              reminderCallData.nextReminderDate.toString();
          try {
            DateTime parsedDate =
                DateFormat('dd-MM-yyyy').parseStrict(nextReminderDate);
            print("parsedDate => $parsedDate");
            selectedReminderDate = parsedDate;
            reminderDate.value = DateFormat('dd-MM-yyyy').format(parsedDate);
          } catch (e) {
            print('Error parsing date: $e');
          }
        }
      }
    }
  }

  editReminderApiCall() {
    _stateStatusRx.value = StateStatus.LOADING;
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(selectedReminderDate);
    apiRepository.postApi(editReminderCall,
        headers: {
          'X-Authorization': 'ixvAdaTLLftJmf3CUhp7BbREZy8ADJ',
          'Accept': 'application/json'
        },
        data: d.FormData.fromMap({
          'reminder_call_id': reminderCallData.id,
          'date': formattedDate,
          'time': timeController.text,
          'notes': notesController.text,
        }), success: (response) {
      _stateStatusRx.value = StateStatus.SUCCESS;
      Get.back();
      ReminderCallMAnagersController.to.getReminderCallManagerApi();
    }, error: (e) {
      log(e!.message);
      _stateStatusRx.value = StateStatus.FAILURE;
      Get.showErrorSnackbar(e.message);
    });
  }

  DateTime selectedReminderDate = DateTime.now();
  var reminderDate = DateFormat('dd-MM-yyyy').format(DateTime.now()).obs;
  selectReminderDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.day,
        initialDate: selectedReminderDate,
        firstDate: DateTime(1949, 8),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedReminderDate)
      selectedReminderDate = picked;
    reminderDate.value = DateFormat('dd-MM-yyyy').format(selectedReminderDate);
    print("reminderDate => $reminderDate");
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

  // bool disableDate(DateTime day) {
  //   if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
  //       day.isBefore(DateTime.now().add(const Duration(days: 365))))) {
  //     return true;
  //   }
  //   return false;
  // }
}

String _baseUrl = 'https://rklawfirm.in/new/api';
String _subUrl = '$_baseUrl/v1';

// Home Page Api

// Auth Api
String loginApi = '$_subUrl/admin-login';
String logoutApi = '$_subUrl/admin-logout';

String callListApi = '$_subUrl/call-manager/list';
String historyListApi = '$_subUrl/call-manager-data/list';
String reminderCallManagers = '$_subUrl/reminder-call-managers/list';
String reminderCallManagersComplete =
    '$_subUrl/reminder-call-managers-complete';
String saveReminderCall = "$_subUrl/save/reminder-call";
String editReminderCall = "$_subUrl/reminder-call/edit";

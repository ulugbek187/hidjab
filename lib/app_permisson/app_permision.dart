import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';


class AppPermissions {
  static getBluetoothConnectPermission() async {
    PermissionStatus status = await Permission.bluetoothConnect.status;
    debugPrint("BluetoothConnect STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.bluetoothConnect.request();
      debugPrint("BluetoothConnect STATUS AFTER ASK:$status");
    }
  }

  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getRecognitionPermission() async {
    PermissionStatus status = await Permission.activityRecognition.status;
    debugPrint("ActivityRecognition STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.activityRecognition.request();
      debugPrint("ActivityRecognition STATUS AFTER ASK:$status");
    }
  }

  static getPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    debugPrint("Phone STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.phone.request();
      debugPrint("Phone STATUS AFTER ASK:$status");
    }
  }

  static getCalendarFullAccessPermission() async {
    PermissionStatus status = await Permission.calendarFullAccess.status;
    debugPrint("CalendarFullAccess STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.calendarFullAccess.request();
      debugPrint("CalendarFullAccess STATUS AFTER ASK:$status");
    }
  }

  static getMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;
    debugPrint("Microphone STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.microphone.request();
      debugPrint("Microphone STATUS AFTER ASK:$status");
    }
  }

  static getRequestInstallPackagesPermission() async {
    PermissionStatus status = await Permission.requestInstallPackages.status;
    debugPrint("RequestInstallPackages STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status =
      await Permission.requestInstallPackages.request();
      debugPrint("RequestInstallPackages STATUS AFTER ASK:$status");
    }
  }

  static getIgnoreBatteryOptimizationsPermission() async {
    PermissionStatus status =
    await Permission.ignoreBatteryOptimizations.status;
    debugPrint("IgnoreBatteryOptimizations STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status =
      await Permission.ignoreBatteryOptimizations.request();
      debugPrint("IgnoreBatteryOptimizations STATUS AFTER ASK:$status");
    }
  }

  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.notification,
      Permission.sms,
      Permission.manageExternalStorage,
      Permission.accessMediaLocation,
      Permission.accessNotificationPolicy,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
    await permissions.request();

    debugPrint(
        "NOTIFICATION STATUS AFTER ASK:${somePermissionsResults[Permission.notification]}");
    debugPrint(
        "SMS STATUS AFTER ASK:${somePermissionsResults[Permission.sms]}");
    debugPrint(
        "ManageExternalStorage AFTER ASK:${somePermissionsResults[Permission.speech]}");
    debugPrint(
        "AccessMediaLocation AFTER ASK:${somePermissionsResults[Permission.speech]}");
    debugPrint(
        "AccessNotificationPolicy AFTER ASK:${somePermissionsResults[Permission.speech]}");
  }
}

class PermissionList {
  final VoidCallback permissionFunction;
  final String name;

  PermissionList({
    required this.name,
    required this.permissionFunction,
  });
}

List<PermissionList> permissionsList = [
  PermissionList(
      name: "BLUETOOTH",
      permissionFunction: AppPermissions.getBluetoothConnectPermission),
  PermissionList(
      name: "CAMERA",
      permissionFunction: AppPermissions.getCameraPermission),
  PermissionList(
      name: "LOCATION",
      permissionFunction: AppPermissions.getLocationPermission),
  PermissionList(
      name: "CONTACTS",
      permissionFunction: AppPermissions.getContactsPermission),
  PermissionList(
      name: "RECOGNITION",
      permissionFunction: AppPermissions.getRecognitionPermission),
  PermissionList(
      name: "PHONE",
      permissionFunction: AppPermissions.getPhonePermission),
  PermissionList(
      name: "CALENDAR",
      permissionFunction: AppPermissions.getCalendarFullAccessPermission),
  PermissionList(
      name: "MICROPHONE",
      permissionFunction: AppPermissions.getMicrophonePermission),
  PermissionList(
      name: "IGNORE BATTERY OPTIMIZATION",
      permissionFunction:
      AppPermissions.getIgnoreBatteryOptimizationsPermission),
  PermissionList(
      name: "REQUEST INSTALL PACKAGES",
      permissionFunction: AppPermissions.getRequestInstallPackagesPermission),
  PermissionList(
      name: "SOME PERMISSIONS",
      permissionFunction: AppPermissions.getSomePermissions),
];

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // 알림 설정
import 'package:permission_handler/permission_handler.dart'; // 권한
import 'package:app_settings/app_settings.dart'; // ios 설정

final notifications = FlutterLocalNotificationsPlugin();

// 앱로드시 실행할 기본설정
initNotification() async {
  // 안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');
  // ios 앱 로드시 유저에게 권한요청
  var iosSetting = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  var initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting
  );

  await notifications.initialize(
    initializationSettings,
    //알림 누를때 함수실행하고 싶으면
    //onSelectNotification: 함수명추가
  );
}


showNotification() async {

  var androidDetails = AndroidNotificationDetails(
    '서민준',
    '배고픔',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

  var iosDetails = IOSNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(
      1,
      '지금 어떤 생각이 드냐면요..',
      '배고픔',
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload:'배민 시켜둠' // 부가정보
  );
}
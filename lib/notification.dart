import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // 알림 설정
// import 'package:permission_handler/permission_handler.dart'; // 권한
// import 'package:app_settings/app_settings.dart'; // ios 설정

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
import 'package:firebase_core/firebase_core.dart';
import 'package:flopps/entities/sleepTracker/repositories/firebase.dart';
import 'package:flopps/entities/users/repositories/AuthRepository.dart';
import 'package:flopps/entities/users/repositories/UserRepository.dart';
import 'package:flopps/firebase_options.dart';
import 'package:flopps/screens/loginScreen/LoginMain.dart';
import 'package:flopps/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'entities/assistant/repository/assistant_repository.dart';
import 'entities/sleepTracker/repositories/local_storage.dart';
import 'entities/users/repositories/storageRepository.dart';

void main() {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthRepository());
    Get.put(UserRepository());
    Get.put(StorageRepository());
    Get.put(AssistantRepository());
    Get.put(SleepTrackerFirebaseRepository());
    Get.put(SleepTrackerLocalStorageRepository());
    FlutterNativeSplash.remove();
  });
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const LoginMain());
  }
}

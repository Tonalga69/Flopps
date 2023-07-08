import 'package:flopps/entities/sleepTracker/models/model.dart';
import 'package:flopps/entities/sleepTracker/repositories/firebase.dart';
import 'package:get/get.dart';

class TrackerController extends GetxController{
  static TrackerController get instance => Get.find();
  late SleepTracker tracker;


  void getTracker() async {
    final result= await SleepTrackerFirebaseRepository.instance.getData();
    if(result!=null){
      tracker = SleepTracker.fromFirebase(result);
    }
  }


  void updateTracker(SleepTracker sleepTracker) async{
    final updatedDoc= await SleepTrackerFirebaseRepository.instance.updateTracker(sleepTracker.toJson());
    if(updatedDoc!=null){
      tracker=sleepTracker;
    }

  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flopps/entities/users/model.dart';
import 'package:flopps/entities/users/widgets/userSnackBar.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _uid = FirebaseAuth.instance.currentUser?.uid;



  Future<void> createUser(UserModel user) async {
    await db
        .collection(Collections.users)
        .doc(user.uid)
        .set(user.toJson())
        .whenComplete(() => Get.showSnackbar(accountCreated))
        .catchError((error, stackTrace) {
      Get.showSnackbar(errorCreatingAccount);
    });
  }

  Future<void> acceptFriendRequest(
      UserModel requestedUser, UserModel user) async {
    requestedUser.profilePhoto = null;
    final userAux =
        UserModel(uid: user.uid, userName: user.userName, email: user.email);

    await db.collection(Collections.users).doc(requestedUser.uid).update({
      "friends": FieldValue.arrayUnion([userAux.toJson()])
    });
    await db.collection(Collections.users).doc(user.uid).update({
      "friends": FieldValue.arrayUnion([requestedUser.toJson()])
    });
    await db.collection(Collections.users).doc(user.uid).update({
      "pendingRequests": FieldValue.arrayRemove([requestedUser.toJson()])
    });
  }

  Future<void> declineFriendRequest(
      UserModel requestedUser, UserModel user) async {
    requestedUser.profilePhoto == null;
    await db.collection(Collections.users).doc(user.uid).update({
      "pendingRequests": FieldValue.arrayRemove([requestedUser.toJson()])
    });
  }

  Future<Object?> updateUserFields(
      {required String? uid, required Map<String, dynamic> map}) async {
    try {
      await db.collection(Collections.users).doc(uid).update(map);
    } catch (e) {
      return e;
    }
    return null;
  }

  Future<void> createOrNotUser(UserModel user) async {
    DocumentSnapshot document =
        await db.collection(Collections.users).doc(user.uid).get();
    if (!document.exists) {
      createUser(user);
    }
  }

  Future<bool> sendFriendRequestTo(
      {required String uid, required UserModel sender}) async {
    try {
      await db.collection(Collections.users).doc(uid).update({
        "pendingRequests": FieldValue.arrayUnion([sender.toJson()])
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> stopBeingFriends(UserModel me, UserModel friend) async {
    await db.collection(Collections.users).doc(me.uid).update({
      "friends": FieldValue.arrayRemove([friend.toJson()])
    });
    final auxMe =
        UserModel(uid: me.uid, email: me.email, userName: me.userName);
    await db.collection(Collections.users).doc(friend.uid).update({
      "friends": FieldValue.arrayRemove([auxMe.toJson()])
    });
  }

  Future<void> cancelFriendRequest(String friendUid, UserModel me) async {
    await db.collection(Collections.users).doc(friendUid).update({
      "pendingRequests": FieldValue.arrayRemove([me.toJson()])
    });
  }

  Future<List<UserModel>?> updateFriendsList(
      String uid, friendUid, friendMail) async {
    final friend = UserModel(uid: friendUid, email: friendMail);
    await db.collection(Collections.users).doc(uid).update({
      "friends": FieldValue.arrayUnion([friend.toJson()])
    });

    final snapshot = await db.collection(Collections.users).doc(uid).get();
    return UserModel.fromFireStore(snapshot).friends;
  }

  Future<UserModel> getDetailedUserData({required String uid}) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection(Collections.users).doc(uid).get();
    if (snapshot.exists) {
      return UserModel.fromFireStore(snapshot);
    }
    return UserModel(uid: "", email: "");
  }

  Future<List<UserModel>> getUserQuery(String name, String userName) async {
    final snapshot = await db
        .collection(Collections.users)
        .where("userName", isGreaterThan: name, isNotEqualTo: userName)
        .limit(10)
        .get();
    return snapshot.docs.map((e) => UserModel.fromFireStore(e)).toList();
  }

  Future<void> setAssistant(String assistantUid, String userId) async {
    await db
        .collection(Collections.users)
        .doc(userId)
        .update({"assistantUid": assistantUid});



  }
}

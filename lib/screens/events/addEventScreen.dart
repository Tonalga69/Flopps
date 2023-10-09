import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flopps/entities/assistant/controllers/AssistantController.dart';
import 'package:flopps/entities/events/models/events.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/widgets/friends_list_item.dart';
import 'package:flopps/utils/Assets.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../entities/events/controllers/eventController.dart';
import '../../entities/users/model.dart';
import '../../entities/users/widgets/user_result_item.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final userController = UserController.instance;
  final assistantController = AssistantController.instance;
  bool _isValidUrl = true;
  final FocusNode _focusNode = FocusNode();
  final List<UserModel> guestList = List.empty(growable: true);
  final List<UserModel> assistantList = List.empty(growable: true);
  final eventController = EventController.instance;
  late double boxHeightInvitations;
  int count = 0;
  final event = Events(
      name: "",
      description: "",
      guestsIDs: [],
      locationsUrl: "",
      date: Timestamp.fromDate(DateTime(2000)),
      hostName: "",
      hostID: "");
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    count = event.assistantsIDs?.length ?? 0;
    boxHeightInvitations = count == 0 ? 200 : 100;
  }

  void _validateUrl() {
    final enteredUrl = event.locationsUrl.trim();
    setState(() {
      _isValidUrl = _isValidUrlFormat(enteredUrl);
    });
  }

  bool _isValidUrlFormat(String url) {
    // Regular expression to validate URL format
    final urlPattern = RegExp(
      r'^(http|https)?://[a-zA-Z0-9\-.]+(\.[a-zA-Z]{2,})?(:[0-9]{1,5})?(/.*)?$',
    );
    return urlPattern.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(ProjectColors.strongBlue),
        title: const Text(Strings.addEvent),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => eventController.popScreen(),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              userController.user.profilePhoto ?? Strings.defaultProfilePhoto,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 10))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 90,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(ProjectColors.blackBackground),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(5, 5),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 75,
                                height: 75,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color:
                                        const Color(ProjectColors.strongBlue)),
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    assistantController
                                            .assistant?.profilePhoto ??
                                        Strings.defaultProfilePhoto,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10, top: 10),
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        event.name = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: Strings.eventName,
                                      labelStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      hintText: Strings.eventName,
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Row(
                          children: [
                            SizedBox(
                              width: 125,
                              height: 175,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 125,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      color: Color(ProjectColors.strongBlue),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: event.locationsUrl
                                            .toLowerCase()
                                            .contains("map")
                                        ? Lottie.asset(
                                            Assets.jsonMapsPath,
                                            height: 175,
                                            width: double.infinity,
                                            repeat: false,
                                          )
                                        : Center(
                                            child: Lottie.asset(
                                            Assets.jsonUrlPath,
                                            height: 175,
                                            width: double.infinity,
                                            repeat: false,
                                          )),
                                  ),
                                  Container(
                                    width: 125,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      color:
                                          Color(ProjectColors.blackBackground),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(5, 5),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                       Strings.addUrl,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamily.sourceSansPro,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 10)),
                            Expanded(
                                child: Container(
                              width: double.infinity,
                              height: 175,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color:
                                    const Color(ProjectColors.blackBackground),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(5, 5),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                         Strings.eventLocation,
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontFamily:
                                                FontFamily.sourceSansPro,
                                            fontSize: 16,
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          _isValidUrl
                                              ? FontAwesomeIcons
                                                  .solidCircleCheck
                                              : FontAwesomeIcons
                                                  .solidCircleXmark,
                                          color: _isValidUrl
                                              ? Colors.green
                                              : Colors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: TextField(
                                      onChanged: (value) {
                                        _validateUrl();
                                        setState(() {
                                          event.locationsUrl = value;
                                        });
                                      },
                                      onEditingComplete: () {
                                        _validateUrl();
                                      },
                                      onTapOutside: (value) {
                                        _validateUrl();
                                      },
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(100),
                                      ],
                                      showCursor: true,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: Strings.eventLocation,
                                      ),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontFamily: FontFamily.sourceSansPro,
                                        fontSize: 14,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: Text(
                          Strings.eventDescription,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: FontFamily.sourceSansPro,
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(10),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(ProjectColors.blackBackground),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                          )
                        ],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (value) {
                          setState(() {
                            event.description = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: Strings.enterEventDescription,
                        ),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: FontFamily.sourceSansPro,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    ElevatedButton(
                      onPressed: _selectTime,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(ProjectColors.gray)),
                          fixedSize: MaterialStateProperty.all(
                              const Size(double.infinity, 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            FontAwesomeIcons.calendarDays,
                            size: 20,
                          ),
                          const Text(
                           Strings.setEventDate,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.sourceSansPro),
                          ),
                          Text(
                            (event.date.toDate().year != 2000)
                                ? '${event.date.toDate().hour}:${event.date.toDate().minute < 10 ? "0${event.date.toDate().minute}" : event.date.toDate().minute} ${event.date.toDate().day}/${event.date.toDate().month}/${event.date.toDate().year}'
                                : Strings.noDate,
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: FontFamily.sourceSansPro),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: [
                        Text(
                       Strings.inviteFriends,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: FontFamily.sourceSansPro,
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                        height: boxHeightInvitations,
                        padding: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(ProjectColors.white),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(5, 5),
                            )
                          ],
                        ),
                        child: event.guestsIDs.isNotEmpty
                            ? GridView.builder(
                                itemCount: guestList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 100),
                                itemBuilder: (context, index) {
                                  return FriendsListItem(
                                      friend: guestList[index]);
                                },
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                   Strings.noFriendsInvited,
                                    style: TextStyle(
                                        color: Color(
                                            ProjectColors.blackBackground),
                                        fontFamily: FontFamily.sourceSansPro,
                                        fontSize: 14,
                                        height: 1.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Lottie.asset(
                                    Assets.jsonWaitingPath,
                                    height: 150,
                                    width: 150,
                                  )
                                ],
                              )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final guest = await showSearch(
                                useRootNavigator: true,
                                context: context,
                                delegate:
                                    SearchBarDelegate(friends: guestList));

                            if (guest != null) {
                              setState(() {
                                event.guestsIDs.add(guest.uid);
                                guestList.add(guest);
                                if (count > 4 || count == 0) {
                                  boxHeightInvitations = 200;
                                }
                                if (count < 4 || count != 0) {
                                  boxHeightInvitations = 100;
                                }
                                _focusNode.unfocus();
                              });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(ProjectColors.grayBackground),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                FontAwesomeIcons.pencil,
                                size: 16,
                              ),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              Text(
                                'Add more',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamily.sourceSansPro,
                                    fontSize: 14,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Row(
                      children: [
                        Text(
                          Strings.theyWillBePresent,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: FontFamily.sourceSansPro,
                              fontSize: 16,
                              height: 1.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(ProjectColors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(5, 5),
                          )
                        ],
                      ),
                      child: event.assistantsIDs != null
                          ? GridView.builder(
                              itemCount: event.assistantsIDs?.length ?? 0,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 100),
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                    future: userController.getUserByUid(
                                        event.assistantsIDs![index]),
                                    builder: (context, snapshot) {
                                      return FriendsListItem(
                                          friend: snapshot.data ??
                                              UserModel(
                                                  uid: "",
                                                  userName: "",
                                                  profilePhoto: "",
                                                  friends: [],
                                                  email: ''));
                                    });
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'No one has accepted yet',
                                  style: TextStyle(
                                      color:
                                          Color(ProjectColors.blackBackground),
                                      fontFamily: FontFamily.sourceSansPro,
                                      fontSize: 14,
                                      height: 1.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Lottie.asset(
                                  Assets.jsonFriendsPath,
                                  height: 150,
                                  width: 150,
                                )
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                if (isReady()) {
                  event.hostID = userController.user.uid;
                  event.hostName = userController.user.userName ?? "";
                  event.guestsIDs.add(userController.user.uid);
                  eventController.addEvent(event);
                  eventController.popScreen();
                }
              },
              style: ButtonStyle(
                  backgroundColor: isReady()
                      ? MaterialStateProperty.all(
                          const Color(ProjectColors.strongBlue))
                      : MaterialStateProperty.all(
                          const Color(ProjectColors.gray)),
                  fixedSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
              child: const Text(
                'Add Event',
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isReady() {
    return event.name.isNotEmpty &&
        event.description.isNotEmpty &&
        event.locationsUrl.isNotEmpty &&
        event.guestsIDs.isNotEmpty &&
        _isValidUrl &&
        event.date.toDate().year != 2000;
  }

  void _selectTime() async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay? selectedTime = TimeOfDay.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2101),
    );

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null &&
        picked != selectedDate &&
        pickedTime != null &&
        pickedTime != selectedTime) {
      DateTime pickedDateTime = DateTime(picked.year, picked.month, picked.day,
          pickedTime.hour, pickedTime.minute);
      setState(() {
        event.date = Timestamp.fromDate(pickedDateTime);
        _focusNode.unfocus();
      });
    }
  }
}

class SearchBarDelegate extends SearchDelegate<UserModel?> {
//query already declared in SearchDelegate, contains the text in the search bar
  final _userController = UserController.instance;
  final List<UserModel> friends;

  SearchBarDelegate({required this.friends})
      : super(searchFieldLabel: "Search for a friend");

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark(useMaterial3: true);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      initialData: _userController.user.friends
          ?.where((element) =>
              element.userName!.contains(query) && friends.contains(element))
          .toList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () => close(context, snapshot.data![index]),
                    child: UserResultItem(
                      user: snapshot.data![index],
                      alreadyFriends: true,
                      canChangeFriendStatus: false,
                    ));
              });
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Error, try again later"));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: _userController.user.friends?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return !friends.contains(_userController.user.friends![index])
            ? InkWell(
                onTap: () =>
                    close(context, _userController.user.friends![index]),
                child: UserResultItem(
                  user: _userController.user.friends![index],
                  alreadyFriends: true,
                  canChangeFriendStatus: false,
                ),
              )
            : const SizedBox();
      },
    );
  }
}

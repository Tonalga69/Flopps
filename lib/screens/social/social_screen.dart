import 'package:cached_network_image/cached_network_image.dart';
import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/widgets/friend_requests.dart';
import 'package:flopps/entities/users/widgets/search_friends.dart';
import 'package:flopps/entities/users/widgets/user_result_item.dart';
import 'package:flopps/utils/DrawerMenu.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../utils/Strings.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final userController = UserController.instance;
  int currentIndexPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  final pages = [const SearchFriends(), const FriendRequestPage()];

  @override
  Widget build(BuildContext context) {
    final floatingButtons = [
      FloatingActionButton(
          onPressed: () {
            _pageController.animateToPage(1,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          child: GetBuilder<UserController>(
            builder: (controller) => Stack(
              children: [
                const Icon(
                  FontAwesomeIcons.solidBell,
                  color: Colors.white,
                ),
                if (controller.user.pendingRequests != null &&
                    controller.user.pendingRequests!.isNotEmpty)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                  )
              ],
            ),
          )),
      FloatingActionButton(
        onPressed: () {
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        child: const Icon(Icons.person, color: Colors.white),
      )
    ];
    return Scaffold(
      appBar: AppBar(
          actions: [
            GetBuilder<UserController>(builder: (controller) {
              return CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    controller.user.profilePhoto ??
                        Strings.defaultProfilePhoto),
              );
            }),
          ],
          backgroundColor: const Color(ProjectColors.strongBlue),
          systemOverlayStyle: const SystemUiOverlayStyle(),
          title: const Text(
            "Social",
            style: TextStyle(fontFamily: FontFamily.sourceSansPro),
          )),
      drawer: DrawerMenu(),
      floatingActionButton: floatingButtons[currentIndexPage],
      body: PageView(
          onPageChanged: (index) {
            setState(() {
              currentIndexPage = index;
            });
          },
          scrollDirection: Axis.vertical,
          controller: _pageController,
          children: pages),
    );
  }
}

class SearchBarDelegate extends SearchDelegate {
//query already declared in SearchDelegate, contains the text in the search bar
  final _userController = UserController.instance;

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
      future: _userController.getUserQuery(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return UserResultItem(user: snapshot.data![index]);
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
    final results = _userController.user.friends?.where((element) {
      final userName = element.userName?.toLowerCase();

      final queryLower = query.toLowerCase();
      return userName?.contains(queryLower) ?? false;
    }).toList();

    if (results != null) {
      return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(results[index].userName ?? "No name"),
            );
          });
    }
    return Container();
  }
}

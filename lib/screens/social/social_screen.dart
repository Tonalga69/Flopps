import 'package:flopps/entities/users/controllers/userController.dart';
import 'package:flopps/entities/users/widgets/search_friends.dart';
import 'package:flopps/entities/users/widgets/user_result_item.dart';
import 'package:flopps/utils/DrawerMenu.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../entities/users/model.dart';
import '../../utils/Strings.dart';

class SocialScreen extends StatefulWidget {
  SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  final userController = UserController.instance;

  int currentIndexPage = 0;

  final pages = [const SearchFriends(), Container()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                ),
                onPressed: () {
                  showSearch(useRootNavigator: true,context: context, delegate: SearchBarDelegate());
                },
              ),
              FutureBuilder(
                  future: userController.getUserData(),
                  builder:
                      (BuildContext context, AsyncSnapshot<UserModel> user) {
                    return CircleAvatar(
                      backgroundImage: NetworkImage(user.data?.profilePhoto ??
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
        body: PageView(children: pages));
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
          print("entro");
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return UserResultItem(user: snapshot.data![index]);
              });
        }
        if(snapshot.hasError){
          return const Center(child: Text("Error, try again later"));
        }
        return const Center(child: CircularProgressIndicator(

        ));
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

import 'package:flutter/material.dart';
import 'package:projeto/api/fetch_all_api.dart';
import 'package:projeto/models/model_generic.dart';

import '../../api/endpoint/profile_endpoint.dart';
import '../../api/token.dart';
import '../../components/item/profile_item.dart';
import '../../measures/pattern_measures.dart';
import '../../models/model_profile.dart';

const String appBarTitle = "Profiles";

class ProfileList extends StatefulWidget {
  final Token token;

  const ProfileList({Key? key, required this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileListState();
  }
}

class ProfileListState extends State<ProfileList> {
  late Future<List<Generic>> futureProfileList;

  @override
  void initState() {
    super.initState();
    futureProfileList =
        FetchAllApi(endpoint: ProfileEndpoint()).fetch(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appBarTitle),
      ),
      body: FutureBuilder<List<Generic>>(
        future: futureProfileList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Profile> profileList = snapshot.data! as List<Profile>;
            return ListView.builder(
              padding: PatternMeasures.listCardPadding,
              itemBuilder: (context, index) {
                final Profile profile = profileList[index];
                return ProfileItem(
                  profile: profile,
                );
              },
              itemCount: profileList.length,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

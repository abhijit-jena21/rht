import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/searchbody.dart';

class Search extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(hintColor: Colors.white.withOpacity(0.8));
    assert(theme != null);
    return theme;
  }

  List suggestions = [];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    suggestions.add(query);
    return SearchBody(
      pathUrl: "$serverLink/api/searchengine",
      userId: finalId,
      query: query,
      locationId: finalLocationId,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     title: Text(
    //       suggestions[index],
    //       style: Theme.of(context)
    //           .textTheme
    //           .headline6
    //           .copyWith(color: Colors.black87),
    //     ),
    //     onTap: () {
    //       query = suggestions[index];
    //       buildResults(context);
    //     },
    //   ),
    //   itemCount: suggestions.length,
    // );
    return Container();
  }
}

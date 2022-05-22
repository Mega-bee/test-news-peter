import 'package:flutter/material.dart';

class customSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.clear),
      ),
    ];
    // TODO: implement buildActions
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return  IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
    );
    // TODO: implement buildLeading
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return  Container();
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return  Container();
    throw UnimplementedError();
  }
}

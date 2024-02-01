import 'package:flutter/material.dart';
import 'package:hellostay/utils/place_service.dart';

import 'package:flutter/material.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider? apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //close(context, );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    print('${Localizations.localeOf(context).languageCode}______________');
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient?.fetchSuggestions(
          query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text('Enter your address'),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title:
          Text((snapshot.data?[index] as Suggestion).description),
          onTap: () {
            close(context, snapshot.data?[index] as Suggestion);
          },
        ),
        itemCount: snapshot.data?.length,
      )
          : const Text('Loading...'),
    );
  }
}


class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
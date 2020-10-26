import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/game.dart';

class GamesOptions {
  final sitemap = '/sitemap';
  final additions = '/additions';
  final developmentTeam = '/development-team';
  final gameSeries = '/game-series';
  final parentGames = '/parent-games';
  final screenShots = '/screenshots';
  final stores = '/stores';
  final achievements = '/achievements';
  final movies = '/movies';
  final reddit = '/reddit';
  final suggested = '/suggested';
  final twitch = '/twitch';
  final youtube = '/youtube';
}

///
/// You can reverse the sort order adding a hyphen, for example: -released.
///
enum Ordering {
  name,
  released,
  added,
  created,
  rating,
}

class RawgApiClient {
  factory RawgApiClient({String apiKey = ''}) {
    _singleton._apiKey = apiKey;
    return _singleton;
  }

  static final RawgApiClient _singleton = RawgApiClient._internal().._init();
  RawgApiClient._internal();

  String _apiKey;
  String _rootApi;
  String _creatorRoles;
  String _creators;
  String _developers;
  String _games;
  GamesOptions _gamesOptions;
  String _genres;
  String _platforms;
  String _platformsListsParents;
  String _publishers;
  String _stores;
  String _tags;

  http.Client _client;

  void _init() {
    _rootApi = 'api.rawg.io';
    _creatorRoles = '/creator-roles';
    _creators = '/creators';
    _developers = '/developers';
    _games = '/games';
    _gamesOptions = GamesOptions();
    _genres = '/genres';
    _platforms = '/platforms';
    _platformsListsParents = '/platforms/lists/parents';
    _publishers = '/publishers';
    _stores = '/stores';
    _tags = '/tags';
    _client = http.Client();
  }

  ///
  /// You can make your own url and use this function to request
  /// An example could be the next_url response on getGames() function or an option for /games endopoint like /games/{game_pk}/parent-games
  /// You will need to cast the map list object as you needed
  ///
  void requestCustomUrl(
    String url,
    Function(String error, String nextUrl, List<Map<String, dynamic>> objects)
        completion,
  ) {
    _client.get(url).then((response) {
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          var objectsList =
              (jsonObject['results'] as List<Map<String, dynamic>>);
          completion(null, (jsonObject['next'] as String), objectsList);
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }

  ///
  /// get games by page (by default 1) and page size (by defaul 20)
  /// You can also add more params, you can check how here https://api.rawg.io/docs/#tag/games
  ///
  void getGames({
    String page = '1',
    String pageSize = '20',
    Map<String, String> moreParams,
    @required
        Function(String error, String nextUrl, List<Game> games) completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    if (moreParams != null) {
      for (var key in moreParams.keys) {
        params[key] = moreParams[key];
      }
    }
    var uri = Uri.https(_rootApi, '/api$_games', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          var gamesList = (jsonObject['results'] as List)
              .map(
                  (dynamic game) => Game.fromJson(game as Map<String, dynamic>))
              .toList();
          completion(null, (jsonObject['next'] as String), gamesList);
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }

  ///
  /// Get a list of video game platforms.
  /// https://api.rawg.io/docs/#tag/platforms
  ///
  void getPlatforms({
    String page = '1',
    String pageSize = '20',
    Ordering ordering = Ordering.name,
    @required
        Function(String error, String nextUrl, List<Platform> platforms)
            completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    params['ordering'] = ordering.toString();
    var uri = Uri.https(_rootApi, '/api$_platforms', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          var platformList = (jsonObject['results'] as List)
              .map((dynamic platform) =>
                  Platform.fromJson(platform as Map<String, dynamic>))
              .toList();
          completion(null, (jsonObject['next'] as String), platformList);
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }

  ///
  /// Get a list of video game genres.
  /// https://api.rawg.io/docs/#tag/genres
  ///
  void getGenres({
    String page = '1',
    String pageSize = '20',
    Ordering ordering = Ordering.name,
    @required
        Function(String error, String nextUrl, List<Genres> genres) completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    params['ordering'] = ordering.toString();
    var uri = Uri.https(_rootApi, '/api$_genres', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          var genresList = (jsonObject['results'] as List)
              .map((dynamic genre) =>
                  Genres.fromJson(genre as Map<String, dynamic>))
              .toList();
          completion(null, (jsonObject['next'] as String), genresList);
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }

  ///
  /// Get a list of video game storefronts.
  /// https://api.rawg.io/docs/#tag/stores
  ///
  void getStores({
    String page = '1',
    String pageSize = '20',
    Ordering ordering = Ordering.name,
    @required
        Function(String error, String nextUrl, List<Store> stores) completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    params['ordering'] = ordering.toString();
    var uri = Uri.https(_rootApi, '/api$_stores', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          var storesList = (jsonObject['results'] as List)
              .map((dynamic store) =>
                  Store.fromJson(store as Map<String, dynamic>))
              .toList();
          completion(null, (jsonObject['next'] as String), storesList);
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }

  ///
  /// Get a list of tags.
  /// https://api.rawg.io/docs/#tag/stores
  ///
  void getTags({
    String page = '1',
    String pageSize = '20',
    @required
        Function(String error, String nextUrl, List<Tags> tags) completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    var uri = Uri.https(_rootApi, '/api$_tags', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(response.body) as Map<String, dynamic>;
          var tagsList = (jsonObject['results'] as List)
              .map((dynamic tag) => Tags.fromJson(tag as Map<String, dynamic>))
              .toList();
          completion(null, (jsonObject['next'] as String), tagsList);
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }
}

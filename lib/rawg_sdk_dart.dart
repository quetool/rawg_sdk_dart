import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'core/enums.dart';
import 'core/game.dart';

class RawgApiClient {
  factory RawgApiClient({String apiKey = ''}) {
    _singleton._apiKey = apiKey;
    return _singleton;
  }

  static final RawgApiClient _singleton = RawgApiClient._internal().._init();
  RawgApiClient._internal();

  String _apiKey;
  String _rootApi;
  // String _creatorRoles;
  // String _creators;
  // String _developers;
  String _games;
  String _genres;
  String _platforms;
  // String _platformsListsParents;
  // String _publishers;
  String _stores;
  String _tags;

  http.Client _client;

  void _init() {
    _rootApi = 'api.rawg.io';
    // _creatorRoles = '/creator-roles';
    // _creators = '/creators';
    // _developers = '/developers';
    _games = '/games';
    _genres = '/genres';
    _platforms = '/platforms';
    // _platformsListsParents = '/platforms/lists/parents';
    // _publishers = '/publishers';
    _stores = '/stores';
    _tags = '/tags';
    _client = http.Client();
  }

  ///
  /// You can make your own url and use this function to request it
  /// An example could be the next_url response on getGames() function or an option for /games endopoint like /games/{game_pk}/parent-games
  /// You will need to cast the map list object as you needed
  ///
  void requestCustomUrl(
    String url,
    Function(String error, String nextUrl, dynamic object) completion,
  ) {
    _client.get(url).then((response) {
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
          if (jsonObject.containsKey('results')) {
            var objectsList = (jsonObject['results'] as List<dynamic>);
            var nextUrl = jsonObject['next'] as String;
            completion(null, nextUrl, objectsList);
          } else {
            completion(null, null, jsonObject);
          }
        } catch (e) {
          completion(e.toString(), null, null);
        }
      } else {
        completion(response.body, null, null);
      }
    });
  }

  ///
  /// get top ten games of all time
  ///
  void getTopTenGamesAllTime({
    @required Function(String error, List<Game> games) completion,
  }) {
    getGames(
        pageSize: '10',
        moreParams: {'ordering': '-${OrderingOptions.RATING.value}'},
        completion: (String error, String nextUrl, List<Game> games) {
          completion(error, games);
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
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
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
  /// Get details of the game.
  /// https://api.rawg.io/docs/#operation/games_read
  ///
  void getGameDetails(
      String gameID, Function(String error, Game gameDetails) completion) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;

    var uri = Uri.https(_rootApi, '/api$_games/$gameID', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
          var game = Game.fromJson(jsonObject);
          completion(null, game);
        } catch (e) {
          completion(e.toString(), null);
        }
      } else {
        completion(response.body, null);
      }
    });
  }

  ///
  /// Get screenshots for the game.
  /// https://api.rawg.io/docs/#operation/games_screenshots_list
  ///
  void getGameScreenshots(String slug,
      Function(String error, List<Screenshot> screenshots) completion) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;

    var uri = Uri.https(_rootApi,
        '/api$_games/$slug/${GamesEndpoints.SCREEN_SHOTS.value}', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
          var screenshotsList = (jsonObject['results'] as List)
              .map((dynamic screenshot) =>
                  Screenshot.fromJson(screenshot as Map<String, dynamic>))
              .toList();
          completion(null, screenshotsList);
        } catch (e) {
          completion(e.toString(), null);
        }
      } else {
        completion(response.body, null);
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
    OrderingOptions ordering = OrderingOptions.NAME,
    @required
        Function(String error, String nextUrl, List<Platform> platforms)
            completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    params['ordering'] = ordering.value;
    var uri = Uri.https(_rootApi, '/api$_platforms', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
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
    OrderingOptions ordering = OrderingOptions.NAME,
    @required
        Function(String error, String nextUrl, List<Genres> genres) completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    params['ordering'] = ordering.value;
    var uri = Uri.https(_rootApi, '/api$_genres', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
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
    OrderingOptions ordering = OrderingOptions.NAME,
    @required
        Function(String error, String nextUrl, List<Store> stores) completion,
  }) {
    var params = <String, String>{};
    if (_apiKey != '') params['key'] = _apiKey;
    params['page'] = page;
    params['page_size'] = pageSize;
    params['ordering'] = ordering.value;
    var uri = Uri.https(_rootApi, '/api$_stores', params);
    print(uri.toString());
    _client.get(uri).then((response) {
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
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
      var responseString = utf8.decode(response.bodyBytes);
      if (response.statusCode == 200) {
        try {
          var jsonObject = json.decode(responseString) as Map<String, dynamic>;
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

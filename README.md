# rawg_sdk_dart

This is a very simply RAWG Dart SDK (currently under development). 

It contains methods for interacting with [RAWG API](https://rawg.io/apidocs)

## Getting Started

### Installation
For now you can add to your pubspec dependencies the following repository like this

```
  rawg_sdk_dart:
    git: https://github.com/quetool/rawg_sdk_dart
```

_I will be adding this package to pub.dev directory soon_ 🤞

### How to use
_I've made a [small sample app](https://github.com/quetool/games_store) to show how to use it._

You need to create a RawgApiClient() instance, which is a singleton and then call it functions. You can add an ApiKey if you want, you can check how to get an ApiKey here [https://rawg.io/apidocs](https://rawg.io/apidocs)

```
var rawg = RawgApiClient();
```
Or with ApiKey

```
var rawg = RawgApiClient(apiKey: 'your_api_key');
```

### A few examples:
Get Games:

```
rawg.getGames(completion: (error, nextUrl, games) {
	print(error ?? 'NO ERROR');
	print(nextUrl ?? 'NO NEXT URL');
	print(games ?? 'NO DATA');
});
```

> ***_error_*** is a `String` with an error if required

> ***_nextUrl_*** is a `String` with the next url to paginate results if required

> ***_games_*** is a `List<Game>` list of games

This is the definition of getGames():

```
void getGames({String page = '1', 
			 	 String pageSize = '20', 
				 Map<String, String> moreParams, 
			 	 Function(String, String, List<Game>) completion})
```
So, as you can see, it has optionals parameters already setted like `page` and `pageSize` and another `Map<String, String> moreParams` parameter which you can use to add more parameters to the API request.

You can see which parameters and how to use them here [https://api.rawg.io/docs/#tag/games](https://api.rawg.io/docs/#tag/games)

But let see a simple use case:

- if you want to search for "cyberpunk" game in the catalog you can use `moreParams` to add a search pattern like this:

```
rawg.getGames(moreParams: {'search': 'cyberpunk'}, completion: (error, nextUrl, games) {
	print(error ?? 'NO ERROR');
	print(nextUrl ?? 'NO NEXT URL');
	print(games ?? 'NO DATA');
});
```

This will return a list of games that match with the search criteria. This is the corresponding url [https://api.rawg.io/api/games?search=cyberpunk](https://api.rawg.io/api/games?search=cyberpunk)

You can also sort results by adding the key `ordering` to the `moreParams` map like this:

```
var params = {
      'search': 'cyberpunk',
      'ordering': OrderingOptions.RATING.value
};
rawg.getGames(moreParams: params, completion: (error, nextUrl, games) {
      print(error ?? 'NO ERROR');
      print(nextUrl ?? 'NO NEXT URL');
      print(games ?? 'NO DATA');
});
```

I facilitated an enum you can use to ordering purposes

```
enum OrderingOptions {
  NAME,
  RELEASED,
  ADDED,
  CREATED,
  RATING,
}

extension OrderingOptionsExtension on OrderingOptions {
  String get value {
    switch (this) {
      case OrderingOptions.NAME:
        return "name";
      case OrderingOptions.RELEASED:
        return "released";
      case OrderingOptions.ADDED:
        return "added";
      case OrderingOptions.CREATED:
        return "created";
      case OrderingOptions.RATING:
        return "rating";
      default:
        return null;
    }
  }

  String get reverse {
    switch (this) {
      case OrderingOptions.NAME:
        return "-name";
      case OrderingOptions.RELEASED:
        return "-released";
      case OrderingOptions.ADDED:
        return "-added";
      case OrderingOptions.CREATED:
        return "-created";
      case OrderingOptions.RATING:
        return "-rating";
      default:
        return null;
    }
  }
}
```

### More examples:

Get Game Details:

```
rawg.getGameDetails('$gameId', (error, gameDetails) {
	print(error ?? 'NO ERROR');
	print(gameDetails ?? 'NO DATA');
});
```

Get Top Ten Games of all times:

```
rawg.getTopTenGamesAllTime(completion: (error, games) {
	print(error ?? 'NO ERROR');
	print(games ?? 'NO DATA');
});
```

This package has also a function to request the API in any way you want by forming the URL the way you need. So if you want to, you can use just this only function in your app but you will need to cast or parse the resultant `object` because it will be dynamic.

```
rawg.requestCustomUrl('$customUrl', (error, nextUrl, object) {
	print(error ?? 'NO ERROR');
	print(nextUrl ?? 'NO NEXT');
	print(object ?? 'NO DATA');
});
```

`$customUrl` could be something like this: `https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-added`

So, if you know that `object` it will be a `List<Game>` you will need to map it like this:

```
var customUrl = 'https://api.rawg.io/api/games?dates=2019-01-01,2019-12-31&ordering=-added';
rawg.requestCustomUrl('$customUrl', (error, nextUrl, object) {
	if (error == null) {
		var gamesList = object
            .map((dynamic e) => Game.fromJson(e as Map<String, dynamic>))
            .toList();
	}
});
```

`Game` it is the main object of this package. You can find it definition on `lib/core/` folder

-------

More documentation will be added soon...

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.



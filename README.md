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
You need to create a RawgApiClient() instance, which is a singleton and then call it functions. You can add an ApiKey if you want, you can check how to get an ApiKey here [https://rawg.io/apidocs](https://rawg.io/apidocs)

```
var rawg = RawgApiClient();
```

### A few examples:
Get Games:

```
rawg.getGames(completion: (error, nextUrl, games) {
	//
});
```

*error* is a String with an error if required

*nextUrl* is a String with the next url to paginate results if required

*games* is a list of games

This is the definition of getGames():

```
void getGames({String page = '1', 
			 String pageSize = '20', 
			 Map<String, String> moreParams, 
			 dynamic Function(String, String, List<Game>) completion})
```
So, as you can see, it has optionals parameters already setted like page and pageSize and another Map<String, String> moreParams parameter which you can use to add more parameters to the API. You can see which ones here [https://api.rawg.io/docs/#tag/games](https://api.rawg.io/docs/#tag/games)

For example, if you want to search for cyberpunk game in the catalog you can use moreParams like this:

```
rawg.getGames(moreParams: {'search': 'cyberpunk'}, completion: (error, nextUrl, games) {
	//
});
```
You can also ordering results by adding the parameter to the request

```
moreParams: {'ordering': '${OrderingOptions.RATING.value}'},
```
Or in reverse order (add - (minus) to the order string)

```
moreParams: {'ordering': '-${OrderingOptions.RATING.value}'},
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
}
```

### More examples:

Get Game Details:

```
rawg.getGameDetails('$gameId', (error, gameDetails) {
	//
});
```

Get Top Ten Games of all times:

```
rawg.getTopTenGamesAllTime(completion: (error, games) {
	//
});
```

This package has also a function to request any url you want

```
rawg.requestCustomUrl('$customUrl', (error, nextUrl, objects) {
	//
});
```


More documentation will be added soon...

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.



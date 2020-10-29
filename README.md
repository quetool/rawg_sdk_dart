# rawg_sdk_dart

This is RAWG Dart SDK (currently under development). 

This library contains methods for interacting with [RAWG API](https://rawg.io/apidocs)

## Getting Started

### Installation
Just add to your pubspec dependencies the following

```
  rawg_sdk_dart:
    git: https://github.com/quetool/rawg_sdk_dart
```

### How to use
You need to create a RawgApiClient() instance, which is a singleton and then call it functions

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



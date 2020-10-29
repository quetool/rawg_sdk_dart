enum GamesEndpoints {
  SITEMAP,
  ADDITIONS,
  DEVELOPMENT_TEAM,
  GAME_SERIES,
  PARENT_GAMES,
  SCREEN_SHOTS,
  STORES,
  ACHIEVEMENTS,
  MOVIES,
  REDDIT,
  SUGGESTED,
  TWITCH,
  YOUTUBE,
}

extension GamesEndpointsExtension on GamesEndpoints {
  String get value {
    switch (this) {
      case GamesEndpoints.SITEMAP:
        return "sitemap";
      case GamesEndpoints.ADDITIONS:
        return "additions";
      case GamesEndpoints.DEVELOPMENT_TEAM:
        return "development-team";
      case GamesEndpoints.GAME_SERIES:
        return "game-series";
      case GamesEndpoints.PARENT_GAMES:
        return "parent-games";
      case GamesEndpoints.SCREEN_SHOTS:
        return "screenshots";
      case GamesEndpoints.STORES:
        return "stores";
      case GamesEndpoints.ACHIEVEMENTS:
        return "achievements";
      case GamesEndpoints.MOVIES:
        return "movies";
      case GamesEndpoints.REDDIT:
        return "reddit";
      case GamesEndpoints.SUGGESTED:
        return "suggested";
      case GamesEndpoints.TWITCH:
        return "twitch";
      case GamesEndpoints.YOUTUBE:
        return "youtube";
      default:
        return null;
    }
  }
}

///
/// You can reverse the sort order adding a hyphen, for example: -released
///
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

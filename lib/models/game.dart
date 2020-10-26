import 'dart:math';

class Game {
  Game({
    this.slug,
    this.name,
    this.playtime,
    this.platforms,
    this.released,
    this.tba,
    this.backgroundImage,
    this.rating,
    this.id,
    this.genres,
    this.shortScreenshots,
    this.price,
    this.stores,
    this.ratingTop,
    this.ratings,
    this.ratingsCount,
    this.reviewsTextCount,
    this.added,
    this.addedByStatus,
    this.metacritic,
    this.suggestionsCount,
    this.clip,
    this.tags,
    this.reviewsCount,
    this.saturatedColor,
    this.dominantColor,
  });

  Game.fromJson(Map<String, dynamic> json) {
    slug = json['slug'] as String;
    name = json['name'] as String;
    playtime = json['playtime'] as int;
    if (json['platforms'] != null) {
      platforms = <Platforms>[];
      json['platforms'].forEach((dynamic v) {
        platforms.add(Platforms.fromJson(v as Map<String, dynamic>));
      });
    }
    released = json['released'] as String;
    tba = json['tba'] as bool;
    backgroundImage = json['background_image'] as String;
    rating = json['rating'] as double;
    id = json['id'] as int;
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((dynamic v) {
        genres.add(Genres.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['short_screenshots'] != null) {
      shortScreenshots = <ShortScreenshots>[];
      json['short_screenshots'].forEach((dynamic v) {
        shortScreenshots
            .add(ShortScreenshots.fromJson(v as Map<String, dynamic>));
      });
    }
    price = Random().nextInt(10000);
  }

  String slug;
  String name;
  int playtime;
  List<Platforms> platforms;
  String released;
  bool tba;
  String backgroundImage;
  double rating;
  int id;
  List<Genres> genres;
  List<ShortScreenshots> shortScreenshots;
  int price;
  List<Stores> stores;
  int ratingTop;
  List<Ratings> ratings;
  int ratingsCount;
  int reviewsTextCount;
  int added;
  AddedByStatus addedByStatus;
  int metacritic;
  int suggestionsCount;
  Clip clip;
  List<Tags> tags;
  int reviewsCount;
  String saturatedColor;
  String dominantColor;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['playtime'] = playtime;
    if (platforms != null) {
      data['platforms'] = platforms.map((v) => v.toJson()).toList();
    }
    data['released'] = released;
    data['tba'] = tba;
    data['background_image'] = backgroundImage;
    data['rating'] = rating;
    data['id'] = id;
    if (genres != null) {
      data['genres'] = genres.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Platforms {
  Platforms({this.platform});

  Platforms.fromJson(Map<String, dynamic> json) {
    platform = json['platform'] != null
        ? Platform.fromJson(json['platform'] as Map<String, dynamic>)
        : null;
  }

  Platform platform;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (platform != null) {
      data['platform'] = platform.toJson();
    }
    return data;
  }
}

class Platform {
  Platform({this.id, this.name, this.slug});

  Platform.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    slug = json['slug'] as String;
  }

  int id;
  String name;
  String slug;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class Genres {
  Genres({this.id, this.name, this.slug});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    slug = json['slug'] as String;
  }

  int id;
  String name;
  String slug;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class ShortScreenshots {
  ShortScreenshots({this.id, this.image});

  ShortScreenshots.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    image = json['image'] as String;
  }

  int id;
  String image;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}

class Stores {
  Stores({this.store});

  Stores.fromJson(Map<String, dynamic> json) {
    store = json['store'] != null
        ? Store.fromJson(json['store'] as Map<String, dynamic>)
        : null;
  }

  Store store;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (store != null) {
      data['store'] = store.toJson();
    }
    return data;
  }
}

class Store {
  Store({this.id, this.name, this.slug});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    slug = json['slug'] as String;
  }

  int id;
  String name;
  String slug;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    return data;
  }
}

class Ratings {
  Ratings({this.id, this.title, this.count, this.percent});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    title = json['title'] as String;
    count = json['count'] as int;
    percent = json['percent'] as double;
  }

  int id;
  String title;
  int count;
  double percent;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['count'] = count;
    data['percent'] = percent;
    return data;
  }
}

class AddedByStatus {
  AddedByStatus(
      {this.yet,
      this.owned,
      this.beaten,
      this.toplay,
      this.dropped,
      this.playing});

  AddedByStatus.fromJson(Map<String, dynamic> json) {
    yet = json['yet'] as int;
    owned = json['owned'] as int;
    beaten = json['beaten'] as int;
    toplay = json['toplay'] as int;
    dropped = json['dropped'] as int;
    playing = json['playing'] as int;
  }

  int yet;
  int owned;
  int beaten;
  int toplay;
  int dropped;
  int playing;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['yet'] = yet;
    data['owned'] = owned;
    data['beaten'] = beaten;
    data['toplay'] = toplay;
    data['dropped'] = dropped;
    data['playing'] = playing;
    return data;
  }
}

class Clip {
  Clip({this.clip, this.clips, this.video, this.preview});

  Clip.fromJson(Map<String, dynamic> json) {
    clip = json['clip'] as String;
    clips = json['clips'] != null
        ? Clips.fromJson(json['clips'] as Map<String, dynamic>)
        : null;
    video = json['video'] as String;
    preview = json['preview'] as String;
  }

  String clip;
  Clips clips;
  String video;
  String preview;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['clip'] = clip;
    if (clips != null) {
      data['clips'] = clips.toJson();
    }
    data['video'] = video;
    data['preview'] = preview;
    return data;
  }
}

class Clips {
  Clips({this.s320, this.s640, this.full});

  Clips.fromJson(Map<String, dynamic> json) {
    s320 = json['320'] as String;
    s640 = json['640'] as String;
    full = json['full'] as String;
  }

  String s320;
  String s640;
  String full;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['320'] = s320;
    data['640'] = s640;
    data['full'] = full;
    return data;
  }
}

class Tags {
  Tags(
      {this.id,
      this.name,
      this.slug,
      this.language,
      this.gamesCount,
      this.imageBackground});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    slug = json['slug'] as String;
    language = json['language'] as String;
    gamesCount = json['games_count'] as int;
    imageBackground = json['image_background'] as String;
  }

  int id;
  String name;
  String slug;
  String language;
  int gamesCount;
  String imageBackground;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['language'] = language;
    data['games_count'] = gamesCount;
    data['image_background'] = imageBackground;
    return data;
  }
}

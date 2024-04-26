import 'package:json_annotation/json_annotation.dart';
import 'package:pine/pine.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Category {
  final String? alias;
  final String? title;

  Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Hours {
  @JsonKey(name: 'is_open_now')
  final bool? isOpenNow;

  const Hours({
    this.isOpenNow,
  });

  factory Hours.fromJson(Map<String, dynamic> json) => _$HoursFromJson(json);

  Map<String, dynamic> toJson() => _$HoursToJson(this);
}

@JsonSerializable()
class User {
  final String? id;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final String? name;

  const User({
    this.id,
    this.imageUrl,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Review {
  final String? id;
  final int? rating;
  final User? user;

  const Review({
    this.id,
    this.rating,
    this.user,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;

  Location({
    this.formattedAddress,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Restaurant {
  final String? id;
  final String? name;
  final String? price;
  final double? rating;
  final List<String>? photos;
  final List<Category>? categories;
  final List<Hours>? hours;
  final List<Review>? reviews;
  final Location? location;

  const Restaurant({
    this.id,
    this.name,
    this.price,
    this.rating,
    this.photos,
    this.categories,
    this.hours,
    this.reviews,
    this.location,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);

  /// Use the first category for the category shown to the user
  String get displayCategory {
    if (categories != null && categories!.isNotEmpty) {
      return categories!.first.title ?? '';
    }
    return '';
  }

  /// Use the first image as the image shown to the user
  String get heroImage {
    if (photos != null && photos!.isNotEmpty) {
      return photos!.first;
    }
    return '';
  }

  /// This logic is probably not correct in all cases but it is ok
  /// for this application
  bool get isOpen {
    if (hours != null && hours!.isNotEmpty) {
      return hours!.first.isOpenNow ?? false;
    }
    return false;
  }
}

@JsonSerializable()
class RestaurantQueryResult extends DTO {
  final int? total;
  @JsonKey(name: 'business')
  final List<Restaurant>? restaurants;

  const RestaurantQueryResult({
    this.total,
    this.restaurants,
  });

  factory RestaurantQueryResult.fromJson(Map<String, dynamic> json) =>
      _$RestaurantQueryResultFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantQueryResultToJson(this);

  factory RestaurantQueryResult.mocked() {
    return RestaurantQueryResult.fromJson(
      {
        "total": 6255,
        "business": [
          {
            "id": "vHz2RLtfUMVRPFmd7VBEHA",
            "name": "Gordon Ramsay Hell's Kitchen",
            "price": "\$\$\$",
            "rating": 4.4,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg",
            ],
            "reviews": [
              {
                "id": "AyuEBJGqEQZWWjgSz_nkkA",
                "rating": 5,
                "user": {
                  "id": "2I5SuEHDd9SJVHfrj84wOw",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/extlS3a8KgRPfYhdaiu2pw/o.jpg",
                  "name": "Daisy G.",
                },
              },
              {
                "id": "H85bnGMvTx0ACssHvyCyug",
                "rating": 5,
                "user": {
                  "id": "3xfzp3cOhKICnLn0D9ZheA",
                  "image_url": null,
                  "name": "Molly S.",
                },
              },
              {
                "id": "1evz7BLmFEa2WaMLIiQoiw",
                "rating": 5,
                "user": {
                  "id": "5LMqMp2QMVLMikT6Qmrnnw",
                  "image_url": null,
                  "name": "Dev S.",
                },
              }
            ],
            "categories": [
              {"title": "New American", "alias": "newamerican"},
              {"title": "Seafood", "alias": "seafood"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3570 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "faPVqws-x-5k2CQKDNtHxw",
            "name": "Yardbird",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/xYJaanpF3Dl1OovhmpqAYw/o.jpg",
            ],
            "reviews": [
              {
                "id": "uIeZrx9X1W0XPKqDicXZew",
                "rating": 5,
                "user": {
                  "id": "nvcvPpKYpq-nT7wwAexGYw",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/2_pHFKGZ3-SlBq_HTXp8wg/o.jpg",
                  "name": "Tanner D.",
                },
              },
              {
                "id": "edavucuT6AszroxABpt80A",
                "rating": 5,
                "user": {
                  "id": "gjSzROrU_pDjtzG4CaO3eQ",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/Nqduv6WoR8b-5bzPROZ79A/o.jpg",
                  "name": "Danelle S.",
                },
              },
              {
                "id": "w0ZDi1gh3D14maL9f4iDJg",
                "rating": 5,
                "user": {
                  "id": "49fOxINbIM9tOdJPNpulqQ",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/qfpShlrNitoLx6CaW2ByEQ/o.jpg",
                  "name": "Melissa B.",
                },
              }
            ],
            "categories": [
              {"title": "Southern", "alias": "southern"},
              {"title": "New American", "alias": "newamerican"},
              {"title": "Cocktail Bars", "alias": "cocktailbars"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3355 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "syhA1ugJpyNLaB0MiP19VA",
            "name": "888 Japanese BBQ",
            "price": "\$\$\$",
            "rating": 4.8,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/V_zmwCUG1o_vR29xfkb-ng/o.jpg",
            ],
            "reviews": [
              {
                "id": "CfkhNXxjrmAG3Rqth2S8PA",
                "rating": 5,
                "user": {
                  "id": "Lh3eh4seBFvfTgybYXL1uw",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/oztzeYdcy2lE6edfoXhapQ/o.jpg",
                  "name": "Christine X.",
                },
              },
              {
                "id": "mOutCc88-Uk2nzyi3FqAmw",
                "rating": 5,
                "user": {
                  "id": "vv5vFZg3YuxjGJ5wU4L0Gw",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/NqS6X2oVKk4iOP1NFy6BSA/o.jpg",
                  "name": "Mark D.",
                },
              },
              {
                "id": "BVXWtpN-Xn4eIjMe2eceQg",
                "rating": 5,
                "user": {
                  "id": "azjuxjks4tfg_HCt1D5zqQ",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/dD5Mtong507Zkt91BLKLNQ/o.jpg",
                  "name": "Lexie P.",
                },
              }
            ],
            "categories": [
              {"title": "Barbeque", "alias": "bbq"},
              {"title": "Japanese", "alias": "japanese"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3550 S Decatur Blvd\nLas Vegas, NV 89103",
            },
          },
          {
            "id": "QXV3L_QFGj8r6nWX2kS2hA",
            "name": "Nacho Daddy",
            "price": "\$\$",
            "rating": 4.4,
            "photos": [
              "https://s3-media4.fl.yelpcdn.com/bphoto/pu9doqMplB5x5SEs8ikW6w/o.jpg",
            ],
            "reviews": [
              {
                "id": "IENYgJX7YT2vEoqmzDuxFg",
                "rating": 5,
                "user": {
                  "id": "93GXIadcaCIy_9m4EN2Ihw",
                  "image_url": null,
                  "name": "Brian H.",
                },
              },
              {
                "id": "lXHzKzJfUaMHh3d6L4CcVw",
                "rating": 3,
                "user": {
                  "id": "owWvMQ5g6ZokQKyrKHptug",
                  "image_url": null,
                  "name": "Big B.",
                },
              },
              {
                "id": "uVvPpNXu3se-hAUboWSuEw",
                "rating": 5,
                "user": {
                  "id": "uJlmP8JUrP7i2kfrv7xzuQ",
                  "image_url": null,
                  "name": "Mickee M.",
                },
              }
            ],
            "categories": [
              {"title": "New American", "alias": "newamerican"},
              {"title": "Mexican", "alias": "mexican"},
              {"title": "Breakfast & Brunch", "alias": "breakfast_brunch"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address":
                  "3663 Las Vegas Blvd\nSte 595\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "JPfi__QJAaRzmfh5aOyFEw",
            "name": "Shang Artisan Noodle",
            "price": "\$\$",
            "rating": 4.6,
            "photos": [
              "https://s3-media3.fl.yelpcdn.com/bphoto/TqV2TDWH-7Wje5B9Oh1EZw/o.jpg",
            ],
            "reviews": [
              {
                "id": "_lXnOVcnw1WfFwWaG4VMDA",
                "rating": 5,
                "user": {
                  "id": "DSE7W4BRJ7FiHL6vqItRag",
                  "image_url": null,
                  "name": "Annie A.",
                },
              },
              {
                "id": "CsuamYmDAWthyn6AxCvXZQ",
                "rating": 5,
                "user": {
                  "id": "BHIGJAgBTRD4H01yP0n9Qg",
                  "image_url": null,
                  "name": "Genesis S.",
                },
              },
              {
                "id": "MlbzJT2UhcebcoXtq0kczA",
                "rating": 5,
                "user": {
                  "id": "HVwq3FtsOuxQV9DvoPa4RA",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/qptBQ1iGo9kY9wDGF8bFHA/o.jpg",
                  "name": "Jasmine B.",
                },
              }
            ],
            "categories": [
              {"title": "Noodles", "alias": "noodles"},
              {"title": "Chinese", "alias": "chinese"},
              {"title": "Soup", "alias": "soup"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address":
                  "4983 W Flamingo Rd\nSte B\nLas Vegas, NV 89103",
            },
          },
          {
            "id": "2iTsRqUsPGRH1li1WVRvKQ",
            "name": "Carson Kitchen",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/LhaPvLHIrsHu8ZMLgV04OQ/o.jpg",
            ],
            "reviews": [
              {
                "id": "59ewmBp3j19Ud3T7Lz4-Ow",
                "rating": 4,
                "user": {
                  "id": "7DQSAc84ydnYEP2UMWG0oQ",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/xV_gdMBDART7WwHp8KPlkA/o.jpg",
                  "name": "Shannon P.",
                },
              },
              {
                "id": "sWLL78Q4yDf3WA7tMtOl2g",
                "rating": 5,
                "user": {
                  "id": "KLyfgt5E1YwBlfNTZ6xeNQ",
                  "image_url": null,
                  "name": "Maria S.",
                },
              },
              {
                "id": "tcrSG4NQUQktQNTncUnA8A",
                "rating": 5,
                "user": {
                  "id": "8AFvV4hG3IsoG7kyDXRZLw",
                  "image_url": null,
                  "name": "Lonfre A.",
                },
              }
            ],
            "categories": [
              {"title": "New American", "alias": "newamerican"},
              {"title": "Desserts", "alias": "desserts"},
              {"title": "Cocktail Bars", "alias": "cocktailbars"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "124 S 6th St\nSte 100\nLas Vegas, NV 89101",
            },
          },
          {
            "id": "4JNXUYY8wbaaDmk3BPzlWw",
            "name": "Mon Ami Gabi",
            "price": "\$\$\$",
            "rating": 4.2,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/cZ75DtuiHsOU-4W3vLsFKA/o.jpg",
            ],
            "reviews": [
              {
                "id": "bPYqNEvJaQxkAeZDmXRCug",
                "rating": 5,
                "user": {
                  "id": "4G8bg7wdu_WHezo1c1EYgA",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/jzQtjP49LXCkTH9ANt04KQ/o.jpg",
                  "name": "Rabindra A.",
                },
              },
              {
                "id": "rsFWnc3wXsDeFXa2ATFZiQ",
                "rating": 5,
                "user": {
                  "id": "L6TIKUDGuzGRkfvP56-tKA",
                  "image_url": null,
                  "name": "Deneen M.",
                },
              },
              {
                "id": "LJvvicQQOTAV9ReQOmb_9w",
                "rating": 5,
                "user": {
                  "id": "-Y5hKeoHvEmkiTLl2x02Lg",
                  "image_url": null,
                  "name": "Beth O.",
                },
              }
            ],
            "categories": [
              {"title": "French", "alias": "french"},
              {"title": "Steakhouses", "alias": "steak"},
              {"title": "Breakfast & Brunch", "alias": "breakfast_brunch"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3655 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "_Ad2ZKhUl-krJFpaZ1FI8g",
            "name": "Nabe Hotpot",
            "price": "\$\$",
            "rating": 4.3,
            "photos": [
              "https://s3-media3.fl.yelpcdn.com/bphoto/tkRdqFIfLe1lTwa6XmUPTA/o.jpg",
            ],
            "reviews": [
              {
                "id": "a2wdiJfGuG_f-t_1t6ctZA",
                "rating": 5,
                "user": {
                  "id": "fbExfW_FZhCT9gD98pssDA",
                  "image_url": null,
                  "name": "David P.",
                },
              },
              {
                "id": "dmm9ZwRvYNVP4a29ZtYDpw",
                "rating": 5,
                "user": {
                  "id": "ADO07jdGWzdYBGh5W3e8Vg",
                  "image_url": null,
                  "name": "Sara L.",
                },
              },
              {
                "id": "nAXaUvEJ61PnC8jfwnlc4g",
                "rating": 5,
                "user": {
                  "id": "uDY52BHWE5pHtQXj-nJgiA",
                  "image_url": null,
                  "name": "Malik H.",
                },
              }
            ],
            "categories": [
              {"title": "Hot Pot", "alias": "hotpot"},
              {"title": "Buffets", "alias": "buffets"},
              {"title": "Asian Fusion", "alias": "asianfusion"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address":
                  "4545 Spring Mountain Rd\nSte106\nLas Vegas, NV 89103",
            },
          },
          {
            "id": "RESDUcs7fIiihp38-d6_6g",
            "name": "Bacchanal Buffet",
            "price": "\$\$\$\$",
            "rating": 3.8,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/oqUpQ_W-8ZrbZKpDh7lYEw/o.jpg",
            ],
            "reviews": [
              {
                "id": "1zNFMBCOAWp-SvJqBHozoQ",
                "rating": 5,
                "user": {
                  "id": "05LJ1pHCBC9YLADh266WJw",
                  "image_url": null,
                  "name": "HeatherBelle R.",
                },
              },
              {
                "id": "rSayx0GhaFXmnKajV1q3uw",
                "rating": 5,
                "user": {
                  "id": "CRtTLHEWqEEpATRVIepdJA",
                  "image_url": null,
                  "name": "Franco C.",
                },
              },
              {
                "id": "0zzdPNrVUDImxCKvlP7kHQ",
                "rating": 5,
                "user": {
                  "id": "X55cCZntLJ93t5AqLV8Vmg",
                  "image_url": null,
                  "name": "Phuc N.",
                },
              }
            ],
            "categories": [
              {"title": "Buffets", "alias": "buffets"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3570 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "nUpz0YiBsOK7ff9k3vUJ3A",
            "name": "Buddy V's Ristorante",
            "price": "\$\$",
            "rating": 4.2,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/gLHjQg0bjGjr_Jus-BXqDA/o.jpg",
            ],
            "reviews": [
              {
                "id": "j3qyXxcVl1N5o01AuCbJkw",
                "rating": 5,
                "user": {
                  "id": "VBIGHWAj0lhxHtqEjNgXOw",
                  "image_url": null,
                  "name": "Gary G.",
                },
              },
              {
                "id": "uJQDyf-jKiqpogp_uvjCKA",
                "rating": 5,
                "user": {
                  "id": "oiUh0PdhxGLkfY8MzXhAxA",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/vmtQuYfajWVuhah2CKSEgg/o.jpg",
                  "name": "Jesus G.",
                },
              },
              {
                "id": "NCALI3IKAXUcQNin3B5L2A",
                "rating": 5,
                "user": {
                  "id": "adn2YBDMM00Vb048MANwLA",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/I7TTZwvcNzg5FEtb5YdWDA/o.jpg",
                  "name": "Lisa W.",
                },
              }
            ],
            "categories": [
              {"title": "Italian", "alias": "italian"},
              {"title": "American", "alias": "tradamerican"},
              {"title": "Wine Bars", "alias": "wine_bars"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3327 S Las Vegas Blvd\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "-1m9o3vGRA8IBPNvNqKLmA",
            "name": "Bavette's Steakhouse & Bar",
            "price": "\$\$\$\$",
            "rating": 4.5,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/pgcnYRHtbw_x_-OG8K4xVg/o.jpg",
            ],
            "reviews": [
              {
                "id": "9m_y_tj-4gWWnafyRR9rLQ",
                "rating": 5,
                "user": {
                  "id": "7ufSjDii5NNopQs-sL-p-A",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/KyASAGNbNw2CQTQ7exzjUA/o.jpg",
                  "name": "M G.",
                },
              },
              {
                "id": "F8tEzjNcVF778CANn9tkLA",
                "rating": 5,
                "user": {
                  "id": "zK4R5IFl5aBqePPEd0fvxw",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/rBt0S0z6NESBswiuaELa8w/o.jpg",
                  "name": "McKenzie S.",
                },
              },
              {
                "id": "I7Ip9foJiDllocxBRGeiSQ",
                "rating": 5,
                "user": {
                  "id": "YoaQY0EZmhYCgTLtz5sd2w",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/jgHQJrMrP7kzfbK26guJmg/o.jpg",
                  "name": "Kim l.",
                },
              }
            ],
            "categories": [
              {"title": "Steakhouses", "alias": "steak"},
              {"title": "Bars", "alias": "bars"},
              {"title": "New American", "alias": "newamerican"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3770 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "So132GP_uy3XbGs0KNyzyw",
            "name": "Casa Di Amore",
            "price": "\$\$",
            "rating": 4.4,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/mXsGaOMCpkA4NxubnVnFug/o.jpg",
            ],
            "reviews": [
              {
                "id": "vuUQh9HoY-N_XE_HG1VfvA",
                "rating": 5,
                "user": {
                  "id": "ARpUXNeHSgVDxLD2CH11CQ",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/CSClo4VwRHhc9bJZf6KqNw/o.jpg",
                  "name": "Ron B.",
                },
              },
              {
                "id": "THnNwzh7R44ce-kV1j6EdA",
                "rating": 5,
                "user": {
                  "id": "e4EXGZXtZaMLxQDKhcRstA",
                  "image_url": null,
                  "name": "Kim M.",
                },
              },
              {
                "id": "BTsih-QgLiwXVSvasiq55Q",
                "rating": 5,
                "user": {
                  "id": "s9DjinDkTYZVQs2yT8fGWQ",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/DmAuIqaH2i-7wvYhSbJx-g/o.jpg",
                  "name": "Erika R.",
                },
              }
            ],
            "categories": [
              {"title": "Italian", "alias": "italian"},
              {"title": "Seafood", "alias": "seafood"},
              {"title": "Pizza", "alias": "pizza"},
            ],
            "hours": [
              {"is_open_now": true},
            ],
            "location": {
              "formatted_address": "2850 E Tropicana Ave\nLas Vegas, NV 89121",
            },
          },
          {
            "id": "gOOfBSBZlffCkQ7dr7cpdw",
            "name": "CHICA",
            "price": "\$\$",
            "rating": 4.3,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/FxmtjuzPDiL7vx5KyceWuQ/o.jpg",
            ],
            "reviews": [
              {
                "id": "_gTYepaG5CRv01KMmJvaJw",
                "rating": 5,
                "user": {
                  "id": "1GORYVhCBapERJatkWJTEA",
                  "image_url": null,
                  "name": "Laurie F.",
                },
              },
              {
                "id": "OWVVXapkfKqa7jtYje0pDA",
                "rating": 4,
                "user": {
                  "id": "UB0y4EctcHwlLfziJPLRXw",
                  "image_url": null,
                  "name": "Veronica M.",
                },
              },
              {
                "id": "iNudQtW0ahSO9UM_v4vCPQ",
                "rating": 5,
                "user": {
                  "id": "t4DZCbS9gN5LJHh6QZmIzw",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/8ZRSNuL4MEMLDHKywYzZ9w/o.jpg",
                  "name": "Luke L.",
                },
              }
            ],
            "categories": [
              {"title": "Latin American", "alias": "latin"},
              {"title": "Breakfast & Brunch", "alias": "breakfast_brunch"},
              {"title": "Cocktail Bars", "alias": "cocktailbars"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address":
                  "3355 South Las Vegas Blvd\nSte 106\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "I6EDDi4-Eq_XlFghcDCUhw",
            "name": "Joe's Seafood Prime Steak & Stone Crab",
            "price": "\$\$\$",
            "rating": 4.4,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/I1GDdV1mWUJM5HTP1PIX6A/o.jpg",
            ],
            "reviews": [
              {
                "id": "gV8Thc_VUjiMbuFYAw7SoA",
                "rating": 5,
                "user": {
                  "id": "pCJ7-4JVgkguMZfsxD9F_A",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/Y-Cxe_3OpLWg_vygpTg5jQ/o.jpg",
                  "name": "C H.",
                },
              },
              {
                "id": "OxJTokYMp-GhWbBdaeHjnA",
                "rating": 3,
                "user": {
                  "id": "spNaK0MRO5wxyjfS7Gy8EA",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/Gyiy0J7AVo1ITr5DHI9rMQ/o.jpg",
                  "name": "Art H.",
                },
              },
              {
                "id": "pzndfUZHiKN9udZXpZP3GA",
                "rating": 4,
                "user": {
                  "id": "rjV-cGARjLT5NCXE4QoITQ",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/csz_4XilwyqvCgY7-VzSpA/o.jpg",
                  "name": "Eric C.",
                },
              }
            ],
            "categories": [
              {"title": "Seafood", "alias": "seafood"},
              {"title": "Steakhouses", "alias": "steak"},
              {"title": "Wine Bars", "alias": "wine_bars"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3500 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          },
          {
            "id": "awI4hHMfa7H0Xf0-ChU5hg",
            "name": "The Palace Station Oyster Bar",
            "price": "\$\$",
            "rating": 4.4,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/7Rx_j6r85ufd8nOFc7u_fA/o.jpg",
            ],
            "reviews": [
              {
                "id": "LizBX-ZuhRQjQSqv_wyWRQ",
                "rating": 5,
                "user": {
                  "id": "9XYZmVi9zGPgO-ElhS57Tw",
                  "image_url": null,
                  "name": "Sze Ting T.",
                },
              },
              {
                "id": "rrp_s8W7SX1JJ8pjghD43w",
                "rating": 5,
                "user": {
                  "id": "sNqhgZ7C11lLWmQPcPxNlg",
                  "image_url": null,
                  "name": "Irene P.",
                },
              },
              {
                "id": "IXrMFREpImMMySNsw1nU1g",
                "rating": 5,
                "user": {
                  "id": "bjc6Gux-JdFyfUnOOa5UdA",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/x1DzkG9yVycc71HGswUFqA/o.jpg",
                  "name": "David L.",
                },
              }
            ],
            "categories": [
              {"title": "Seafood", "alias": "seafood"},
              {"title": "Bars", "alias": "bars"},
              {"title": "Cajun/Creole", "alias": "cajun"},
            ],
            "hours": [
              {"is_open_now": true},
            ],
            "location": {
              "formatted_address": "2411 W Sahara Ave\nLas Vegas, NV 89102",
            },
          },
          {
            "id": "UidEFF1WpnU4duev4fjPlQ",
            "name": "Therapy ",
            "price": "\$\$",
            "rating": 4.3,
            "photos": [
              "https://s3-media3.fl.yelpcdn.com/bphoto/otaMuPtauoEb6qZzmHlAlQ/o.jpg",
            ],
            "reviews": [
              {
                "id": "b0Vc0DyssvQ6eR9zVI2bnQ",
                "rating": 5,
                "user": {
                  "id": "rky5o20jykKRbssb4aoo7g",
                  "image_url": null,
                  "name": "doyle W.",
                },
              },
              {
                "id": "rFkhUcAd_toiQF5etzOUFw",
                "rating": 5,
                "user": {
                  "id": "TgVjm7u8yWeP7E8E8HLi9w",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/mpciVuTs9rLYXIS2T9Jszg/o.jpg",
                  "name": "Jose P.",
                },
              },
              {
                "id": "VwdNtA6ZVYH2CQ2S8_8V7A",
                "rating": 3,
                "user": {
                  "id": "j-g4mLPahUwSNzWzKIIQuA",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/-qUjr9ZJN6lDaGEHjcXLlA/o.jpg",
                  "name": "Kelly M.",
                },
              }
            ],
            "categories": [
              {"title": "Bars", "alias": "bars"},
              {"title": "New American", "alias": "newamerican"},
              {"title": "Dance Clubs", "alias": "danceclubs"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "518 Fremont St\nLas Vegas, NV 89101",
            },
          },
          {
            "id": "igHYkXZMLAc9UdV5VnR_AA",
            "name": "Echo & Rig",
            "price": "\$\$\$",
            "rating": 4.4,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/Q9swks1BO-w-hVskIHrCVg/o.jpg",
            ],
            "reviews": [
              {
                "id": "KxB6EqbsUAYcXCbogF0j9A",
                "rating": 5,
                "user": {
                  "id": "W3opz1HpIXl2krFLJ53lqg",
                  "image_url": null,
                  "name": "Ming Z.",
                },
              },
              {
                "id": "2Uw_tdACju6YVEwPQWTSfQ",
                "rating": 5,
                "user": {
                  "id": "98BB-9KO_RySfLuafz9TKw",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/eXfHdNfzuf4JMoR-OBNGuQ/o.jpg",
                  "name": "Geri G.",
                },
              },
              {
                "id": "AihtALBJbOdfy9kFtlok4w",
                "rating": 3,
                "user": {
                  "id": "iypYdh5IdpKtszZKa_g-5g",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/YdOttAg-POwKD5NrwJwslw/o.jpg",
                  "name": "J A.",
                },
              }
            ],
            "categories": [
              {"title": "Steakhouses", "alias": "steak"},
              {"title": "Butcher", "alias": "butcher"},
              {"title": "Tapas/Small Plates", "alias": "tapasmallplates"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "440 S Rampart Blvd\nLas Vegas, NV 89145",
            },
          },
          {
            "id": "3kdSl5mo9dWC4clrQjEDGg",
            "name": "Egg & I",
            "price": "\$\$",
            "rating": 4.5,
            "photos": [
              "https://s3-media1.fl.yelpcdn.com/bphoto/z4rdxoc6xaM4dmdPovPBDg/o.jpg",
            ],
            "reviews": [
              {
                "id": "zBfn3qSG0KRXJ_GxWwruJQ",
                "rating": 5,
                "user": {
                  "id": "grMSssQCLcCF66dZ6VStLw",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/_JdmV2FryLV7vhC-mHPIDA/o.jpg",
                  "name": "Phillipa T.",
                },
              },
              {
                "id": "PHbD7xfoZ2XwvsaF7jo3AA",
                "rating": 5,
                "user": {
                  "id": "c5xvVccRYTmcUg3n4fx0fA",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/yz0C3ZpTgSUffAqbHcolOw/o.jpg",
                  "name": "Jessica B.",
                },
              },
              {
                "id": "Qr2Hpb1-EgZs1dw3z-DkwQ",
                "rating": 4,
                "user": {
                  "id": "lxdiwASOCnvRFsogbEYh3A",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/apVDNrYTeeAX_0FTJj-NgQ/o.jpg",
                  "name": "Annie W.",
                },
              }
            ],
            "categories": [
              {"title": "Breakfast & Brunch", "alias": "breakfast_brunch"},
              {"title": "Burgers", "alias": "burgers"},
              {"title": "American", "alias": "tradamerican"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address":
                  "4533 W Sahara Ave\nSte 5\nLas Vegas, NV 89102",
            },
          },
          {
            "id": "GmdujALb1Nq2RHGr7jhCaA",
            "name": "Hwaro",
            "price": "\$\$\$",
            "rating": 4.3,
            "photos": [
              "https://s3-media2.fl.yelpcdn.com/bphoto/zLPvdNPhH7QYYv8qm2_jAQ/o.jpg",
            ],
            "reviews": [
              {
                "id": "Fq7cQ7-qS0vREMbVb1YTfg",
                "rating": 5,
                "user": {
                  "id": "1_H2nkv9zXg1OkZPa8HAsw",
                  "image_url": null,
                  "name": "Tomas E.",
                },
              },
              {
                "id": "ykqo7qqVHJtnFplGv5LvMA",
                "rating": 5,
                "user": {
                  "id": "9IFnva_ZbFNv4pwT60UzNw",
                  "image_url":
                      "https://s3-media1.fl.yelpcdn.com/photo/QOigG0571nJSPIKhqa-73A/o.jpg",
                  "name": "Sarah B.",
                },
              },
              {
                "id": "pGJS9csh9p3dNLj-Yzpv2A",
                "rating": 5,
                "user": {
                  "id": "ZS1dS_t9ZQVk-fvJyI7lLA",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/B3EsThXmbPbt3YwVplREjA/o.jpg",
                  "name": "Evis K.",
                },
              }
            ],
            "categories": [
              {"title": "Korean", "alias": "korean"},
              {"title": "Barbeque", "alias": "bbq"},
              {"title": "Seafood", "alias": "seafood"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address":
                  "5030 Spring Mountain Rd\nSte 3-5\nLas Vegas, NV 89146",
            },
          },
          {
            "id": "XnJeadLrlj9AZB8qSdIR2Q",
            "name": "Joel Robuchon",
            "price": "\$\$\$\$",
            "rating": 4.5,
            "photos": [
              "https://s3-media4.fl.yelpcdn.com/bphoto/8282ZD9hrsGH9a-kejFzxw/o.jpg",
            ],
            "reviews": [
              {
                "id": "8vQVgCgiKQ0HjAG_kXeetA",
                "rating": 5,
                "user": {
                  "id": "OIa6ptM1qUts5arovQUAFQ",
                  "image_url":
                      "https://s3-media4.fl.yelpcdn.com/photo/cCb8-5fnQAznL-wz8Cwlew/o.jpg",
                  "name": "Eric B.",
                },
              },
              {
                "id": "EVewlHXfiDa6EW4xf44jog",
                "rating": 4,
                "user": {
                  "id": "oEqB6qGiV2K3q8g2A8rfYA",
                  "image_url":
                      "https://s3-media3.fl.yelpcdn.com/photo/50wbYURpTknygA41Gm7bJA/o.jpg",
                  "name": "Gracie J.",
                },
              },
              {
                "id": "GcEYfDEw6KI7Yx6UR8rdMA",
                "rating": 5,
                "user": {
                  "id": "Y4iXISephx40OlZGaRjxUw",
                  "image_url":
                      "https://s3-media2.fl.yelpcdn.com/photo/tMExN7NAouyc9NgujptfqQ/o.jpg",
                  "name": "Tom B.",
                },
              }
            ],
            "categories": [
              {"title": "French", "alias": "french"},
            ],
            "hours": [
              {"is_open_now": false},
            ],
            "location": {
              "formatted_address": "3799 Las Vegas Blvd S\nLas Vegas, NV 89109",
            },
          }
        ],
      },
    );
  }
}

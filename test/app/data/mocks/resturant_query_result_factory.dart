import 'dart:convert';

import 'package:restaurantour/app/interactor/models/restaurant.dart';

class ModelFactory {
  static RestaurantQueryResult makeRestaurantQueryResult() {
    return RestaurantQueryResult.fromJson(jsonDecode(jsonRestaurantQueryResult)['data']['search']);
  }
  static RestaurantQueryResult makeRestaurantQueryResultNull() {
    return RestaurantQueryResult.fromJson(jsonDecode(jsonRestaurantQueryResultNull)['data']['search']);
  }

  static Restaurant makeRestaurant() {
    const review1 = Review(
      id: 'DKtLdByPmlwZET_b4BM3gQ',
      rating: 5,
      user: User(
        id: 'dW0QJVcKiX7crMd1lYWTkg',
        imageUrl: 'https://s3-media3.fl.yelpcdn.com/photo/yhQgs5pEXcKaSRxVaY9z6w/o.jpg',
        name: 'Misty C.',
      ),
    );
    const review2 = Review(
      id: 'PdS4Fv6RKyBQ1nB0L0wpsg',
      rating: 5,
      user: User(
        id: 'TVnNlNYw5uFp-D-lv9REXA',
        imageUrl: null,
        name: 'Chubby T.',
      ),
    );
    const review3 = Review(
      id: '9rADlcW-gfmu-F_bHK6WOw',
      rating: 3,
      user: User(
        id: 'YKh3b-qojo4vjtHEZoIjKA',
        imageUrl: null,
        name: 'Jeheon L.',
      ),
    );
    const restaurant = Restaurant(
      hours: [Hours(isOpenNow: true)],
      id: 'vHz2RLtfUMVRPFmd7VBEHA',
      name: "Gordon Ramsay Hell's Kitchen",
      categories: [
        Category(title: 'New American', alias: 'newamerican'),
        Category(title: 'Seafood', alias: 'seafood'),
      ],
      price: r"$$$",
      rating: 4.4,
      photos: ["https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg"],
      reviews: [review1, review2, review3],
      location: Location(formattedAddress: "3570 Las Vegas Blvd S\nLas Vegas, NV 89109"),
    );
    return restaurant;
  }
}

const jsonRestaurantQueryResult = r'''
{
  "data": {
    "search": {
      "total": 6185,
      "business": [
        {
          "id": "vHz2RLtfUMVRPFmd7VBEHA",
          "name": "Gordon Ramsay Hell's Kitchen",
          "price": "$$$",
          "rating": 4.4,
          "photos": [
            "https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg"
          ],
          "reviews": [
            {
              "id": "DKtLdByPmlwZET_b4BM3gQ",
              "rating": 5,
              "user": {
                "id": "dW0QJVcKiX7crMd1lYWTkg",
                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/yhQgs5pEXcKaSRxVaY9z6w/o.jpg",
                "name": "Misty C."
              }
            },
            {
              "id": "PdS4Fv6RKyBQ1nB0L0wpsg",
              "rating": 5,
              "user": {
                "id": "TVnNlNYw5uFp-D-lv9REXA",
                "image_url": null,
                "name": "Chubby T."
              }
            },
            {
              "id": "9rADlcW-gfmu-F_bHK6WOw",
              "rating": 3,
              "user": {
                "id": "YKh3b-qojo4vjtHEZoIjKA",
                "image_url": null,
                "name": "Jeheon L."
              }
            }
          ],
          "categories": [
            {
              "title": "New American",
              "alias": "newamerican"
            },
            {
              "title": "Seafood",
              "alias": "seafood"
            }
          ],
          "hours": [
            {
              "is_open_now": true
            }
          ],
          "location": {
            "formatted_address": "3570 Las Vegas Blvd S\nLas Vegas, NV 89109"
          }
        },
        {
          "id": "faPVqws-x-5k2CQKDNtHxw",
          "name": "Yardbird",
          "price": "$$",
          "rating": 4.5,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/xYJaanpF3Dl1OovhmpqAYw/o.jpg"
          ],
          "reviews": [
            {
              "id": "jF_ltrsWELOE3J62CfjVOA",
              "rating": 5,
              "user": {
                "id": "L6R9AgLVcYZRex-zD2dyGQ",
                "image_url": null,
                "name": "Rodil A."
              }
            },
            {
              "id": "IN-fzeDTSemdZjOlBSW-Xw",
              "rating": 5,
              "user": {
                "id": "goYizeAZdZbQhZZE5QOe8w",
                "image_url": null,
                "name": "Cliff G."
              }
            },
            {
              "id": "x9RWVj4xZdV_oep2i6c1sA",
              "rating": 5,
              "user": {
                "id": "PY9912npDSkcfO3He7bosQ",
                "image_url": null,
                "name": "Hiyori G."
              }
            }
          ],
          "categories": [
            {
              "title": "Southern",
              "alias": "southern"
            },
            {
              "title": "New American",
              "alias": "newamerican"
            },
            {
              "title": "Cocktail Bars",
              "alias": "cocktailbars"
            }
          ],
          "hours": [
            {
              "is_open_now": true
            }
          ],
          "location": {
            "formatted_address": "3355 Las Vegas Blvd S\nLas Vegas, NV 89109"
          }
        },
        {
          "id": "QXV3L_QFGj8r6nWX2kS2hA",
          "name": "Nacho Daddy",
          "price": "$$",
          "rating": 4.4,
          "photos": [
            "https://s3-media4.fl.yelpcdn.com/bphoto/pu9doqMplB5x5SEs8ikW6w/o.jpg"
          ],
          "reviews": [
            {
              "id": "DQ2H8OgyBTbe6jN5LqGXdA",
              "rating": 5,
              "user": {
                "id": "oufmvIs63kYDNT4LFy-mzA",
                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/FgemZl9aSNbb6EPcAG-jbw/o.jpg",
                "name": "Nastacia M."
              }
            },
            {
              "id": "0u-2PXiNc_ugmyUwOx8B5w",
              "rating": 5,
              "user": {
                "id": "LcN1aD-HHqCNlWzqTPfl6g",
                "image_url": null,
                "name": "Nataly E."
              }
            },
            {
              "id": "81RGgDCGWK9DOF8xf9wTBA",
              "rating": 4,
              "user": {
                "id": "ade13lGTtnC25U57AKRW_A",
                "image_url": null,
                "name": "Michael m."
              }
            }
          ],
          "categories": [
            {
              "title": "New American",
              "alias": "newamerican"
            },
            {
              "title": "Mexican",
              "alias": "mexican"
            },
            {
              "title": "Breakfast & Brunch",
              "alias": "breakfast_brunch"
            }
          ],
          "hours": [
            {
              "is_open_now": true
            }
          ],
          "location": {
            "formatted_address": "3663 Las Vegas Blvd\nSte 595\nLas Vegas, NV 89109"
          }
        },
        {
          "id": "2iTsRqUsPGRH1li1WVRvKQ",
          "name": "Carson Kitchen",
          "price": "$$",
          "rating": 4.5,
          "photos": [
            "https://s3-media2.fl.yelpcdn.com/bphoto/LhaPvLHIrsHu8ZMLgV04OQ/o.jpg"
          ],
          "reviews": [
            {
              "id": "sZVa1-2TWjgJEnKGJYYB4Q",
              "rating": 5,
              "user": {
                "id": "Poe6Ka98uk2V3FTH25gmVQ",
                "image_url": null,
                "name": "Cynthia D."
              }
            },
            {
              "id": "5t4my7iYtsLNUO8x-SSUsw",
              "rating": 5,
              "user": {
                "id": "37DUcB2WAP5CF99T1bLsGw",
                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/24vNaKwJjGmhdl-B5tedhw/o.jpg",
                "name": "Justin G."
              }
            },
            {
              "id": "1PKEZpeVRgb05RihejOJIw",
              "rating": 3,
              "user": {
                "id": "z6EDB2Y_ArgnhYOaL68KhA",
                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/8N1nVMkzR8jachxvpswCKg/o.jpg",
                "name": "Chastina S."
              }
            }
          ],
          "categories": [
            {
              "title": "New American",
              "alias": "newamerican"
            },
            {
              "title": "Desserts",
              "alias": "desserts"
            },
            {
              "title": "Cocktail Bars",
              "alias": "cocktailbars"
            }
          ],
          "hours": [
            {
              "is_open_now": true
            }
          ],
          "location": {
            "formatted_address": "124 S 6th St\nSte 100\nLas Vegas, NV 89101"
          }
        },
        {
          "id": "syhA1ugJpyNLaB0MiP19VA",
          "name": "888 Japanese BBQ",
          "price": "$$$",
          "rating": 4.8,
          "photos": [
            "https://s3-media1.fl.yelpcdn.com/bphoto/V_zmwCUG1o_vR29xfkb-ng/o.jpg"
          ],
          "reviews": [
            {
              "id": "QKuvkV1Tb-d14-Hfo6KkGw",
              "rating": 4,
              "user": {
                "id": "R_DrrfxzKvQtVpgIv1KXjw",
                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/FHwSndIBTpNLIoU99Qsozg/o.jpg",
                "name": "Grace D."
              }
            },
            {
              "id": "LKSWKmpe4p6XwM2_GTK_tg",
              "rating": 5,
              "user": {
                "id": "xcF1SCYEtj9OK3TwYqV5Qg",
                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/esVhZkLVrWtuXBPgJ6sUjw/o.jpg",
                "name": "felicia J."
              }
            },
            {
              "id": "foPmGbRnFmALLevmXgGN6w",
              "rating": 5,
              "user": {
                "id": "o14GLSjW4a6L_5dofmfbTw",
                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/7lpT74I1nVghDStisoT9mQ/o.jpg",
                "name": "Yichu W."
              }
            }
          ],
          "categories": [
            {
              "title": "Barbeque",
              "alias": "bbq"
            },
            {
              "title": "Japanese",
              "alias": "japanese"
            }
          ],
          "hours": [
            {
              "is_open_now": true
            }
          ],
          "location": {
            "formatted_address": "3550 S Decatur Blvd\nLas Vegas, NV 89103"
          }
        },
        {
          "id": "gOOfBSBZlffCkQ7dr7cpdw",
          "name": "CHICA",
          "price": "$$",
          "rating": 4.3,
          "photos": [
            "https://s3-media2.fl.yelpcdn.com/bphoto/FxmtjuzPDiL7vx5KyceWuQ/o.jpg"
          ],
          "reviews": [
            {
              "id": "lW4yyq9CTIsMKM_YaD2t6Q",
              "rating": 5,
              "user": {
                "id": "qtV2u7-cR0ueiOcObwm8EQ",
                "image_url": null,
                "name": "Petra R."
              }
            },
            {
              "id": "NQeiKHUZ4u-TLNTO3zenBQ",
              "rating": 5,
              "user": {
                "id": "_gzc2WONOcCNF8k2wobRQw",
                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/1zjnSzZGFSp1FqscHxqyug/o.jpg",
                "name": "Raymond S."
              }
            },
            {
              "id": "MH5snphDmYvF_o9xnwYf_Q",
              "rating": 1,
              "user": {
                "id": "GLOgZ5VkXdVr_272gJhr2g",
                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/fgPFqwN3Wni_6X2d3Ags2A/o.jpg",
                "name": "Carlos G."
              }
            }
          ],
          "categories": [
            {
              "title": "Latin American",
              "alias": "latin"
            },
            {
              "title": "Breakfast & Brunch",
              "alias": "breakfast_brunch"
            },
            {
              "title": "Cocktail Bars",
              "alias": "cocktailbars"
            }
          ],
          "hours": [
            {
              "is_open_now": true
            }
          ],
          "location": {
            "formatted_address": "3355 South Las Vegas Blvd\nSte 106\nLas Vegas, NV 89109"
          }
        }
      ]
    }
  }
}''';
const jsonRestaurantQueryResultNull = r'''
{
  "data": {
    "search": {
      "total": 6185,
      "business": [
       
      ]
    }
  }
}''';

class MockData {
  static String yelpResponse = r'''
{
  "total": 6194,
  "business": [
    {
      "id": "vHz2RLtfUMVRPFmd7VBEHA",
      "name": "Gordon Ramsay Hell's Kitchen",
      "price": "$$$",
      "rating": 4.4,
      "photos": ["https://s3-media2.fl.yelpcdn.com/bphoto/q771KjLzI5y638leJsnJnQ/o.jpg"],
      "reviews": [
        {
          "id": "PdS4Fv6RKyBQ1nB0L0wpsg",
          "rating": 5,
          "user": {"id": "TVnNlNYw5uFp-D-lv9REXA", "image_url": null, "name": "Chubby T."}
        },
        {
          "id": "9rADlcW-gfmu-F_bHK6WOw",
          "rating": 3,
          "user": {"id": "YKh3b-qojo4vjtHEZoIjKA", "image_url": null, "name": "Jeheon L."}
        },
        {
          "id": "3kACPCeDQUesPD6Dj7pHHQ",
          "rating": 5,
          "user": {"id": "InFweVBJ5d6dL6wVwUpmjQ", "image_url": null, "name": "Marelyn R."}
        }
      ],
      "categories": [
        {"title": "New American", "alias": "newamerican"},
        {"title": "Seafood", "alias": "seafood"}
      ],
      "hours": [{"is_open_now": true}],
      "location": {"formatted_address": "3570 Las Vegas Blvd S Las Vegas, NV 89109"}
    },
    {
      "id": "faPVqws-x-5k2CQKDNtHxw",
      "name": "Yardbird",
      "price": "$$",
      "rating": 4.5,
      "photos": ["https://s3-media1.fl.yelpcdn.com/bphoto/xYJaanpF3Dl1OovhmpqAYw/o.jpg"],
      "reviews": [
        {
          "id": "jF_ltrsWELOE3J62CfjVOA",
          "rating": 5,
          "user": {"id": "L6R9AgLVcYZRex-zD2dyGQ", "image_url": null, "name": "Rodil A."}
        },
        {
          "id": "IN-fzeDTSemdZjOlBSW-Xw",
          "rating": 5,
          "user": {"id": "goYizeAZdZbQhZZE5QOe8w", "image_url": null, "name": "Cliff G."}
        },
        {
          "id": "x9RWVj4xZdV_oep2i6c1sA",
          "rating": 5,
          "user": {"id": "PY9912npDSkcfO3He7bosQ", "image_url": null, "name": "Hiyori G."}
        }
      ],
      "categories": [
        {"title": "Southern", "alias": "southern"},
        {"title": "New American", "alias": "newamerican"},
        {"title": "Cocktail Bars", "alias": "cocktailbars"}
      ],
      "hours": [{"is_open_now": true}],
      "location": {"formatted_address": "3355 Las Vegas Blvd S Las Vegas, NV 89109"}
    },
    {
      "id": "2iTsRqUsPGRH1li1WVRvKQ",
      "name": "Carson Kitchen",
      "price": "$$",
      "rating": 4.5,
      "photos": ["https://s3-media2.fl.yelpcdn.com/bphoto/LhaPvLHIrsHu8ZMLgV04OQ/o.jpg"],
      "reviews": [
        {
          "id": "sZVa1-2TWjgJEnKGJYYB4Q",
          "rating": 5,
          "user": {"id": "Poe6Ka98uk2V3FTH25gmVQ", "image_url": null, "name": "Cynthia D."}
        },
        {
          "id": "zgilgF7G_DvrzAh6rbqrZg",
          "rating": 5,
          "user": {"id": "JWA1wHHdgZa1O0_Atk5Xrg", "image_url": null, "name": "Vivian Y."}
        },
        {
          "id": "rGjBuZgMX-DYchGuKJHZ0A",
          "rating": 5,
          "user": {"id": "wD5hDv81oNYyMQd0XitowA", "image_url": null, "name": "Alan P."}
        }
      ],
      "categories": [
        {"title": "American (New)", "alias": "newamerican"},
        {"title": "Tapas/Small Plates", "alias": "tapasmallplates"},
        {"title": "Bars", "alias": "bars"}
      ],
      "hours": [{"is_open_now": true}],
      "location": {"formatted_address": "124 S 6th St Las Vegas, NV 89101"}
    },
    {
      "id": "UidEFF1WpnU4duev4fjPlQ",
      "name": "Therapy",
      "price": "$$",
      "rating": 4.3,
      "photos": ["https://s3-media3.fl.yelpcdn.com/bphoto/otaMuPtauoEb6qZzmHlAlQ/o.jpg"],
      "reviews": [
        {
          "id": "PsR_yQOXt_w8PUkTGlBjkA",
          "rating": 5,
          "user": {"id": "VmSDPCypfNRYJL6iMXqQZQ", "image_url": null, "name": "Zoe C."}
        },
        {
          "id": "t5KE0YZKeRGxX8TLl17SVw",
          "rating": 5,
          "user": {"id": "xhC7iVSHkf9pdXu2NVDAhA", "image_url": null, "name": "Grant W."}
        },
        {
          "id": "49zIJLuJkZRj460MfGAj6A",
          "rating": 5,
          "user": {"id": "Qb_YdQd6IdogNBzCnSu5bw", "image_url": "https://s3-media1.fl.yelpcdn.com/photo/SyE0UJtWlVo9I1BKZbzrfA/o.jpg", "name": "Jessamyn C."}
        }
      ],
      "categories": [
        {"title": "Bars", "alias": "bars"},
        {"title": "New American", "alias": "newamerican"},
        {"title": "Dance Clubs", "alias": "danceclubs"}
      ],
      "hours": [{"is_open_now": false}],
      "location": {"formatted_address": "518 Fremont St Las Vegas, NV 89101"}
    },
    {
      "id": "mU3vlAVzTxgmZUu6F4XixA",
      "name": "Momofuku",
      "price": "$$",
      "rating": 4.1,
      "photos": ["https://s3-media1.fl.yelpcdn.com/bphoto/mB1g53Nqa62Q04u4oNuCSw/o.jpg"],
      "reviews": [
        {
          "id": "35EBt6dRrX4Qug_xdZh0gQ",
          "rating": 4,
          "user": {"id": "k_2KtwnTyFwCp3jolV7VMQ", "image_url": null, "name": "jamesmarissa p."}
        },
        {
          "id": "DlbQl5FMwXKcaiA-M8PAFA",
          "rating": 5,
          "user": {"id": "KKijecFeQInjpAQuoLQbDg", "image_url": null, "name": "Stephanie A."}
        },
        {
          "id": "tn-MGVazgja5OsgVBnLmEQ",
          "rating": 5,
          "user": {"id": "R9TOJHFqYTExNMtEdbhvRQ", "image_url": "https://s3-media1.fl.yelpcdn.com/photo/m8e_G1oOUF11HjHc91gdoQ/o.jpg", "name": "Bob J."}
        }
      ],
      "categories": [
        {"title": "New American", "alias": "newamerican"},
        {"title": "Asian Fusion", "alias": "asianfusion"}
      ],
      "hours": [{"is_open_now": false}],
      "location": {"formatted_address": "2 Boulevard Tower Level Boulevard Tower Las Vegas, NV 89109"}
    }
  ]
}
''';
}

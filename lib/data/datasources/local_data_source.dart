import 'dart:convert';

import 'package:restaurantour/data/datasources/remote_data_source.dart';
import 'package:restaurantour/data/models/restaurant.dart';

// abstract class LocalDataSource {
//   Future<RestaurantQueryResult?> getRestaurants();
// }

class LocalDataSourceImpl implements RemoteDataSource {
  @override
  Future<RestaurantQueryResult?> getRestaurants() async {
    await Future.delayed(const Duration(seconds: 2));

    jsonDecode(data);

    return RestaurantQueryResult.fromJson(jsonDecode(data)['data']['search']);
  }
}

const data = '''
{
    "data": {
        "search": {
            "total": 6243,
            "business": [
                {
                    "id": "kRgAf6j2y1eR0wOFdzFAuw",
                    "name": "Firefly Tapas Kitchen & Bar",
                    "price": "\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/enFKR6NTTy2Ik3r_2ru2bA/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "obQIlLWQ3wGu0KIzXiDClw",
                            "rating": 5,
                            "user": {
                                "id": "eXe5i7EH6D8vIdJPfu96Gg",
                                "image_url": null,
                                "name": "Mec y."
                            }
                        },
                        {
                            "id": "pfIOndIQZ2cSvW1V56Q6pA",
                            "rating": 5,
                            "user": {
                                "id": "255FluXzSYuMm7ZnFJHRPA",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/6LH_G_PRWP-QFM9Ov9ZAzg/o.jpg",
                                "name": "Suzette V."
                            }
                        },
                        {
                            "id": "5g0Affa0VmPxvdiYdGBOLQ",
                            "rating": 4,
                            "user": {
                                "id": "IcVEgi0zzjqkAeXH_x0oEQ",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/YZCA7t60HUbWilAvzXm4Hw/o.jpg",
                                "name": "Victoria Lynn D."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Tapas/Small Plates",
                            "alias": "tapasmallplates"
                        },
                        {
                            "title": "Tapas Bars",
                            "alias": "tapas"
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
                        "formatted_address": "335 Hughes Center Dr\\nLas Vegas, NV 89169"
                    }
                },
                {
                    "id": "l2G_z28bT5f42DwmwevDkw",
                    "name": "Amalfi by Bobby Flay",
                    "price": "\$\$\$",
                    "rating": 4.3,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/46HY_-gxNZPOyfDTxHgD-w/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "w8iw84rqA-aVkzNLymklRw",
                            "rating": 5,
                            "user": {
                                "id": "e0lV0WyRCYbYs9k6chh8YA",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/HG-gRD-0VnQLHPtyajhGvw/o.jpg",
                                "name": "Richard S."
                            }
                        },
                        {
                            "id": "0M0ZgMMfuqL0wOiS7Q1Wjw",
                            "rating": 4,
                            "user": {
                                "id": "iM8EKosFcDZ1E1VWcoJSRg",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/xpK5Uuaile_VkCCKJKwW3A/o.jpg",
                                "name": "Dominic K."
                            }
                        },
                        {
                            "id": "ose9zWevaxMx1UFevYlHIg",
                            "rating": 5,
                            "user": {
                                "id": "wMrEl0WYz-4eJwHZSubn_A",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/BYJyygfbzd-fYtVoO5GODg/o.jpg",
                                "name": "KC C."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Italian",
                            "alias": "italian"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "3570 S Las Vegas Blvd\\nLas Vegas, NV 89109"
                    }
                },
                {
                    "id": "QCCVxVRt1amqv0AaEWSKkg",
                    "name": "Esther's Kitchen",
                    "price": "\$\$",
                    "rating": 4.5,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/wEM4F2jy0hnBdNfdAum0Sw/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "LFEIoh6YiBWw_eTI5FTUbA",
                            "rating": 5,
                            "user": {
                                "id": "NeHIARKfuBqFMSCTyuyWXQ",
                                "image_url": null,
                                "name": "Aaron Ekstrom .."
                            }
                        },
                        {
                            "id": "PSndBlIo4YSL2Q5FNeXvjQ",
                            "rating": 5,
                            "user": {
                                "id": "yhMCdCnGhgYb-nH1v_sKOQ",
                                "image_url": null,
                                "name": "Nicholas S."
                            }
                        },
                        {
                            "id": "NFIXxCjV70Npb8Mh4chcxQ",
                            "rating": 5,
                            "user": {
                                "id": "NrlXdAW1pbPhVCgo7x16dQ",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/1HSUM0bINylalGH2-jFwIQ/o.jpg",
                                "name": "Kayla T."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Italian",
                            "alias": "italian"
                        },
                        {
                            "title": "Pizza",
                            "alias": "pizza"
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
                        "formatted_address": "1131 S Main St\\nLas Vegas, NV 89104"
                    }
                },
                {
                    "id": "SVGApDPNdpFlEjwRQThCxA",
                    "name": "Juan's Flaming Fajitas & Cantina - Tropicana",
                    "price": "\$\$",
                    "rating": 4.6,
                    "photos": [
                        "https://s3-media3.fl.yelpcdn.com/bphoto/a8L9bQZ2XW8etXLomKKdDw/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "RFgK-s4ZvvMQxu8ms2PnzA",
                            "rating": 5,
                            "user": {
                                "id": "O7mPwqchyXy0Or7zRCNWKg",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/QxiSoPQeiiy_tx3vkRJYwg/o.jpg",
                                "name": "Erik E."
                            }
                        },
                        {
                            "id": "SuE2brKGpFAxvgyeCUI0IA",
                            "rating": 4,
                            "user": {
                                "id": "S5c_0MfM9u4wvq1S9APlRA",
                                "image_url": null,
                                "name": "Shoba M."
                            }
                        },
                        {
                            "id": "Ia-k3atoeHVh-ca1EtTkFA",
                            "rating": 5,
                            "user": {
                                "id": "zptY-iNuRHSvWNpHgE4pbw",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/uzShEFMuqP8_cHhgII9I5Q/o.jpg",
                                "name": "Ina H."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Mexican",
                            "alias": "mexican"
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
                        "formatted_address": "9640 W Tropicana\\nSte 101\\nLas Vegas, NV 89147"
                    }
                },
                {
                    "id": "hihud--QRriCYZw1zZvW4g",
                    "name": "Gangnam Asian BBQ Dining",
                    "price": "\$\$\$",
                    "rating": 4.6,
                    "photos": [
                        "https://s3-media2.fl.yelpcdn.com/bphoto/KJIWL0j15QtMrvdAISBMUw/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "LCmCdB8BN6zr8fCJ7So_vA",
                            "rating": 5,
                            "user": {
                                "id": "owjPRVFMf_isJVbD_PFYEg",
                                "image_url": null,
                                "name": "Nancy V."
                            }
                        },
                        {
                            "id": "d54zO2vNcA-0xn53sNS-SQ",
                            "rating": 5,
                            "user": {
                                "id": "jp2zxubfcE3CT390Hs1G1A",
                                "image_url": null,
                                "name": "April M."
                            }
                        },
                        {
                            "id": "a7efcY2vAwgYYundQHj7yA",
                            "rating": 5,
                            "user": {
                                "id": "enHEde5n8iZZL_5vbgmjGA",
                                "image_url": null,
                                "name": "Bianca R."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Japanese",
                            "alias": "japanese"
                        },
                        {
                            "title": "Korean",
                            "alias": "korean"
                        },
                        {
                            "title": "Barbeque",
                            "alias": "bbq"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "4480 Paradise Rd\\nSte 600\\nLas Vegas, NV 89169"
                    }
                },
                {
                    "id": "_Ad2ZKhUl-krJFpaZ1FI8g",
                    "name": "Nabe Hotpot",
                    "price": "\$\$",
                    "rating": 4.3,
                    "photos": [
                        "https://s3-media3.fl.yelpcdn.com/bphoto/tkRdqFIfLe1lTwa6XmUPTA/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "0wT3ZCZQ11bNQOV95RgVHQ",
                            "rating": 5,
                            "user": {
                                "id": "3D99jvQficOPttTsSJHe8g",
                                "image_url": null,
                                "name": "Karter T."
                            }
                        },
                        {
                            "id": "pq5ugK0sbm314QyzF_3E8g",
                            "rating": 5,
                            "user": {
                                "id": "zluLxvSPaZnAICWSWkodjg",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/I9yh419iP5joTyay8BzSQg/o.jpg",
                                "name": "Erian R."
                            }
                        },
                        {
                            "id": "cRENEOAoJ9ynXg3w78xAYw",
                            "rating": 4,
                            "user": {
                                "id": "T7ko9V7ceVMJlMFbsihpzw",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/HFGrRFsEVBdUbEAnhPLGXQ/o.jpg",
                                "name": "Susan H."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Hot Pot",
                            "alias": "hotpot"
                        },
                        {
                            "title": "Buffets",
                            "alias": "buffets"
                        },
                        {
                            "title": "Asian Fusion",
                            "alias": "asianfusion"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "4545 Spring Mountain Rd\\nSte106\\nLas Vegas, NV 89103"
                    }
                },
                {
                    "id": "FNe5PPA9pyj8FjcDefCBpg",
                    "name": "Weera Thai Restaurant - Sahara",
                    "price": "\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media2.fl.yelpcdn.com/bphoto/TOPFVZGJtaLJI_-Vyq078A/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "SH9vhUBMTxJiz5nWHybzXw",
                            "rating": 5,
                            "user": {
                                "id": "kgNTlfIcrrndCyL4TaWF1A",
                                "image_url": null,
                                "name": "Chatuporn L."
                            }
                        },
                        {
                            "id": "XKyIIRPjjCTnnrV1fxW7iQ",
                            "rating": 5,
                            "user": {
                                "id": "-j4WK5TlYxpbvlgFoO2VMA",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/VIy_P7QYx6SpOXwKr0Nx2g/o.jpg",
                                "name": "100 Y."
                            }
                        },
                        {
                            "id": "xjxc-CRnqcEnrVP7-JiieA",
                            "rating": 5,
                            "user": {
                                "id": "zfDcvo9F7d9fAA_hWcBC5Q",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/5Po9Ji7ZIsFWVvEMMjy80A/o.jpg",
                                "name": "Mela M."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Thai",
                            "alias": "thai"
                        },
                        {
                            "title": "Bars",
                            "alias": "bars"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "3839 W Sahara Ave\\nSte 7-9\\nLas Vegas, NV 89102"
                    }
                },
                {
                    "id": "RESDUcs7fIiihp38-d6_6g",
                    "name": "Bacchanal Buffet",
                    "price": "\$\$\$\$",
                    "rating": 3.8,
                    "photos": [
                        "https://s3-media2.fl.yelpcdn.com/bphoto/oqUpQ_W-8ZrbZKpDh7lYEw/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "pWMF4T4ISMnLL2uavTcFsA",
                            "rating": 5,
                            "user": {
                                "id": "V3Qh4p-i0q6RyO77qS7llA",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/3vFUAEkl29V7GbcnqgvO9w/o.jpg",
                                "name": "Livnat A."
                            }
                        },
                        {
                            "id": "0zzdPNrVUDImxCKvlP7kHQ",
                            "rating": 5,
                            "user": {
                                "id": "X55cCZntLJ93t5AqLV8Vmg",
                                "image_url": null,
                                "name": "Phuc N."
                            }
                        },
                        {
                            "id": "SFp74_nmffcW3zIvQpDw4w",
                            "rating": 5,
                            "user": {
                                "id": "QwaMGDUcwaIoWOE6QGriHw",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/6n6DIYSQ9KI-aXe9CBmheg/o.jpg",
                                "name": "Gilbert M."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Buffets",
                            "alias": "buffets"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "3570 Las Vegas Blvd S\\nLas Vegas, NV 89109"
                    }
                },
                {
                    "id": "eJKnymd0BywNPrJw1IuXVw",
                    "name": "Nacho Daddy Downtown",
                    "price": "\$\$",
                    "rating": 4.2,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/wceTIo3pRr_-xUTtIJBVdg/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "tjpHz85V1TnDzgntWvXOeg",
                            "rating": 5,
                            "user": {
                                "id": "9Qjwa91-0hOtkputU279ig",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/C4lrz8fNoTE8qornQQX_jA/o.jpg",
                                "name": "Richard W."
                            }
                        },
                        {
                            "id": "kaV7U85JFL2vHKMoJjNyAg",
                            "rating": 5,
                            "user": {
                                "id": "aDMLmc5ttBPRZmmO-qI9kQ",
                                "image_url": null,
                                "name": "Ian J."
                            }
                        },
                        {
                            "id": "87iSEJCmfBm8GWIxPW5J8g",
                            "rating": 5,
                            "user": {
                                "id": "MzSbrpAd59sGy6l8FG3JQg",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/jlZR8HYRoyhjbp7gE2Ybmg/o.jpg",
                                "name": "Domonique S."
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
                        "formatted_address": "121 N 4th St\\nLas Vegas, NV 89101"
                    }
                },
                {
                    "id": "So132GP_uy3XbGs0KNyzyw",
                    "name": "Casa Di Amore",
                    "price": "\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/mXsGaOMCpkA4NxubnVnFug/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "vuUQh9HoY-N_XE_HG1VfvA",
                            "rating": 5,
                            "user": {
                                "id": "ARpUXNeHSgVDxLD2CH11CQ",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/CSClo4VwRHhc9bJZf6KqNw/o.jpg",
                                "name": "Ron B."
                            }
                        },
                        {
                            "id": "coO6qciwkOCkyfdnqQ-QzA",
                            "rating": 5,
                            "user": {
                                "id": "bulwvKiLYFXSK-jxTUg3Og",
                                "image_url": null,
                                "name": "Lupita A."
                            }
                        },
                        {
                            "id": "ylTE-a7Ni5sFhPapX-WGRQ",
                            "rating": 5,
                            "user": {
                                "id": "waeQPpVrpMJ1hlkHoDJUNg",
                                "image_url": null,
                                "name": "Charlie E."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Italian",
                            "alias": "italian"
                        },
                        {
                            "title": "Seafood",
                            "alias": "seafood"
                        },
                        {
                            "title": "Pizza",
                            "alias": "pizza"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "2850 E Tropicana Ave\\nLas Vegas, NV 89121"
                    }
                },
                {
                    "id": "G6w_9uzW4o3Oyb3z8oOZyA",
                    "name": "888 Korean BBQ",
                    "price": "\$\$\$",
                    "rating": 4.7,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/kTss6EIkznVmoOzZpFY7lA/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "yjNLWQPYwIDrydp1LB3SBg",
                            "rating": 5,
                            "user": {
                                "id": "jjALdTt2sRR641MjO41i3A",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/Fpm9lE9R9q10HjXXR8HGMA/o.jpg",
                                "name": "Ariana N."
                            }
                        },
                        {
                            "id": "HRAxnMD8S0igvUuWAw3-eQ",
                            "rating": 5,
                            "user": {
                                "id": "VIuHrvmw8Dxwa9XkeKWXGQ",
                                "image_url": null,
                                "name": "Julia M."
                            }
                        },
                        {
                            "id": "fPMb6tCiyAws_VRIDbAZww",
                            "rating": 5,
                            "user": {
                                "id": "jCuMBp6Srj2RmzTGcXLi0Q",
                                "image_url": null,
                                "name": "Suahn C."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Korean",
                            "alias": "korean"
                        },
                        {
                            "title": "Barbeque",
                            "alias": "bbq"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "4215 Spring Mountain Rd\\nB107\\nLas Vegas, NV 89102"
                    }
                },
                {
                    "id": "4k3RlMAMd46DZ_JyZU0lMg",
                    "name": "Ramen Sora",
                    "price": "\$\$",
                    "rating": 4.3,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/Nq7gmgoGRTaQszuUKcwmVQ/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "iVsqp5XzhZu___j5V-Z4KQ",
                            "rating": 5,
                            "user": {
                                "id": "bi7W0KZWnzKVFBGc5kS8lw",
                                "image_url": null,
                                "name": "Katelan J."
                            }
                        },
                        {
                            "id": "L28v0Tcs3g1NBL7mNqiHow",
                            "rating": 5,
                            "user": {
                                "id": "15EfkL69gvmLmrvYGODDqw",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/ZrDXV5-VME-shk4GPOK0wA/o.jpg",
                                "name": "Leanne R."
                            }
                        },
                        {
                            "id": "LdI5pUR2QcYGisax__WfKg",
                            "rating": 4,
                            "user": {
                                "id": "EC3sZ3YckujUkZQOR67twA",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/iYNpL2cNSAVA39dzpaErrw/o.jpg",
                                "name": "Shaw K."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Ramen",
                            "alias": "ramen"
                        },
                        {
                            "title": "Noodles",
                            "alias": "noodles"
                        },
                        {
                            "title": "Soup",
                            "alias": "soup"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "4490 Spring Mountain Rd\\nLas Vegas, NV 89102"
                    }
                },
                {
                    "id": "fL-b760btOaGa85OJ9ut3w",
                    "name": "Rollin Smoke Barbeque",
                    "price": "\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media2.fl.yelpcdn.com/bphoto/j6pMPJziv3-_Jzl1bRaMSw/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "nvm5eFUHuT9P7MIdknnoYg",
                            "rating": 4,
                            "user": {
                                "id": "zk6RUP5LDZkYoJ55iimD9A",
                                "image_url": null,
                                "name": "Em H."
                            }
                        },
                        {
                            "id": "VvYgMXa_Ra-lNrda2bQ9Vw",
                            "rating": 5,
                            "user": {
                                "id": "UrQw8IyTOAAlokN-SMK3_Q",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/xFS26HqlECcRDzJudwYI2g/o.jpg",
                                "name": "Joyce T."
                            }
                        },
                        {
                            "id": "ZjbsSx7oJ5lqceFUy4gvkQ",
                            "rating": 3,
                            "user": {
                                "id": "p0TstOsc3Xsl_TJ3RpV01g",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/s575a-dvBtD7rs01M_lvGA/o.jpg",
                                "name": "Syreeta B."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Barbeque",
                            "alias": "bbq"
                        },
                        {
                            "title": "Southern",
                            "alias": "southern"
                        },
                        {
                            "title": "Sandwiches",
                            "alias": "sandwiches"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "3185 S Highland Dr\\nSte 2\\nLas Vegas, NV 89109"
                    }
                },
                {
                    "id": "wkKlpSx3OcoGJiv7p8VZzw",
                    "name": "Sparrow + Wolf",
                    "price": "\$\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/GG1_GB-Qv18ooUWvsghAdg/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "mPvCUwAc_R-yHD5nPj-7sg",
                            "rating": 5,
                            "user": {
                                "id": "PQOnh9wg1lZJwf8qyp6Oaw",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/vwPc51j7FnW8WNLOg9awcA/o.jpg",
                                "name": "Bridget L."
                            }
                        },
                        {
                            "id": "3t8FmyURJ0eBiSZxw6qKjg",
                            "rating": 5,
                            "user": {
                                "id": "fIZCLNWaE1VjxwWt4mfAYg",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/pojLRbBEcu11g_RKNokXww/o.jpg",
                                "name": "Sam L."
                            }
                        },
                        {
                            "id": "dKeeI8Eblc6S7wvovgp9pA",
                            "rating": 5,
                            "user": {
                                "id": "3yxW_9twke2IIJySDR4_4Q",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/biWR2JtIg3N8T3NY_nkH9A/o.jpg",
                                "name": "Andrew D."
                            }
                        }
                    ],
                    "categories": [
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
                        "formatted_address": "4480 Spring Mountain Rd\\nSte 100\\nLas Vegas, NV 89102"
                    }
                },
                {
                    "id": "O19VReN1I2TBrJsbXUAIJg",
                    "name": "Partage",
                    "price": "\$\$\$\$",
                    "rating": 4.6,
                    "photos": [
                        "https://s3-media4.fl.yelpcdn.com/bphoto/M_fD_LCse2gi6Ujbreozog/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "QAITRTU6e7jz_JEkljdJyA",
                            "rating": 5,
                            "user": {
                                "id": "Yw5LynmZmKjSb4cuzgHptw",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/lRR3XpR2naxJTg5osTt77g/o.jpg",
                                "name": "Sam S."
                            }
                        },
                        {
                            "id": "WvAeMvHVV0AcQJixFADL3g",
                            "rating": 5,
                            "user": {
                                "id": "qqf3Gc3j0nSu0OPSJIxn7A",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/IaAME_gkiR80DY9jAEa51A/o.jpg",
                                "name": "Dawn B."
                            }
                        },
                        {
                            "id": "ttQRhgpOXujO2VWQSoh53Q",
                            "rating": 5,
                            "user": {
                                "id": "7OOgbUJK3SkyIB-owxvZ_A",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/YQeK-HXhAdT4xdleuVCKQA/o.jpg",
                                "name": "Alice H."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "French",
                            "alias": "french"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "3839 Spring Mountain Rd\\nLas Vegas, NV 89102"
                    }
                },
                {
                    "id": "HouYjwnp3mafH0m-Y5kdgQ",
                    "name": "Shigotonin",
                    "price": null,
                    "rating": 4.8,
                    "photos": [
                        "https://s3-media2.fl.yelpcdn.com/bphoto/H2yCVspM9OWI6S4VVC665A/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "QO1NXh599wYhKkEd8Arysg",
                            "rating": 5,
                            "user": {
                                "id": "M-x-rtrpb4rmsjlFZnOVDg",
                                "image_url": null,
                                "name": "Anna I."
                            }
                        },
                        {
                            "id": "r4xY7Vn1dKn6yciJKJTxaQ",
                            "rating": 5,
                            "user": {
                                "id": "XikMeAaDOAM_dUc5eIQ4bQ",
                                "image_url": null,
                                "name": "Leslie M."
                            }
                        },
                        {
                            "id": "bpjMHa74EXu8N8WL3OUzkQ",
                            "rating": 5,
                            "user": {
                                "id": "9o-E-IhryCQJtwwBnRZsXQ",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/rsnLG_J3S-pIvxzmIBMNFw/o.jpg",
                                "name": "Rowena M."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Izakaya",
                            "alias": "izakaya"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "5845 Spring Mountain Rd\\nUnit A7\\nGolden Spring Plaza\\nLas Vegas, NV 89146"
                    }
                },
                {
                    "id": "7sb2FYLS2sejZKxRYF9mtg",
                    "name": "Sakana",
                    "price": "\$\$",
                    "rating": 4.5,
                    "photos": [
                        "https://s3-media3.fl.yelpcdn.com/bphoto/NmJ4Mgc8uKMCC6xCKivaiA/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "-IpuJisn0cKMmdHsP2dUDA",
                            "rating": 5,
                            "user": {
                                "id": "Cs-navRw-BnUHAD4EgKmdw",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/Q6r6Jdcnovkf9xt4cZZ83Q/o.jpg",
                                "name": "Marbelis A."
                            }
                        },
                        {
                            "id": "-YvUde2IxeAYZLC2QZrVng",
                            "rating": 5,
                            "user": {
                                "id": "T7AB2bT5gCbpZf1QV9VXYw",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/3UqjZ_mjQBvD51-DXN6I9g/o.jpg",
                                "name": "MJ C."
                            }
                        },
                        {
                            "id": "SiKlv4hPik4HL2duyYtkOA",
                            "rating": 5,
                            "user": {
                                "id": "sTARVCuNC3xrA7dmcTj7SA",
                                "image_url": null,
                                "name": "Carlos V."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Japanese",
                            "alias": "japanese"
                        },
                        {
                            "title": "Sushi Bars",
                            "alias": "sushi"
                        },
                        {
                            "title": "Bars",
                            "alias": "bars"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "3949 S Maryland Pkwy\\nLas Vegas, NV 89119"
                    }
                },
                {
                    "id": "awI4hHMfa7H0Xf0-ChU5hg",
                    "name": "The Palace Station Oyster Bar",
                    "price": "\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/7Rx_j6r85ufd8nOFc7u_fA/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "i6niYOziXhW2NJA1LroBmg",
                            "rating": 5,
                            "user": {
                                "id": "4hSqVWaqVoHSSemocLN8ig",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/YuGBE_q0VxMS1-omKLMYfA/o.jpg",
                                "name": "Stephanie R."
                            }
                        },
                        {
                            "id": "cff01cXyaIuBtTarRGO9Cw",
                            "rating": 4,
                            "user": {
                                "id": "D4cnxp6k4eemD98E-kphMw",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/oPVnYh0AYTTgU0yswQ3c-w/o.jpg",
                                "name": "San L."
                            }
                        },
                        {
                            "id": "HUgNoBa6JGcnrek39pc1SQ",
                            "rating": 4,
                            "user": {
                                "id": "BUQKlodE0a6H1SwH_-o2UA",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/Ae6xZxrB-ePk7CVlgX2Haw/o.jpg",
                                "name": "Soo L."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Seafood",
                            "alias": "seafood"
                        },
                        {
                            "title": "Bars",
                            "alias": "bars"
                        },
                        {
                            "title": "Cajun/Creole",
                            "alias": "cajun"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "2411 W Sahara Ave\\nLas Vegas, NV 89102"
                    }
                },
                {
                    "id": "ghVhlFpNhfBwWDFGSlt2JA",
                    "name": "Sushi Neko",
                    "price": "\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media1.fl.yelpcdn.com/bphoto/ZHexhkwMwEHukl-UpEHwPQ/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "lhFBn4tY3b3ClcbxEKMo3w",
                            "rating": 5,
                            "user": {
                                "id": "kaqZbr0W9bYQ1h9kKaA1xA",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/VjF4GEIkjDBvgXi3VKObgQ/o.jpg",
                                "name": "Sarah B."
                            }
                        },
                        {
                            "id": "dhE8WBSn25XqALh8_GEriA",
                            "rating": 5,
                            "user": {
                                "id": "rzmVtJo1mnaMv3dO_A9wuw",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/wE0ZqCUEc67y3xn88EN7HA/o.jpg",
                                "name": "Ann Marie C."
                            }
                        },
                        {
                            "id": "UOsyr1jqtC7aFeVkdb89rA",
                            "rating": 3,
                            "user": {
                                "id": "lIXUY8AgtHJoEjuS0rYyBA",
                                "image_url": "https://s3-media2.fl.yelpcdn.com/photo/ocXtPhaW14wHlWwNl5EL4A/o.jpg",
                                "name": "Michael G."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Sushi Bars",
                            "alias": "sushi"
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
                        "formatted_address": "5115 W Spring Mountain Rd\\nSte 117\\nLas Vegas, NV 89146"
                    }
                },
                {
                    "id": "bjSC_jbrypke0l-bXXBmwQ",
                    "name": "Vic & Anthony's Steakhouse",
                    "price": "\$\$\$\$",
                    "rating": 4.4,
                    "photos": [
                        "https://s3-media4.fl.yelpcdn.com/bphoto/r4Bjje_aK60E1-AhTrZfgg/o.jpg"
                    ],
                    "reviews": [
                        {
                            "id": "RYDe2CCV9R7I3anibGA2Ug",
                            "rating": 5,
                            "user": {
                                "id": "JeZZ6navHW7LiryfmZxtTA",
                                "image_url": "https://s3-media4.fl.yelpcdn.com/photo/hElc0ivqmkDoQlHv-UstDA/o.jpg",
                                "name": "Bob D."
                            }
                        },
                        {
                            "id": "M9XGLgDOTF8XD8mQfjq3xQ",
                            "rating": 5,
                            "user": {
                                "id": "vyu7-MEJWsGhGTTj69QCGg",
                                "image_url": "https://s3-media3.fl.yelpcdn.com/photo/d_TcXEZEBGj8x75NPSbGyg/o.jpg",
                                "name": "David L."
                            }
                        },
                        {
                            "id": "4Qx1xws9uKHZ3JVRKSV-IQ",
                            "rating": 4,
                            "user": {
                                "id": "SKLSpueHP5oU_kUWD-ttQw",
                                "image_url": "https://s3-media1.fl.yelpcdn.com/photo/3SoPcAKVBjS1k2RJTSrSUg/o.jpg",
                                "name": "Marie C."
                            }
                        }
                    ],
                    "categories": [
                        {
                            "title": "Steakhouses",
                            "alias": "steak"
                        },
                        {
                            "title": "New American",
                            "alias": "newamerican"
                        }
                    ],
                    "hours": [
                        {
                            "is_open_now": true
                        }
                    ],
                    "location": {
                        "formatted_address": "129 E Fremont St\\nLas Vegas, NV 89101"
                    }
                }
            ]
        }
    }
}
''';

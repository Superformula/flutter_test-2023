import 'package:restaurantour/models/api_status.dart';
import 'package:restaurantour/models/restaurant.dart';

class TestUtil {
  static restaurantData() {
    RestaurantQueryResult response = RestaurantQueryResult(
      total: 3,
      restaurants: [
        Restaurant(
          id: "faPVqws-x-5k2CQKDNtHxw",
          name: "name",
          price: "\$\$",
          photos: [
            "https://s3-media4.fl.yelpcdn.com/bphoto/7BcH3pDde3hQRKtFbwpWVw/o.jpg"
          ],
          rating: 4.5,
          categories: [
            Category(alias: "southern", title: "southern"),
            Category(alias: "newamerican", title: "American (New)"),
            Category(alias: "cocktailbars", title: "Cocktail Bars")
          ],
          hours: [const Hours(isOpenNow: true)],
          reviews: const [
            Review(
                id: "O0S4tG3FjvCgmQMHEOgCIg",
                rating: 3,
                user: User(
                    id: "6ACLo268kDPp94UQdFErlg",
                    imageUrl: null,
                    name: "Brad D.")),
            Review(
                id: "15Vpk2myqQB4PEPV3DyG1g",
                rating: 5,
                user: User(
                    id: "zsvx7fUUoWZx4DesYbctNA",
                    imageUrl: null,
                    name: "May C.")),
            Review(
                id: "4a7KGQF8SqZEipTF3Jq2TQ",
                rating: 5,
                user: User(
                    id: "OUI6q3nLOl3u08GdME84QQ",
                    imageUrl: null,
                    name: "Emmy M."))
          ],
        ),
        Restaurant(
          id: "4JNXUYY8wbaaDmk3BPzlWw",
          name: "Mon Ami Gabi",
          price: "\$\$\$",
          photos: [
            "https://s3-media3.fl.yelpcdn.com/bphoto/y-RtL3ftaVsM0h6a-ICOJg/o.jpg"
          ],
          rating: 4.0,
          categories: [
            Category(alias: "french", title: "French"),
            Category(alias: "steak", title: "Steakhouses"),
            Category(alias: "breakfast_brunch", title: "Breakfast & Brunch")
          ],
          hours: [const Hours(isOpenNow: false)],
          reviews: const [
            Review(
                id: "gwqJwlul2BdT4tyomwv2Xg",
                rating: 5,
                user: User(
                    id: "eAhXbG88MPtcMQJZkrDFBA",
                    imageUrl:
                        "https://s3-media1.fl.yelpcdn.com/photo/mq_GZjQ8bRQUxnZQ_j3ZHg/o.jpg",
                    name: "Becky M.")),
            Review(
                id: "FNt1MHf5RnlLfta6ufAThQ",
                rating: 4,
                user: User(
                    id: "8ngi_eRBlysfYkscc8q6Ww",
                    imageUrl: null,
                    name: "Julie D.")),
            Review(
                id: "CvYYgllz0yKqn825TgaTKA",
                rating: 5,
                user: User(
                    id: "jbaXxniH6XNgK6ubXNzP9g",
                    imageUrl:
                        "https://s3-media3.fl.yelpcdn.com/photo/_A3XlP2SgB_npB_O9Hk93g/o.jpg",
                    name: "Elle O."))
          ],
        ),
        Restaurant(
          id: "vHz2RLtfUMVRPFmd7VBEHA",
          name: "Gordon Ramsay Hell's Kitchen",
          price: "\$\$\$",
          photos: [
            "https://s3-media1.fl.yelpcdn.com/bphoto/EjZ-ne5_YmOYuhAVgG_niA/o.jpg"
          ],
          rating: 4.5,
          categories: [
            Category(alias: "newamerican", title: "American (New)"),
            Category(alias: "seafood", title: "Seafood")
          ],
          hours: [const Hours(isOpenNow: true)],
          reviews: const [
            Review(
                id: "GsWng3cPnqntI52hZeviMg",
                rating: 5,
                user: User(
                    id: "pweLcIK_6RfPQ-RrAOarvQ",
                    imageUrl: null,
                    name: "Anastasia Z.")),
            Review(
                id: "qOFcrHbArDJ1PAuhKQoKUQ",
                rating: 5,
                user: User(
                    id: "pvKOWC7ML36WAiUt5aPV3g",
                    imageUrl:
                        "https://s3-media2.fl.yelpcdn.com/photo/P1ABGQUnBjrgFx8OwrRC_A/o.jpg",
                    name: "DaeDae D.")),
            Review(
                id: "ihEtMgdHTJCCMNJB_qBKww",
                rating: 5,
                user: User(
                    id: "IqpnBvFoez4RkuV8EKeusA",
                    imageUrl: null,
                    name: "Heather B."))
          ],
        ),
      ],
    );

    return Success(response: response);
  }

  static failRestaurant() {
    return Failure(response: 400);
  }
}

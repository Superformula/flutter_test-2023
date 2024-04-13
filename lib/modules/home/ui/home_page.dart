import 'package:flutter/material.dart';
import 'package:restaurantour/modules/home/data/models/restaurant.dart';

import 'widgets/card_restaurant_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('RestauranteTour'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(tabs: [Tab(text: 'All Restaurants'), Tab(text: 'My Favorites')]),
          ),
        ),

        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              itemCount: 10,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return CardRestaurantWidget(
                  restaurant: Restaurant(
                    photos: [
                      'https://s3-alpha-sig.figma.com/img/884d/9866/2c5877a8d54dfb9f772a779f3ddeccca?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=g3vmSZxTPNAfyiu5OZO4Nw0O2tlQBf1bsL1UvAnmlFUIY20pUNVnf-e1LsXBFGhymW7gdsxOcW6etNMPgQa~I6z1ANdtiAE1mUv37GsoIl9mxkUTQ2FoVGlHgUvnCbeSagJR~3Jya7flmwTpTEM0iZftVtixECmw~OSTAnZvFRrt3TozGmBB5-YRrayQvT6OpvTfdp7XCXuhgmpFN1QNxdjVRw97boobjEAZAN6pf88-WocQhJrmsmYVPEiB~5YIgZzj59NUua0ZlsIFfC1rWneb7b2D~3HJqt9luTyrxujrftp6tLL1ki52gAFfQx~6LUiZ1UkyWqLSSfEkVCMKJg__',
                    ],
                    name: 'Restaurant Name Goes Here And Wraps 2 Lines',
                    categories: [
                      Category(
                        title: '\$\$\$\$ italian',
                      ),
                    ],
                    rating: 4.5,
                    hours: [const Hours(isOpenNow: true)],
                    location: Location(formattedAddress: '102 Lakeside Ave\nSeattle, WA 98122'),
                    reviews: [
                      Review(
                        id: index.toString(),
                        rating: index + 1,
                        user: const User(
                          name: 'User Name',
                          imageUrl:
                              'https://s3-alpha-sig.figma.com/img/f82b/5570/0afc0622730b45d13b00a1f62566aa13?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ao7CT3LD78UzghqfdJD7XE8ejLw1Ln4D~wGRn0vVpqIB4jJ0Y-bNxIxQgcrjHveJjiApW2C1eWl6xqSb9miMuM-hOW645CR068p14ha2iSBVVCs44wdaQGnNzSncH7Msy~RRdDDuXm0-0PIS9geUVj0H3F-Xv93gm99vpcdb0D3Kwjn9I64nfaptKZKy7R6cfjL7hBJav0g~b6IRiiEFkPQ6q4~wjbEn0ZFni2e7BBO~DF3O50dhQ8nmGl~7ES2n6848gsQPBYsha-Yto38t2gjdZLmrFkB9QavgcMY2~AU6TcrHFzQKzxMDrc8sFojZNEQ7Tb79LFOG~Qs-SE49iw__',
                        ),
                      ),
                      Review(
                        id: index.toString(),
                        rating: index + 1,
                        user: const User(
                          name: 'User Name',
                          imageUrl:
                              'https://s3-alpha-sig.figma.com/img/f82b/5570/0afc0622730b45d13b00a1f62566aa13?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ao7CT3LD78UzghqfdJD7XE8ejLw1Ln4D~wGRn0vVpqIB4jJ0Y-bNxIxQgcrjHveJjiApW2C1eWl6xqSb9miMuM-hOW645CR068p14ha2iSBVVCs44wdaQGnNzSncH7Msy~RRdDDuXm0-0PIS9geUVj0H3F-Xv93gm99vpcdb0D3Kwjn9I64nfaptKZKy7R6cfjL7hBJav0g~b6IRiiEFkPQ6q4~wjbEn0ZFni2e7BBO~DF3O50dhQ8nmGl~7ES2n6848gsQPBYsha-Yto38t2gjdZLmrFkB9QavgcMY2~AU6TcrHFzQKzxMDrc8sFojZNEQ7Tb79LFOG~Qs-SE49iw__',
                        ),
                      ),
                      Review(
                        id: index.toString(),
                        rating: index + 1,
                        user: const User(
                          name: 'User Name',
                          imageUrl:
                              'https://s3-alpha-sig.figma.com/img/f82b/5570/0afc0622730b45d13b00a1f62566aa13?Expires=1713744000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ao7CT3LD78UzghqfdJD7XE8ejLw1Ln4D~wGRn0vVpqIB4jJ0Y-bNxIxQgcrjHveJjiApW2C1eWl6xqSb9miMuM-hOW645CR068p14ha2iSBVVCs44wdaQGnNzSncH7Msy~RRdDDuXm0-0PIS9geUVj0H3F-Xv93gm99vpcdb0D3Kwjn9I64nfaptKZKy7R6cfjL7hBJav0g~b6IRiiEFkPQ6q4~wjbEn0ZFni2e7BBO~DF3O50dhQ8nmGl~7ES2n6848gsQPBYsha-Yto38t2gjdZLmrFkB9QavgcMY2~AU6TcrHFzQKzxMDrc8sFojZNEQ7Tb79LFOG~Qs-SE49iw__',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(),
          ],
        ),
        // body: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       const Text('Restaurantour'),
        //       ElevatedButton(
        //         child: const Text('Fetch Restaurants'),
        //         onPressed: () async {
        //           final yelpRepo = YelpRepository();

        //           try {
        //             final result = await yelpRepo.getRestaurants();
        //             if (result != null) {
        //               print('Fetched ${result.restaurants!.length} restaurants');
        //             } else {
        //               print('No restaurants fetched');
        //             }
        //           } catch (e) {
        //             print('Failed to fetch restaurants: $e');
        //           }
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

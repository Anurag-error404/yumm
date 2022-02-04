import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yumm/models/burgers-data.dart';

class BurgerGrid extends StatelessWidget {
  const BurgerGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
        itemCount: burgerData.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                mainAxisSpacing: 10),
        itemBuilder:
            (BuildContext context, index) {
          BurgerData burger = burgerData[index];
          return Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
                horizontal: 5, vertical: 5),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    height: size.height * 0.3,
                    imageUrl: burger.imgUrl,
                    placeholder: (context, url) =>
                        const Center(
                      child:
                          CircularProgressIndicator(),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets
                            .symmetric(
                        horizontal: 8,
                        vertical: 5),
                    width: size.width * 0.4,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(
                                10),
                        color: const Color(
                            0xff02040F)),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          burger.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:
                                Color(0xffE5DADA),
                          ),
                        ),
                        SizedBox(height: 2,),
                        Text(
                          "${burger.price} Rs",
                          style: const TextStyle(
                            fontSize: 18,
                            color:
                                Color(0xffE59500),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

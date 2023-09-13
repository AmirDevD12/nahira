import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rahina/model/model.dart';


class Home extends StatefulWidget {
  String information;
  List<String> nameganers;
  Home({Key? key, required this.nameganers, required this.information})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CarouselController controller = CarouselController();
  final PageController pageController = PageController();
  final List<String> url = [];
  final List<String> title = [];
  final List<String> star = [];
  final List<String> country = [];
  final List<String> year = [];

  @override
  void initState() {
    // TODO: implement initState
    Autogenerated responsgenreat =
        Autogenerated.fromJson(jsonDecode(widget.information));
    if (responsgenreat.data != null) {
      for (var movi in responsgenreat.data!) {
        url.add(movi.poster!);
        title.add(movi.title!);
        star.add(movi.imdbRating!);
        country.add(movi.country!);
        year.add(movi.year!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.black,
            child: Column(
              children: [
                CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: url.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Stack(
                    children: [
                      Column(
                        children: [
                          Flexible(
                              child: Image.network(url[itemIndex])),
                        ],
                      ),
                      Positioned(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text(
                              title[itemIndex],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star),
                              Text(
                                maxLines: 1,
                                "${star[itemIndex]}/${country![itemIndex]}${year![itemIndex]}/",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ))
                    ],
                  ),
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(width: double.infinity / 2, child: Text("Genres")),
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.nameganers.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            widget.nameganers[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  );
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(width: double.infinity, child: Text("Last movies")),
          ),
          SizedBox(
            width: double.infinity,
            height: height * 0.5,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: url.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Image.network(url![index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: 100,
                                          child: Text(title[index])),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.star),
                                          SizedBox(
                                              width: 80,
                                              child: Text(star[index])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.data_saver_on_rounded),
                                          SizedBox(
                                              width: 80,
                                              child: Text(country![index])),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.yard),
                                          SizedBox(
                                              width: 80,
                                              child: Text(year![index])),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          SizedBox(
                                              width: 100,
                                              child: Text(
                                                "Get more info  >",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}

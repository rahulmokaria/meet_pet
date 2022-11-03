// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meet_pet/utils/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/pet.dart';

class PetDescription extends StatefulWidget {
  Pet cpet;
  PetDescription({
    Key? key,
    required this.cpet,
  }) : super(key: key);
  @override
  State<PetDescription> createState() => _PetDescriptionState();
}

class _PetDescriptionState extends State<PetDescription> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    print(widget.cpet.desc);
    return Scaffold(
      backgroundColor: secondary,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.width * 1.1,
                          // aspectRatio: 1,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                          // width: MediaQuery.of(context).size.width,
                          ),
                      items: widget.cpet.imgs
                          .map((item) => Container(
                                child: Center(
                                    child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.width * 1.1,
                                  width: MediaQuery.of(context).size.width,
                                )),
                              ))
                          .toList(),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 20,
                      child: Row(
                        children: widget.cpet.imgs.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: white.withOpacity(
                                      _current == entry.key ? 1 : 0.5)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                // Flexible(flex: 1, child: Container()),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Neumorphic(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    margin: const EdgeInsets.only(top: 20),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      surfaceIntensity: .1,
                      color: secondary,
                      // color: pink,
                      shadowLightColor: secondaryLight,
                      shadowDarkColor: secondaryDark,
                      depth: 18,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    widget.cpet.name,
                                    textScaleFactor: 1.5,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: black,
                                    ),
                                  ),
                                  Icon(
                                    widget.cpet.gender == "M"
                                        ? Icons.male
                                        : Icons.female,
                                    color: Colors.black.withOpacity(.40),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.cpet.breed +
                                        " - " +
                                        widget.cpet.type,
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                  Text(
                                    widget.cpet.age.toString() + " years old",
                                    style: TextStyle(
                                      color: black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: black,
                                    size: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.cpet.address.city,
                                      style: TextStyle(
                                        color: black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Flexible(flex: 1, child: Container()),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(children: [
                    Row(
                      children: [
                        //image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/owl.jpg',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cpet.oldOwner,
                              textScaleFactor: 1.4,
                              style: TextStyle(
                                color: black.withOpacity(0.5),
                              ),
                            ),
                            Text(
                              "Owner",
                              style: TextStyle(
                                color: black.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                        //column

                        Flexible(child: Container(), flex: 1),
                        Text(
                          widget.cpet.datePosted.day.toString() +
                              " " +
                              widget.cpet.datePosted.month.toString() +
                              " " +
                              widget.cpet.datePosted.year.toString(),
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            color: black.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      widget.cpet.desc,
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: black.withOpacity(0.5),
                      ),
                    )
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(18)),
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              color: white,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.65,
                            decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(18)),
                            child: const Center(
                                child: Text(
                              "Adoption",
                              textScaleFactor: 1.3,
                              style: TextStyle(color: white),
                            )),
                          ),
                        )
                      ]),
                ),
              ],
            ),
            Positioned(
                top: 15,
                left: 10,
                child: FloatingActionButton(
                  elevation: 0,
                  // backgroundColor: black.withOpacity(0.2),
                  backgroundColor: Colors.transparent,
                  child: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  // shape: ShapeBorder.,
                ))
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meet_pet/resources/firestore_methods.dart';

import 'package:meet_pet/utils/colors.dart';

import '../models/pet.dart';
import '../models/user.dart';
import '../widgets/show_snackbar.dart';

class PetDescription extends StatefulWidget {
  Pet cpet;
  User cuser;

  PetDescription({
    Key? key,
    required this.cpet,
    required this.cuser,
  }) : super(key: key);
  @override
  State<PetDescription> createState() => _PetDescriptionState();
}

class _PetDescriptionState extends State<PetDescription> {
  int _current = 0;
  bool isFavPet = false;
  final CarouselController _controller = CarouselController();
  bool isLoadingFav = false;
  bool isLoadingAdopt = false;

  @override
  void initState() {
    super.initState();
    isFavPet = (widget.cuser.favPetList.contains(widget.cpet.petId));
  }

  confirmDialog(width) {
    print("Kuchbhi");
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(width * 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Confirm Adoption',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 5,
              ),
            ),
            SizedBox(height: width * 3),
            Text(
              'Are you sure you want to send adoption request?',
              style: TextStyle(fontSize: width * 4),
            ),
            SizedBox(height: width * 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    // Perform action when Cancel is tapped
                    Navigator.of(context).pop(false);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 4,
                      vertical: width * 2,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width * 4,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 2),
                InkWell(
                  onTap: () {
                    // Perform action when Confirm is tapped

                    sendRequest();

                    Navigator.of(context).pop(true);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 4,
                      vertical: width * 2,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: width * 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sendRequest() async {
    setState(() {
      isLoadingAdopt = true;
    });
    try {
      String res = await FireStoreMethods()
          .sendAdoptionRequest(widget.cpet, widget.cuser);
      if (res == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(showCustomSnackBar(
            message:
                "Adoption request sent successfully, wait till the owner responds. Meanwhile, you can also contact the owner for better understanding.",
            ctype: ContentType.success));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            showCustomSnackBar(message: res, ctype: ContentType.failure));
      }
    } catch (e) {}
    setState(() {
      isLoadingAdopt = false;
    });
  }

  changeFavList() async {
    setState(() {
      isLoadingFav = true;
    });
    try {
      String res = await FireStoreMethods()
          .changeFavList(widget.cuser, widget.cpet.petId, isFavPet);
      if (res == 'success') {
        isFavPet ^= true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            showCustomSnackBar(message: res, ctype: ContentType.failure));
      }
    } catch (e) {}
    setState(() {
      isLoadingFav = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 100;
    var _height = MediaQuery.of(context).size.height / 100;
    // print(widget.cpet.desc);
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
                          height: _width * 110,
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
                                    child: Image.network(
                                  item,
                                  fit: BoxFit.cover,
                                  height: _width * 110,
                                  width: _width * 100,
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
                                    color: black,
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
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.07),
                          child: //Image.network(
                              // 'assets/images/owl.jpg',
                              // height: 50,
                              // width: 50,
                              // fit: BoxFit.cover,
                              // ),
                              Image.asset(
                            'assets/images/owl.jpg',
                            height: _width * 14,
                            width: _width * 14,
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
                          "${widget.cpet.datePosted.day} ${widget.cpet.datePosted.month} ${widget.cpet.datePosted.year}",
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
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_width * 8),
                      topRight: Radius.circular(_width * 8),
                    ),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            changeFavList();
                          },
                          child: (isLoadingFav)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: white,
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  width: _width * 20,
                                  decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Icon(
                                    isFavPet
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: white,
                                  ),
                                ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => confirmDialog(_width)
                                // )
                                );
                          },
                          child: (isLoadingAdopt)
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: white,
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(10),
                                  width: _width * 65,
                                  decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: const Center(
                                      child: Text(
                                    "Adopt",
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

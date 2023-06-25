import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meet_pet/screens/pet_description_page.dart';

import '../models/pet.dart';
import '../models/request.dart';
import '../models/user.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../widgets/show_snackbar.dart';
import 'home_page.dart';

class NotificationPage extends StatefulWidget {
  User cUser;
  NotificationPage({
    Key? key,
    required this.cUser,
  }) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isLoading = false;
  List<dynamic> requestList = [];
  bool isSent = false;

  showPet(petId) async {
    setState(() {
      _isLoading = true;
    });
    Pet pet = Pet.dummy();
    try {
      pet = await FireStoreMethods().getPet(petId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        showCustomSnackBar(
          ctype: ContentType.failure,
          message: e.toString(),
        ),
      );
    }
    print(requestList.length);

    setState(() {
      _isLoading = false;
    });
    if (pet == Pet.dummy()) {
      ScaffoldMessenger.of(context).showSnackBar(
        showCustomSnackBar(
          ctype: ContentType.failure,
          message: "Some error occured loading pet. Try again",
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PetDescription(
            cpet: pet,
            cuser: widget.cUser,
          ),
        ),
      );
    }
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      requestList =
          await FireStoreMethods().getReceivedRequests(widget.cUser.uid);
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   showCustomSnackBar(
      //     ctype: ContentType.failure,
      //     message: e.toString(),
      //   ),
      // );
    }
    // print(requestList.length);

    setState(() {
      _isLoading = false;
    });
    // print(userData);
  }

  changeData() async {
    if (isSent) {
      setState(() {
        _isLoading = true;
      });
      try {
        requestList =
            await FireStoreMethods().getSentRequests(widget.cUser.uid);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(
            ctype: ContentType.failure,
            message: e.toString(),
          ),
        );
      }
      // print(requestList.length);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        requestList =
            await FireStoreMethods().getReceivedRequests(widget.cUser.uid);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(
            ctype: ContentType.failure,
            message: e.toString(),
          ),
        );
      }
      // print(requestList.length);

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  showReceived(_width) {
    return (requestList.isEmpty)
        ? Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "No notifications",
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: black,
                ),
              ),
            ),
          )
        : Column(
            children: [
              for (var request in requestList) ...[
                Container(
                  width: _width * 90,
                  child: Neumorphic(
                    padding: EdgeInsets.all(_width * 4),
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      surfaceIntensity: .1,
                      color: secondary,
                      // color: pink,
                      shadowLightColor: secondaryLight,
                      shadowDarkColor: secondaryDark,
                      depth: 18,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          request.senderName +
                              " sent you an adoption request for your pet " +
                              request.petName,
                          style: TextStyle(color: black),
                          textScaleFactor: 1.2,
                        ),
                        SizedBox(
                          height: _width * 5,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     // Handle View Profile button tap
                        //   },
                        //   child: Text('View Profile'),
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.white,
                        //     onPrimary: Colors.blueAccent,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(16.0),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: _width * 2,
                        // ),
                        if (request.status != "Pending") ...[
                          InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              width: _width * 80,
                              height: _width * 10,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Text(
                                'Adoption Status: ' + request.status,
                                style: TextStyle(color: primary),
                              ),
                            ),
                          ),
                        ],
                        if (request.status == "Pending") ...[
                          ElevatedButton(
                            onPressed: () {
                              // Handle Confirm Adoption button tap
                              showDialog(
                                  context: context,
                                  builder: (_) => confirmAdoptionDialog(
                                        request,
                                        _width,
                                      )
                                  // )
                                  );
                            },
                            child: Text('Confirm Adoption'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _width * 2,
                          ),
                        ],
                        if (request.status == "Pending") ...[
                          ElevatedButton(
                            onPressed: () {
                              // Handle Cancel button tap
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      cancelDialog(request, _width, false)
                                  // )
                                  );
                            },
                            child: Text(
                              'Cancel',
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ]
            ],
          );
  }

  showSent(_width) {
    return (requestList.isEmpty)
        ? Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                "No notifications",
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: black,
                ),
              ),
            ),
          )
        : Column(
            children: [
              for (Request request in requestList) ...[
                Container(
                  width: _width * 90,
                  child: Neumorphic(
                    padding: EdgeInsets.all(_width * 4),
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      surfaceIntensity: .1,
                      color: secondary,
                      // color: pink,
                      shadowLightColor: secondaryLight,
                      shadowDarkColor: secondaryDark,
                      depth: 18,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "You sent an adoption request to " +
                              request.ownerName +
                              " for the pet " +
                              request.petName,
                          style: TextStyle(color: black),
                          textScaleFactor: 1.2,
                        ),
                        SizedBox(
                          height: _width * 5,
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            width: _width * 80,
                            height: _width * 10,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(
                              'Adoption Status: ' + request.status,
                              style: TextStyle(color: primary),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _width * 3,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle View Profile button tap
                            showPet(request.petId);
                          },
                          child: Text('View Pet'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _width * 2,
                        ),
                        if (request.status == "Pending")
                          ElevatedButton(
                            onPressed: () {
                              // Handle Cancel button tap
                              showDialog(
                                  context: context,
                                  builder: (_) =>
                                      cancelDialog(request, _width, true)
                                  // )
                                  );
                            },
                            child: Text(
                              'Cancel',
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              onPrimary: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          );
  }

  cancelRequest(request, bool isSender) async {
    setState(() {
      _isLoading = true;
    });
    String res = "Some error occurred";
    try {
      if (isSender)
        res = await FireStoreMethods().cancelRequestFromSender(request);
      else
        res = await FireStoreMethods().cancelRequestByOwner(request);
      if (res == "success") {
        changeData();
        ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(
            ctype: ContentType.success,
            message: "Adoption request cancelled.",
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(
            ctype: ContentType.failure,
            message: res.toString(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        showCustomSnackBar(
          ctype: ContentType.failure,
          message: e.toString(),
        ),
      );
    }
    print(requestList.length);

    setState(() {
      _isLoading = false;
    });
  }

  cancelDialog(Request request, double width, bool isSender) {
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
              'Cancel Adoption',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width * 5,
              ),
            ),
            SizedBox(height: width * 3),
            Text(
              (isSender)
                  ? 'Are you sure you want to cancel this adoption request?'
                  : 'Are you sure you want to reject this adoption request?',
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

                    cancelRequest(request, isSender);

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

  confirmAdoptRequest(request) async {
    setState(() {
      _isLoading = true;
    });
    String res = "Some error occurred";
    try {
      res = await FireStoreMethods().confirmRequest(request);

      if (res == "success") {
        changeData();
        ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(
            ctype: ContentType.success,
            message: "Adoption request Accepted.",
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          showCustomSnackBar(
            ctype: ContentType.failure,
            message: res.toString(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        showCustomSnackBar(
          ctype: ContentType.failure,
          message: e.toString(),
        ),
      );
    }
    print(requestList.length);

    setState(() {
      _isLoading = false;
    });
  }

  confirmAdoptionDialog(Request request, double width) {
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
              'Are you sure you want to accept this adoption request?',
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

                    confirmAdoptRequest(request);

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

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width / 100;
    var _height = MediaQuery.of(context).size.height / 100;
    // print(petList);
    var red;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(
          "Notifications",
          style: TextStyle(
            color: primary,
          ),
          textAlign: TextAlign.center,
        ),
        // elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.barsStaggered,
            color: primary,
          ),
          onPressed: () {
            zoomDrawerController.toggle!();
          },
        ),
        // shadowColor: secondaryLight,
        shadowColor: Colors.transparent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: white,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), //~~
                  topRight: Radius.circular(40),
                ),
                color: secondary,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(_width * 2),
                child: Column(
                  children: [
                    Container(
                      height: _width * 15,
                      padding: EdgeInsets.all(_width * 2),
                      margin:
                          EdgeInsets.only(left: _width * 4, right: _width * 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: _width * 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: !isSent
                                    ? primary.withOpacity(0.8)
                                    : secondary.withOpacity(0),
                              ),
                              height: _width * 9,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isSent = false;
                                    changeData();
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'Received',
                                    textScaleFactor: !isSent ? 1.45 : 1.3,
                                    style: TextStyle(
                                      color: !isSent ? secondary : primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: _width * 1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isSent
                                    ? primary.withOpacity(0.8)
                                    : secondary.withOpacity(0),
                              ),
                              height: _width * 9,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isSent = true;
                                    changeData();
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'Sent',
                                    textScaleFactor: isSent ? 1.45 : 1.3,
                                    style: TextStyle(
                                      color: isSent ? secondary : primary,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    (isSent) ? showSent(_width) : showReceived(_width),
                  ],
                ),
              ),
            ),
    );
  }
}

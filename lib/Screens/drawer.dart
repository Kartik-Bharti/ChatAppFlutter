// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:groupie/Screens/profile_screen.dart';
import 'package:groupie/Screens/login_in_screen.dart';
import 'package:groupie/services/auth_services.dart';
import 'package:groupie/services/shared_preferences.dart';
import 'package:groupie/shared/constants.dart';
import 'package:groupie/widgets/widget.dart';

class Userdrawer extends StatefulWidget {
  const Userdrawer({super.key});

  @override
  State<Userdrawer> createState() => _UserdrawerState();
}

class _UserdrawerState extends State<Userdrawer> {
  Authservices authservices = Authservices();
  bool selectd = false;
  String username = "";
  String useremail = "";
  @override
  void initState() {
    super.initState();
    getuserdata();
  }

  void getuserdata() async {
    await Sharedprefererncedata.getusername().then((value) {
      setState(() {
        username = value;
      });
    });
    await Sharedprefererncedata.getuseremail().then((value) {
      setState(() {
        useremail = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            currentAccountPictureSize: const Size.fromRadius(40),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("assets/images/jassmanak.png"),
            ),
            accountName: Text(username),
            accountEmail: Text(useremail),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backimage.png"),
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.group),
            selected: true,
            selectedColor: Constants().primarycolor,
            title: const Text(
              "Group",
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Divider(height: 2),
          ListTile(
            onTap: () {
              nextpage(
                context,
                Profilescreen(username: username, useremail: useremail),
              );
            },
            selected: selectd,
            leading: const Icon(Icons.account_box_sharp),
            selectedColor: Constants().primarycolor,
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          const Divider(height: 2),
          ListTile(
            onTap: () async {
              showDialog(
//if we click outside the box the box will not disapperar becausebarrierDismissible is false
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure, you want to logout!"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: Constants().primarycolor,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await authservices.signout(context).whenComplete(() {
                            nextpagereplacement(context, const Loginscreen());
                          });
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            leading: const Icon(Icons.logout),
            selectedColor: Constants().primarycolor,
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

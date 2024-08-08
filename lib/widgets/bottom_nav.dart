// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:hotel_booking_app/Home/home.dart';
import 'package:hotel_booking_app/Navbar/nav_help.dart';
import 'package:hotel_booking_app/Navbar/nav_profile.dart';
import 'package:hotel_booking_app/Navbar/nav_save.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Dash extends StatefulWidget {
  Dash({
    super.key,
  });

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> with AutomaticKeepAliveClientMixin {
  late PersistentTabController _controller;
  bool didAuthenticate = false;
  late List<Widget> screens = [
    const Home(),
    const Saved(),
    const Help(),
    Profile(),
  ];

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PersistentTabView(
      context,
      navBarHeight: 63,
      controller: _controller,
      screens: screens,
      padding: const NavBarPadding.only(bottom: 4),
      items: [
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.home_outlined),
            activeColorPrimary: Colors.red,
            inactiveColorPrimary: Colors.black,
            title: 'Home'),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.bookmark_outline_outlined),
            activeColorPrimary: Colors.red,
            inactiveColorPrimary: Colors.black,
            title: 'Bookings'),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.help_outline),
            activeColorPrimary: Colors.red,
            inactiveColorPrimary: Colors.black,
            title: 'Support'),
        PersistentBottomNavBarItem(
            icon: const Icon(Icons.person_outline),
            activeColorPrimary: Colors.red,
            inactiveColorPrimary: Colors.black,
            title: 'Profile'),
      ],
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      hideNavigationBar:
          MediaQuery.of(context).viewInsets.bottom > 30 ? true : false,
      stateManagement: true,
      decoration: NavBarDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            offset: const Offset(0, 0.5),
            color: Colors.black.withOpacity(0.5),
          )
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}

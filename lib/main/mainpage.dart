import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sem5demo3/main/mainhompage.dart';
import 'package:sem5demo3/main/mainprofile.dart';
import 'package:sem5demo3/main/parkingone.dart';
import 'package:sem5demo3/main/saved.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const MainHomePage(),
      const MainSavePage(),
      const MainParkingPage(),
      const ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_filled,size: 22,),
        title: ("Home"),
        activeColorPrimary: Colors.blueAccent.shade700.withOpacity(0.8),
        // activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey.shade500,
        textStyle: GoogleFonts.poppins(fontSize: 11)

      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.bookmark,size: 22,),
        title: ("Saved"),
        activeColorPrimary: Colors.blueAccent.shade700.withOpacity(0.8),
        // activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey.shade500,
        textStyle: GoogleFonts.poppins(fontSize: 11)
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.sticky_note_2_outlined,size: 22,),
        title: ("Parking"),
        activeColorPrimary: Colors.blueAccent.shade700.withOpacity(0.8),
        // activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey.shade500,
        textStyle: GoogleFonts.poppins(fontSize: 11)
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person,size: 22,),
        title: ("Profile"),
        activeColorPrimary: Colors.blueAccent.shade700.withOpacity(0.8),
        // activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.grey.shade500,
        textStyle: GoogleFonts.poppins(fontSize: 11)
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
        context,
        controller: _controller,
        navBarHeight: 55,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(15),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,
        // Choose the nav bar style with this property.
      )
    );
  }
}

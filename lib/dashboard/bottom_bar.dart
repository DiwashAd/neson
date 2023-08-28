import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neson/dashboard/dashboard_logic.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0)).then((value) {
      ref.read(dashboardLogic).changeBody(0);
      ref.read(dashboardLogic).fetchConference();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
        currentIndex: ref.watch(dashboardLogic).selectedBody,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: (index) {
          ref.watch(dashboardLogic).changeBody(index);
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Image.asset(
              "assets/house.png",
              color: ref.watch(dashboardLogic).selectedBody == 0
                  ? const Color(0xff1A6BE5)
                  : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: "Conference",
            icon: Image.asset(
              "assets/con.png",
              color: ref.watch(dashboardLogic).selectedBody == 1
                  ? const Color(0xff1A6BE5)
                  : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: "Gallery",
            icon: Image.asset(
              "assets/image.png",
              color: ref.watch(dashboardLogic).selectedBody == 2
                  ? const Color(0xff1A6BE5)
                  : Colors.grey,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Image.asset(
              "assets/user.png",
              color: ref.watch(dashboardLogic).selectedBody == 3
                  ? const Color(0xff1A6BE5)
                  : Colors.grey,
            ),
          ),
        ],
      ),
      body: ref.watch(dashboardLogic).bodyWidget,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ipapi/const/app_colors.dart';

class BottomBarScreen extends StatefulWidget {
  final StatefulNavigationShell? navigationShell;

  BottomBarScreen({super.key, this.navigationShell});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List iconList = [Icons.home, Icons.add, Icons.add];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.secondary,
          unselectedItemColor: AppColors.neutral300,
          selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: AppColors.primary),
          unselectedLabelStyle: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, height: 1.5),
          items: <BottomNavigationBarItem>[
            buildBottomNavigationBarItem('', 'Home', 0),
            buildBottomNavigationBarItem('', '-', 1),
            buildBottomNavigationBarItem('', '-', 2),
          ],
          currentIndex: widget.navigationShell!.currentIndex,
          onTap: (value) {
            _goBranch(value, context);
          },
        ),
      ),
    );
  }

  /// FOR NAVIGATION IN MAIN SCREEN
  void _goBranch(int index, BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    widget.navigationShell?.goBranch(
      index,
      initialLocation: index == widget.navigationShell?.currentIndex,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      String activeIcon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconList[index],
        color: AppColors.neutral300,
      ),
      activeIcon: Icon(
        iconList[index],
        color: AppColors.primary,
      ),
      label: label,
    );
  }
}

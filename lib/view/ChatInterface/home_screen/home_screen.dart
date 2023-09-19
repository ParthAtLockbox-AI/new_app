import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/view/ChatInterface/home_screen/history_tab.dart';
import 'package:ipapi/view/ChatInterface/home_screen/home_tab.dart';
import 'package:ipapi/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeViewModel homeViewModel = Get.find();
  @override
  void initState() {
    homeViewModel.tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewModel.scrollController.jumpTo(
        homeViewModel.scrollController.position.maxScrollExtent,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: GetBuilder<HomeViewModel>(
        builder: (controller) {
          return Container(
            color: AppColors.backgroundColor,
            height: 70,
            child: TabBar(
              indicatorColor: Colors.transparent,
              controller: controller.tabController,
              onTap: (value) {
                controller.updateSelectedTab(value);
              },
              tabs: [
                TabWidget(controller, index: 0, name: 'Home'),
                TabWidget(controller, index: 1, name: 'Call'),
                TabWidget(controller, index: 2, name: 'History'),
              ],
            ),
          );
        },
      ),
      body: GetBuilder<HomeViewModel>(
        builder: (controller) {
          return TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller.tabController,
            children: [
              HomeViewWidget(controller),
              SizedBox(),
              HistoryViewWidget(),
            ],
          );
        },
      ),
    );
  }

  /// Tab WIDGET
  Tab TabWidget(HomeViewModel controller,
      {required String name, required int index}) {
    return Tab(
      child: Text(
        '$name',
        style: TextStyle(
          color: controller.selectedTab == index
              ? AppColors.primary
              : AppColors.neutral300,
        ),
      ),
    );
  }
}

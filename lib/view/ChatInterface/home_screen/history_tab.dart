import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/view_model/home_view_model.dart';

/// HISTORY VIEW WIDGET
GetBuilder<HomeViewModel> HistoryViewWidget() {
  return GetBuilder<HomeViewModel>(
    builder: (controller) {
      controller.chatList.forEach((element) {
        if (controller.showDate!
            .contains(element['date'].toString().split(' ').first)) {
        } else {
          controller.showDate!.add(element['date'].toString().split(' ').first);
        }
      });
      return ListView.builder(
        controller: controller.scrollController,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(18, 50, 18, 80),
        addAutomaticKeepAlives: true,
        itemCount: controller.showDate?.length,
        itemBuilder: (context, index1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${controller.showDate![index1] == DateTime.now().toIso8601String().split('T').first ? 'Today' : controller.showDate![index1]}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.neutral300,
                ),
              ),
              SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                reverse: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(5),
                itemCount: controller.chatList.length,
                itemBuilder: (context, index) {
                  return controller.chatList[index]['date']
                              .toString()
                              .split(' ')
                              .first ==
                          controller.showDate![index1]
                      ? controller.chatList[index].keys.contains('answer')
                          ? SizedBox()
                          : ListTile(
                              onTap: () {
                                controller.updateSelectedTab(0);
                                controller.tabController?.animateTo(0);
                              },
                              visualDensity:
                                  VisualDensity(vertical: -4, horizontal: -4),
                              leading: Icon(
                                Icons.chat_bubble_outline,
                                color: AppColors.neutral400,
                              ),
                              title: Text(
                                '${controller.chatList[index]['question']}',
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: AppColors.neutral400, height: 1.5),
                              ),
                            )
                      : SizedBox();
                },
              ),
              SizedBox(height: 15),
            ],
          );
        },
      );
    },
  );
}

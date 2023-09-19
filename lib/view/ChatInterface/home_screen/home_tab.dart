import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/const/app_colors.dart';
import 'package:ipapi/view_model/home_view_model.dart';

/// HOME VIEW WIDGET
HomeViewWidget(HomeViewModel controller) {
  return Scaffold(
    backgroundColor: AppColors.backgroundColor,
    bottomSheet: GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 10,
              color: AppColors.backgroundColor,
            ),
            Container(
              color: AppColors.backgroundColor,
              child: Center(
                child: Container(
                  color: AppColors.backgroundColor,
                  width: Get.width,
                  constraints: BoxConstraints(maxWidth: 900),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: AppColors.basicBlack),
                          controller: controller.promptController,
                          onEditingComplete: () {
                            if (controller.promptController.text.isNotEmpty) {
                              controller.updateChatList();
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.scrollController.jumpTo(controller
                                  .scrollController.position.maxScrollExtent);
                            }
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            hintText: 'Enter a prompt here',
                            hintStyle: TextStyle(
                              color: AppColors.basicBlack.withAlpha(100),
                            ),
                            filled: true,
                            fillColor: AppColors.neutral100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 10,
              color: AppColors.backgroundColor,
            ),
          ],
        );
      },
    ),
    body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10000),
                      child: Image.network(
                        'https://wallpapercave.com/dwp1x/wp11990528.png',
                        height: 150,
                        width: 150,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: AppColors.neutral300,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            collapsedHeight: 10,
            expandedHeight: 220,
            toolbarHeight: 10,
            floating: true,
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
            forceElevated: innerBoxIsScrolled,
          ),
        ];
      },
      body: ListView.builder(
        controller: controller.scrollController,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
        addAutomaticKeepAlives: true,
        itemCount: controller.chatList.length,
        itemBuilder: (context, index) {
          return controller.chatList[index]['sender'] == 'me'
              ? MyDataShowWidget(controller: controller, index: index)
              : ApiDataShowWidget(controller: controller, index: index);
        },
      ),
    ),
  );
}

/// MY DATA WIDGET
MyDataShowWidget({required HomeViewModel controller, required int index}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          width: Get.width,
          constraints: BoxConstraints(maxWidth: 950),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  'https://wallpapercave.com/fuwp/uwp3611575.jpeg',
                  height: 50,
                  width: 50,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '${controller.chatList[index]['question']}',
                  overflow: TextOverflow.visible,
                  style: TextStyle(color: AppColors.basicBlack, height: 1.5),
                ),
              )
            ],
          ),
        ),
      ),
      Container(
        height: 0.4,
        width: Get.width,
        color: AppColors.neutral300,
      ),
    ],
  );
}

/// API DATA WIDGET
ApiDataShowWidget({required HomeViewModel controller, required int index}) {
  return Container(
    color: AppColors.neutral100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: Get.width,
            constraints: BoxConstraints(maxWidth: 950),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    'https://wallpapercave.com/dwp1x/wp11990528.png',
                    height: 50,
                    width: 50,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${controller.chatList[index]['answer']}',
                    overflow: TextOverflow.visible,
                    style: TextStyle(color: AppColors.basicBlack, height: 1.5),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 0.4,
          width: Get.width,
          color: AppColors.neutral300,
        ),
      ],
    ),
  );
}

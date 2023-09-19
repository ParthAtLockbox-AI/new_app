import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  TabController? tabController;
  int selectedTab = 0;
  updateSelectedTab(int index) {
    selectedTab = index;
    update();
  }

  List? showDate = [];

  TextEditingController promptController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> chatList = [
    {
      'sender': 'me',
      'question': 'What is Formula of Sodium?',
      'date': '2023-09-15 15:40:20.738',
      'id': '2',
    },
    {
      'sender': 'api',
      'answer':
          'The chemical symbol for sodium is Na. This symbol comes from the Latin word "natrium," which refers to a type of soda ash that sodium compounds were extracted from in ancient times.',
      'date': '2023-09-15 15:40:20.738',
      'id': '2',
    },
    {
      'sender': 'me',
      'question': 'What is Formula of Sodium?',
      'date': '2023-09-07 15:40:20.738',
      'id': '1',
    },
    {
      'sender': 'api',
      'answer':
          'The chemical symbol for sodium is Na. This symbol comes from the Latin word "natrium," which refers to a type of soda ash that sodium compounds were extracted from in ancient times.',
      'date': '2023-09-07 15:40:20.738',
      'id': '1',
    },
  ];

  updateChatList() {
    chatList.add({
      'sender': 'me',
      'question': promptController.text,
      'date': DateTime.now().toIso8601String().replaceAll('T', ' '),
      'id': '${Random().nextInt(100)}',
    });
    promptController.clear();
    update();
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipapi/model/create_talk_res_model.dart';
import 'package:ipapi/model/get_all_talk_res_model.dart';
import 'package:ipapi/model/get_talk_api_res_model.dart';
import 'package:ipapi/repo/create_talk_repo.dart';
import 'package:ipapi/repo/get_all_talk_repo.dart';
import 'package:ipapi/repo/get_talk_repo.dart';
import 'package:ipapi/service/api_service/api_response.dart';
import 'package:video_player/video_player.dart';

class ChatViewModel extends GetxController {
  String faceUrl = 'https://wallpapercave.com/dwp1x/wp11455901.jpg';

  /// USER ADDED PROMPT
  List<String> promptList = [];

  TextEditingController promptController = TextEditingController();

  updatePromptList(String value) {
    promptList.add(value);

    promptController.clear();
    update();
  }

  /// VIDEO PLAYER
  VideoPlayerController? videoPlayerController;
  bool loadingVideo = false;
  bool showSendButton = true;
  bool showLottiAnimation = false;

  updateShowLottiAnimation(bool val) {
    showLottiAnimation = val;
    update();
  }

  updateLoadingValue(bool val) {
    loadingVideo = val;
    update();
  }

  updateShowSendButton(bool val) {
    showSendButton = val;
    update();
  }

  clearValue() {
    loadingVideo = false;
    showSendButton = true;
    showLottiAnimation = false;
    update();
  }

  /// INITIALIZE VIDEO PLAYER
  initializeVideoPlayer({String? url}) async {
    if (url != null) {
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse('${url}'),
      );
      videoPlayerController!.initialize();
      videoPlayerController!.play();

      update();
      await Future.delayed(
        Duration(seconds: 2),
        () {
          updateLoadingValue(true);
          updateShowLottiAnimation(false);
        },
      );
    } else {
      clearValue();
    }
  }

  /// CREATE TALK API
  ApiResponse _createTalkApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get createTalkApiResponse => _createTalkApiResponse;

  Future<void> createTalkViewModel({
    BuildContext? context,
    bool isLoading = true,
    Map<String, dynamic>? body,
  }) async {
    if (isLoading) {
      _createTalkApiResponse = ApiResponse.loading(message: 'Loading');
    }

    try {
      CreateTalkResponseModel createTalkResponseModel =
          await CreateTalkRepo.createTalkRepo(
        body: body!,
      );

      print("createTalkResponseModel=response==>$createTalkResponseModel");

      _createTalkApiResponse = ApiResponse.complete(createTalkResponseModel);
    } catch (e) {
      print("createTalkResponseModel=e==>${e}");

      _createTalkApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// GET TALK API
  ApiResponse _getTalkApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getTalkApiResponse => _getTalkApiResponse;

  Future<void> getTalkViewModel({
    BuildContext? context,
    bool isLoading = true,
    String? fileId,
  }) async {
    if (isLoading) {
      _getTalkApiResponse = ApiResponse.loading(message: 'Loading');
    }

    try {
      GetTalkResponseModel getTalkResponseModel = await GetTalkRepo.getTalkRepo(
        fileId: fileId!,
      );

      log("GetTalkResponseModel=response==>${getTalkResponseModel.toJson()}");

      _getTalkApiResponse = ApiResponse.complete(getTalkResponseModel);
    } catch (e) {
      print("GetTalkResponseModel=e==>${e}");
      _getTalkApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// GET ALL TALK API
  ApiResponse _getAllTalkApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getAllTalkApiResponse => _getAllTalkApiResponse;

  Future<void> getAllTalkViewModel({
    BuildContext? context,
    bool isLoading = true,
  }) async {
    if (isLoading) {
      _getAllTalkApiResponse = ApiResponse.loading(message: 'Loading');
    }

    try {
      GetAllTalkResponseModel getTalkResponseModel =
          await GetAllTalkRepo.getAllTalkRepo();

      log("GetAllTalkResponseModel=response==>${getTalkResponseModel.toJson()}");

      _getAllTalkApiResponse = ApiResponse.complete(getTalkResponseModel);
    } catch (e) {
      print("GetAllTalkResponseModel=e==>${e}");
      _getAllTalkApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}

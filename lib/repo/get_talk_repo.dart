import 'package:ipapi/model/get_talk_api_res_model.dart';
import 'package:ipapi/service/api_service/api_const.dart';
import 'package:ipapi/service/api_service/base_services.dart';

class GetTalkRepo {
  static Future<GetTalkResponseModel> getTalkRepo(
      {required String fileId}) async {
    var response = await APIService().getResponse(
      url: '${BaseUrl.chatBaseUrl}/talks/$fileId',
      apiType: APIType.aGet,
    );
    GetTalkResponseModel getTalkResponseModel =
        GetTalkResponseModel.fromJson(response);
    return getTalkResponseModel;
  }
}

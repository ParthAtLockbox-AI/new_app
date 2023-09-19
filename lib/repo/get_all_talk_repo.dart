import 'package:ipapi/model/get_all_talk_res_model.dart';
import 'package:ipapi/service/api_service/api_const.dart';
import 'package:ipapi/service/api_service/base_services.dart';

class GetAllTalkRepo {
  static Future<GetAllTalkResponseModel> getAllTalkRepo() async {
    var response = await APIService().getResponse(
      url: '${BaseUrl.chatBaseUrl}/talks',
      apiType: APIType.aGet,
    );
    GetAllTalkResponseModel getAllTalkResponseModel =
        GetAllTalkResponseModel.fromJson(response);
    return getAllTalkResponseModel;
  }
}

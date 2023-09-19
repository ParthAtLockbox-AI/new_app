import 'package:ipapi/model/create_talk_res_model.dart';
import 'package:ipapi/service/api_service/api_const.dart';
import 'package:ipapi/service/api_service/base_services.dart';

class CreateTalkRepo {
  static Future<CreateTalkResponseModel> createTalkRepo(
      {required Map<String, dynamic> body}) async {
    var response = await APIService().getResponse(
        url: '${BaseUrl.chatBaseUrl}/talks',
        apiType: APIType.aPost,
        body: body);
    CreateTalkResponseModel createTalkResponseModel =
        CreateTalkResponseModel.fromJson(response);
    return createTalkResponseModel;
  }
}

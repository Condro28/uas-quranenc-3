import 'package:get/get.dart';
import 'package:uas_quranenc_3/models/translation_model.dart';
import 'package:uas_quranenc_3/service/service.dart';

class TranslationController extends GetxController {

  TranslationModel? datas;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      var response = await MainService().getTranslation();
      Get.log(response.body.toString());
      if (response.statusCode == 200) {
        datas = TranslationModel.fromJson(response.body);
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}

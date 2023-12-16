import 'package:get/get.dart';
import 'package:uas_quranenc_3/models/Sura_model.dart';
import 'package:uas_quranenc_3/service/service.dart';

class SuraController extends GetxController {

  SuraModel? datas;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  void fetchData(String translationKey, String nomorSura) async {
    try {
      var response = await MainService().getSura(translationKey, nomorSura);
      Get.log(response.body.toString());
      if (response.statusCode == 200) {
        datas = SuraModel.fromJson(response.body);
        isLoading.value = false;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}

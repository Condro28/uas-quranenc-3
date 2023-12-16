import 'package:get/get.dart';

class MainService extends GetConnect {
  Future<Response> getTranslation() => get('https://quranenc.com/api/v1/translations/list');
  Future<Response> getSura(String key, String nomorSura) => get('https://quranenc.com/api/v1/translation/sura/$key/$nomorSura');
}
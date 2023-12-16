class TranslationModel {
  List<Translations>? translations;

  TranslationModel({this.translations});

  TranslationModel.fromJson(Map<String, dynamic> json) {
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  String? key;
  String? languageIsoCode;
  String? version;
  int? lastUpdate;
  String? title;
  String? description;

  Translations(
      {this.key,
      this.languageIsoCode,
      this.version,
      this.lastUpdate,
      this.title,
      this.description});

  Translations.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    languageIsoCode = json['language_iso_code'];
    version = json['version'];
    lastUpdate = json['last_update'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['language_iso_code'] = this.languageIsoCode;
    data['version'] = this.version;
    data['last_update'] = this.lastUpdate;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

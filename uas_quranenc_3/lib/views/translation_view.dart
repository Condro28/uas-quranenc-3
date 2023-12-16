import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_quranenc_3/constant.dart';
import 'package:uas_quranenc_3/controllers/translation_controller.dart';
import 'package:uas_quranenc_3/views/home_view.dart';
import 'package:uas_quranenc_3/views/sura_view.dart';

class TranslationView extends StatelessWidget {
  final String nomor;
  final String nama;
  final String namaLatin;
  final String tempatTurun;
  final String jumlahAyat;
  final String arti;
  final TranslationController controller = Get.put(TranslationController()); // Tentukan tinggi setiap Card di sini

  TranslationView({super.key, required this.nomor, required this.nama, required this.namaLatin, required this.tempatTurun, required this.jumlahAyat, required this.arti});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: (() => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomeView()
                ),
              )),
              icon: const Icon(CupertinoIcons.bars, color: Color(0xFFA19CC5)),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Bahasa Terjemahan',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold, color: primary),
            ),
          ],
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.datas!.translations!.length,
                itemBuilder: (context, index) {
                  var translation = controller.datas!.translations![index];
                  return InkWell(
                    onTap:
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SuraView(
                          nomor: nomor,
                          nama: nama,
                          namaLatin: namaLatin,
                          tempatTurun: tempatTurun,
                          jumlahAyat: jumlahAyat,
                          arti: arti,
                          translationKey: translation.key!,
                        ),
                      ));
                    },
                    child: Card(
                      color: background,
                      elevation: 4,
                      margin: const EdgeInsets.all(15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [ 
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    translation.title!,
                                    style: GoogleFonts.poppins(
                                      color: primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        translation.languageIsoCode!,
                                        style: GoogleFonts.poppins(
                                          color: text,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: text,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        translation.key!,
                                        style: GoogleFonts.poppins(
                                          color: text,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(3),
                                          color: text,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'ver: ${translation.version}',
                                        style: GoogleFonts.poppins(
                                          color: text,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        )
                      ),
                    )
                  );
                },
              ),
      ),
    );
  }
}

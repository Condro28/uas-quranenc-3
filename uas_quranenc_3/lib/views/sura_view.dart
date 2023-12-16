import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_quranenc_3/constant.dart';
import 'package:uas_quranenc_3/controllers/sura_controller.dart';
import 'package:uas_quranenc_3/views/home_view.dart';
import 'package:uas_quranenc_3/views/translation_view.dart';

class SuraView extends StatelessWidget {
  final String translationKey;
  final String nomor;
  final String nama;
  final String namaLatin;
  final String tempatTurun;
  final String jumlahAyat;
  final String arti;
  final SuraController controller = Get.put(SuraController());

  SuraView({super.key, required this.nomor, required this.nama, required this.namaLatin, required this.tempatTurun, required this.jumlahAyat, required this.arti, required this.translationKey});

  @override
  Widget build(BuildContext context) {
    controller.fetchData(translationKey, nomor);
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
              namaLatin,
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold, color: primary),
            ),
            const Spacer(),
            IconButton(
              onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TranslationView(
                      nomor: nomor, 
                      nama: nama, 
                      namaLatin: namaLatin, 
                      tempatTurun: tempatTurun, 
                      jumlahAyat: jumlahAyat, 
                      arti: arti,
                    ),
              ))),
              icon: const Icon(CupertinoIcons.ellipsis_vertical, color: Color(0xFFA19CC5)),
            ),
          ],
        ),
      ),
      body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Stack(
                      children: [
                        Container(
                          height: 257,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                0, .6, 1
                              ],
                              colors: [
                                Color(0xFFDF98FA),
                                Color(0xFFB070FD),
                                Color(0xFF9055FF)
                              ]
                            )
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(28),
                          child: Column(
                            children: [
                              Text(
                                namaLatin,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                arti,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                ),
                              ),
                              Divider(
                                color: Colors.white.withOpacity(.35),
                                thickness: 2,
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tempatTurun,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$jumlahAyat Ayat",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Image.asset('assets/images/bismillah.png')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              body: Obx(
                () => controller.isLoading.value ?
                const Center(
                  child: CircularProgressIndicator(),
                ):
                ListView.builder(
                  itemCount: controller.datas!.result!.length,
                  itemBuilder: (context, index) {
                    var sura = controller.datas!.result![index];
                    return Card(
                      color: background,
                          margin: const EdgeInsets.all(15),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 16,
                                ),
                                Stack(
                                  children: [
                                    Image.asset('assets/images/nomorsurat.png'),
                                    Positioned.fill(
                                      child: Center(
                                        child: Text(
                                          sura.aya!,
                                          style: GoogleFonts.poppins(
                                            color: gray,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        sura.arabicText!,
                                        style: GoogleFonts.amiri(
                                          color: gray,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        sura.translation!,
                                        style: GoogleFonts.poppins(
                                          color: primary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        sura.footnotes!,
                                        style: GoogleFonts.poppins(
                                          color: text,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                )
              ),
      ),
    );
  }
}
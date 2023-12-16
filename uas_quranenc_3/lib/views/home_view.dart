import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_quranenc_3/constant.dart';
import 'package:uas_quranenc_3/models/list_sura_model.dart';
import 'package:uas_quranenc_3/views/sura_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              'Quran App',
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.bold, color: primary
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: loadSurahList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading data'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<ListSuraModel> surahList = snapshot.data as List<ListSuraModel>;

          return ListView.builder(
            itemCount: surahList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SuraView(
                      nomor: surahList[index].nomor.toString(),
                      nama: surahList[index].nama ?? '',
                      namaLatin: surahList[index].namaLatin ?? '',
                      tempatTurun: surahList[index].tempatTurun ?? '',
                      jumlahAyat: surahList[index].jumlahAyat.toString(),
                      arti: surahList[index].arti ?? '', 
                      translationKey: 'indonesian_sabiq',
                    ),
                  ));
                },
                child: Card(
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
                                  surahList[index].nomor.toString(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                surahList[index].namaLatin ?? '',
                                style: GoogleFonts.poppins(
                                  color: gray,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    surahList[index].tempatTurun ?? '',
                                    style: GoogleFonts.poppins(
                                      color: text,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
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
                                    "${surahList[index].jumlahAyat} Ayat",
                                    style: GoogleFonts.poppins(
                                      color: text,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        // Teks yang berada di dalam ikon
                        Text(
                          surahList[index].nama ?? '',
                          style: GoogleFonts.amiri(
                            color: primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  Future<List<ListSuraModel>> loadSurahList() async {
    String data = await rootBundle.loadString('assets/datas/list-surah.json');
    List<dynamic> jsonList = json.decode(data);
    List<ListSuraModel> surahList = [];
    for (var jsonItem in jsonList) {
      surahList.add(ListSuraModel.fromJson(jsonItem));
    }
    return surahList;
  }
}


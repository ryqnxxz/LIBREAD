import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libread_ryan/app/modules/home/controllers/home_controller.dart';
import 'package:libread_ryan/app/routes/app_pages.dart';

import '../../../data/model/response_book.dart';
import '../controllers/searchbook_controller.dart';

class SearchBookView extends GetView<SearchBookController> {
  const SearchBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getDataBook();
        },
        child: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(
                        height: height * 0.020
                    ),

                    TextFormField(
                      style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Search book here",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.020
                    ),

                    sectionTrendingBuku(),

                    SizedBox(
                        height: height * 0.030
                    ),

                    kontenSemuaBuku(),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget sectionTrendingBuku() {
    final width = MediaQuery.of(Get.context!).size.width;
    final widthContainer = width - 20.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Trending",
          style: GoogleFonts.amiko(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),

        GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.popularBooks.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            } else if (controller.popularBooks.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            }else {
              return SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.popularBooks.value!.map((buku) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAILBOOK,
                                parameters: {
                                  'id': (buku.bukuID ?? 0).toString(),
                                  'judul': (buku.judul!).toString(),
                                },
                              );
                            },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFF424242).withOpacity(0.60),
                                ),
                              height: 150,
                              width: MediaQuery.of(Get.context!).size.width,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    buku.coverBuku.toString(),
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          buku.judul!,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 24.0,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          buku.penulis!,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 14.0,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
              );
            }
          },
        ),
      ],
    );
  }

  Widget kontenSemuaBuku(){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Obx(() {
            if (controller.dataAllBook.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            } else if (controller.dataAllBook.value!.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            }else{
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.dataAllBook.value!.length,
                itemBuilder: (context, index){
                  var kategori = controller.dataAllBook.value![index].kategoriBuku;
                  var bukuList = controller.dataAllBook.value![index].dataBuku;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            kategori!,
                            style: GoogleFonts.inriaSans(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bukuList!.length,
                            itemBuilder: (context, index) {
                              DataBuku buku = bukuList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: (){
                                    Get.toNamed(
                                      Routes.DETAILBOOK,
                                      parameters: {
                                        'id': (buku.bukuID ?? 0).toString(),
                                        'judul': (buku.judul!).toString(),
                                      },
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 200,
                                        child: Image.network(
                                          buku.coverBuku.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            color: Color(0xFF5A5A5A),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Text(
                                                    buku.judul!,
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),

                                                FittedBox(
                                                  child: Text(
                                                    buku.penulis!,
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }
          )
        ],
      ),
    );
  }
}

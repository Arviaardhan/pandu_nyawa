import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandu_nyawa/screens/home_page/Controller/home_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pandu_nyawa/screens/home_page/component/footer.dart';
import 'package:pandu_nyawa/widgets/button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../widgets/drawer.dart';
import '../../../widgets/reusable_appbar.dart';
import '../../navigation_page/controller/navigator_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final NavigatorController controller = Get.find<NavigatorController>();
  HomeController homeController = Get.find<HomeController>();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFFFF5D7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppbarCustom(),
      ),
      endDrawer:DrawerCustom(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.05,),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'lib/assets/icons/img.png',
                            height: screenHeight * 0.05,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            'Panduan Modern Penyelamat Nyawa',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF26474C),
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.03,horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(()=> Expanded(
                                      child: CustomElevatedButton(
                                        height: screenHeight * 0.07,
                                        text: 'First Aid',
                                        buttonColor: homeController.currentindex.value == 0 ?  const Color(0xFFF9AF2A): Colors.white ,
                                        style: GoogleFonts.lexend(fontSize: 13, color:  homeController.currentindex.value == 0 ? Colors.white : Colors.black, fontWeight: FontWeight.w600),
                                        iconColor: homeController.currentindex.value == 0 ? Colors.white : const Color(0xFFF9AF2A),
                                        onPressed: () {
                                          homeController.carouselSliderController.animateToPage(0); // Jump to the second slide
                                        },icons: Icons.health_and_safety,
                                        bottomPadding: 5,
                                        isSvg: false,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Obx(() =>
                                      Expanded(
                                      child: CustomElevatedButton(
                                        height: screenHeight * 0.07,
                                        text: 'Identify',
                                        style: GoogleFonts.lexend(fontSize: 13, color:  homeController.currentindex.value == 1 ? Colors.white : Colors.black, fontWeight: FontWeight.w600),
                                        buttonColor: homeController.currentindex.value == 1 ?const Color(0xFF6750A4):Colors.white,
                                        iconColor: homeController.currentindex.value == 1 ?Colors.white: const Color(0xFF6750A4),
                                        onPressed: () {
                                          homeController.carouselSliderController.animateToPage(1); // Jump to the second slide
                                        }, icons: Icons.search,
                                        bottomPadding: 5,
                                        isSvg: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Expanded(
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300), // Adjust the duration as needed
                                      child: CustomElevatedButton(
                                        height: screenHeight * 0.07,
                                        style: GoogleFonts.lexend(
                                            fontSize: 13,
                                            color: homeController.currentindex.value == 2 ? Colors.white : Colors.black,
                                            fontWeight: FontWeight.w600
                                        ),
                                        text: 'Simulation',
                                        buttonColor: homeController.currentindex.value == 2 ? const Color(0xFF649DF6) : Colors.white,
                                        iconColor: homeController.currentindex.value == 2 ? Colors.white : const Color(0xFF649DF6),
                                        onPressed: () {
                                          homeController.carouselSliderController.animateToPage(2); // Jump to the second slide
                                        },isSvg: true,

                                        bottomPadding: 5,
                                      ),
                                    ),
                                  )),

                                  const SizedBox(
                                    width: 15,
                                  ),
                                  // Icon(Icons.shield),
                                  Obx((){
                                    return Expanded(child: CustomElevatedButton(
                                      height: screenHeight * 0.07,
                                      text: 'Emergency',
                                      style: GoogleFonts.lexend(fontSize: 13, color:  homeController.currentindex.value == 3 ?  Colors.white  : Colors.black, fontWeight: FontWeight.w600),
                                      buttonColor: homeController.currentindex.value == 3 ? const Color(0xFFB3261E) : Colors.white,
                                      iconColor:homeController.currentindex.value == 3 ?Colors.white: const Color(0xFFB3261E),
                                      onPressed: () {

                                        homeController.carouselSliderController.animateToPage(3); // Jump to the second slide
                                      },icons: Icons.warning_amber_rounded,
                                      isSvg: false,
                                      bottomPadding: 10,
                                    ),);
                                  })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height:screenHeight * 0.08,
                      ),
                    CarouselSlider(
                          carouselController: homeController.carouselSliderController,
                          options: CarouselOptions(
                            height: screenHeight * 0.4,
                            viewportFraction: 0.6,
                            enlargeCenterPage: true,
                            onPageChanged: (value, reason) {
                              homeController.currentindex.value = value;
                            },
                            // autoPlay: true,
                            // pauseAutoPlayOnManualNavigate:true,
                            // autoPlayInterval:   const Duration(seconds: 5),
                            // autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                            aspectRatio: 16 / 9,
                            enableInfiniteScroll: false,
                            // onPageChanged: (index, reason) {
                            //   homeController.currentindex.value = index;
                            //   print(homeController.currentindex.value);
                            // },
                          ),
                          items: [
                            InkWell(
                              onTap: () {
                                controller.currentIndex.value = 1;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF9AF2A),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset( 'lib/assets/images/FirstAid.png',
                                    fit: BoxFit.cover,),
                                )
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentIndex.value = 2;
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xFF649DF6),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset( 'lib/assets/images/identify.PNG',
                                      fit: BoxFit.cover,),
                                  )
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentIndex.value = 3;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFF649DF6),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset( 'lib/assets/images/Simulation.PNG',
                                    fit: BoxFit.cover,),
                                )
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.currentIndex.value = 4;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFB3261E),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset( 'lib/assets/images/Emergency.PNG',
                                    fit: BoxFit.cover,),
                                )
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                const Footer(colors: Colors.white, isImageRequired: true,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}


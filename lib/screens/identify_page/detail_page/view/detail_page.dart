import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pandu_nyawa/data/models/identify_model/identify_model.dart';
import 'package:pandu_nyawa/screens/emergency/view/emergency_page.dart';
import 'package:pandu_nyawa/screens/identify_page/detail_page/controller/detail_controller.dart';
import 'package:pandu_nyawa/screens/identify_page/quiz_page/view/quiz_view.dart';

import '../../../../widgets/drawer.dart';
import '../../../../widgets/reusable_appbar.dart';
import '../widget/button.dart';

class DetailIdentifyPage extends StatelessWidget {
  final IdentifyModel lukaModel;
  final String quizType;

  DetailIdentifyPage({Key? key, required this.lukaModel, required this.quizType}) : super(key: key);

  DetailIdentifyController detailIdentifyController = Get.put(DetailIdentifyController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      detailIdentifyController.setCurrentLukaModel(lukaModel);
      detailIdentifyController.currentPage.value = 0;
      detailIdentifyController.currentImageIndex.value = 0;
    });

    void navigateToSubBab(IdentifyModel newLukaModel) {
      detailIdentifyController.updateLukaModel(
        title: newLukaModel.title,
        bab: newLukaModel.bab,
        subBab: newLukaModel.subBab,
        steps: newLukaModel.steps,
        quizzes: newLukaModel.quizzes,
        imagePath: newLukaModel.imagePath,
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5D7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: AppbarCustom(),
      ),
      endDrawer: DrawerCustom(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Text(
              detailIdentifyController.lukaModel.value.bab,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w500,
              ),
            )),
            const SizedBox(height: 5),
            Obx(() => Text(
              detailIdentifyController.lukaModel.value.title,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            )),
            const SizedBox(height: 15),
            Container(
              width: screenWidth.toDouble(),
              height: screenHeight * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Obx(() {
                if (detailIdentifyController.lukaModel.value.imagePath.isNotEmpty) {
                  return Image.asset(detailIdentifyController.lukaModel.value.imagePath[detailIdentifyController.currentImageIndex.value]);
                } else {
                  return const SizedBox(); // Handle case where there are no images
                }
              }),
            ),
            //Heading
            const SizedBox(height: 20),

            //Body
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Obx(() {
                      // Get the current steps from the controller
                      List<String> currentSteps = detailIdentifyController.lukaModel.value.steps;

                      // Define page size and total steps
                      int pageSize = 4;
                      int totalSteps = currentSteps.length;
                      int currentPage = detailIdentifyController.currentPage.value;

                      // Calculate start and end indices for the current page
                      int startIndex = currentPage * pageSize;
                      int endIndex = (startIndex + pageSize) > totalSteps ? totalSteps : (startIndex + pageSize);

                      // Display the steps on the current page
                      List<String> stepsToDisplay = currentSteps.sublist(startIndex, endIndex);

                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF9D29),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), spreadRadius: 1, blurRadius: 3)],
                        ),
                        child: ListView(
                          padding: const EdgeInsets.all(8.0),
                          children: stepsToDisplay.map((step) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                              child: Text(step, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white)),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                  ),
                  // Previous Page Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      return detailIdentifyController.currentPage.value > 0
                          ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Colors.black),
                          onPressed: () {
                            detailIdentifyController.previousPage();
                          },
                        ),
                      )
                          : const SizedBox.shrink();
                    }),
                  ),
                  // Next Page Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() {
                      int totalSteps = detailIdentifyController.lukaModel.value.steps.length;
                      int pageSize = 4;
                      final isLastPage = detailIdentifyController.currentPage.value >= (totalSteps / pageSize).ceil() - 1;

                      return Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 24, color: Colors.black),
                          onPressed: () {
                            if (isLastPage) {
                              detailIdentifyController.nextSubBab(); // Final action when it's the last page
                            } else {
                              detailIdentifyController.nextPage();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Obx(() {
              int totalSteps = detailIdentifyController.lukaModel.value.steps.length;
              // Check if we're on the last page based on the steps length
              bool isLastPage = detailIdentifyController.currentPage.value == (totalSteps / 4).ceil() - 1;

              if (isLastPage) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: detailIdentifyController.lukaModel.value.quizzes.isNotEmpty
                            ? MainAxisAlignment.spaceEvenly
                            : MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return detailIdentifyController.lukaModel.value.quizzes.isNotEmpty
                                ? ElevatedButton(
                              onPressed: () {
                                Get.to(() => QuizIdentifyPage(quizzes: detailIdentifyController.lukaModel.value.quizzes));
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.black, width: 1.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                backgroundColor: const Color(0xFFFFF5D7),
                              ),
                              child: const Text('Test Simulasi', style: TextStyle(color: Colors.black)),
                            ) : const SizedBox(); // Use SizedBox.shrink() if there are no quizzes
                          }),

                          ElevatedButton(
                            onPressed: () {
                              Get.to(EmergencyPage());
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black, width: 1.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              backgroundColor: const Color(0xFFFFF5D7),
                            ),
                            child: const Text('Emergency', style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink(); // Hide the buttons if not on the last page
              }
            }),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_guardian/getX_controllers/detail-screen/weight_measure_controllers.dart';
import 'package:health_guardian/screens/detail-screens/weight_measure/weight_measure_graph.dart';
import 'package:health_guardian/screens/detail-screens/weight_measure/weight_measure_history_screen.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:health_guardian/widgets/buttons/detail_buttons.dart';

Widget dataWidgetWeightMeasure(WeightMeasureControllers controller,
    String value, String state, String type) {
  return Column(
    children: [
      Center(
        child: Text("Weight (kg)",
            style: TextStyle(
              fontSize: 29,
              color: Colors.black,
              fontFamily: "CoreSansBold",
            )),
      ),
      SizedBox(
        height: 8,
      ),
      Divider(
        color: Color.fromARGB(255, 229, 222, 222),
        thickness: 2,
      ),
      SizedBox(
        height: 10,
      ),

      //* For displaying graph and history
      Obx(() => controller.pageIndex.value == 0
          ? graphDataWeightMeasure(controller)
          : historyListWeightMeasure(controller, value, state, type, () {
              Get.to(() => WeightMeasureHistoryScreen(),
                  transition: Transition.rightToLeft);
            })),
    ],
  );
}

Widget graphDataWeightMeasure(WeightMeasureControllers controller) {
  return Column(children: [
    SizedBox(
      height: 0,
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
          onPressed: controller.previousPageDate,
          color: Colors.black,
        ),
        Text("Dec 16 - Dec 22, 2024",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontFamily: "Poppins-Med",
                fontWeight: FontWeight.bold)),
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 24,
          ),
          onPressed: controller.navigatePageDate,
          color: Colors.black,
        )
      ],
    ),
    SizedBox(
      height: 0,
    ),
    Container(
      color: Colors.white,
      height: 300,
      width: 410,
      child: PageView(
        controller: controller.pageController,
        children: [
          CustomBarChart(),
          CustomBarChart(),
        ],
      ),
    ),
  ]);
}

Widget historyListWeightMeasure(WeightMeasureControllers controller,
    String value, String state, String type, void Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      height: 350,
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              margin: EdgeInsets.symmetric(vertical: 8),
              height: 105,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 240, 237, 237)),
              child: Row(children: [
                Flexible(
                  flex: 2,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "75.6",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "CoreSansBold",
                                fontSize: 3.3 * SizeConfig.heightMultiplier),
                          ),
                          Text(
                            "kg",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 80, 78, 78),
                                fontFamily: "CoreSansMed",
                                fontSize: 2.1 * SizeConfig.heightMultiplier),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          height: 70,
                          child: VerticalDivider(
                            color: Color.fromARGB(255, 229, 222, 222),
                            thickness: 3,
                          )),
                    ],
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 3,
                          child: statsWidgetWeightMeasure(value, state, type)),
                      Flexible(
                          flex: 1,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: 28,
                          )),
                    ],
                  ),
                )
              ]),
            );
          }),
    ),
  );
}

Widget statsWidgetWeightMeasure(String value, String state, String type) {
  return Column(
    children: [
      Flexible(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buttonsDetail1(
                "Normal", () {}, Colors.green, Colors.white, 45, 100, 6, 19),
            Text(
              "BMI 21.6",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: "CoreSansBold",
                  fontSize: 2.2 * SizeConfig.heightMultiplier),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Flexible(
        flex: 1,
        child: Text(
          "Dec 22, 2024 : 10:54 AM",
          style: TextStyle(
              color: const Color.fromARGB(255, 80, 78, 78),
              fontFamily: "CoreSansMed",
              fontSize: 1.65 * SizeConfig.heightMultiplier),
        ),
      ),
    ],
  );
}

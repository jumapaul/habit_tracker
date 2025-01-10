import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/app/common/custom_theme/container_border_theme.dart';
import 'package:habit_tracker/app/common/dimens/dimens.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/models/activity_group.dart';
import '../controllers/stats_controller.dart';

class StatsView extends GetView<StatsController> {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StatsController>()) {
      Get.lazyPut(() => StatsController());
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reports'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Obx(() {
            var habits = controller.dailyActivityByCategory;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today, ${controller.currentDay}',
                        style: AppTextStyles.subHeaderStyle,
                      ),
                      _buildReportPeriod(),
                    ],
                  ),
                  AppTextStyles.mediumVerticalSpacing,
                  habits.isEmpty
                      ? Center(
                          child: Text(
                          'No reports yet',
                          style: AppTextStyles.largeSubHeaderStyle,
                        ))
                      : Column(
                          children: [
                            GridView.builder(
                              itemBuilder: (context, index) {
                                var category = habits[index];
                                return _buildCategoryReport(
                                    category.categoryIconUrl,
                                    category.category,
                                    category.totalDuration,
                                    context);
                              },
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10),
                              shrinkWrap: true,
                              itemCount: habits.length,
                            ),
                            AppTextStyles.mediumVerticalSpacing,
                            Text(
                              'Statistics',
                              style: AppTextStyles.largeSubHeaderStyle,
                            ),
                            AppTextStyles.mediumVerticalSpacing,
                            _buildDailyReportSection(
                                controller.dailyActivityByCategory),
                            AppTextStyles.mediumVerticalSpacing,
                            Text(
                              'Insights',
                              style: AppTextStyles.largeSubHeaderStyle,
                            ),
                            AppTextStyles.mediumVerticalSpacing,
                            _insightWidget(
                                'assets/images/happy.png',
                                'Best category',
                                controller.highestDurationCategoryName.value,
                                Colors.orangeAccent,
                                controller.highestDurationValue.value),
                            AppTextStyles.mediumVerticalSpacing,
                            _insightWidget(
                                'assets/images/sad.png',
                                'Worst category',
                                controller.lowestDurationCategoryName.value,
                                Colors.red.shade300,
                                controller.lowestDurationValue.value)
                          ],
                        )
                ],
              ),
            );
          }),
        ));
  }

  _buildCategoryReport(
      String imageUrl, category, duration, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Theme.of(context).extension<ContainerBorderTheme>()!.border),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 80, height: 80, child: Image.network(imageUrl)),
          Text(category),
          Text('$duration hours')
        ],
      ),
    );
  }

  _buildReportPeriod() {
    return DropdownButton<String>(
        value: controller.reportPeriod.value,
        icon: const Icon(Icons.arrow_drop_down_rounded),
        elevation: 0,
        iconSize: 24,
        underline: Container(),
        items: <String>['Monthly', 'Weekly', 'Daily']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue == 'Weekly') {
            controller.reportPeriod.value = newValue!;
            controller.getWeeklyReport();
          } else if (newValue == 'Monthly') {
            controller.getMonthlyReport();
          } else {
            controller.getDailyReport();
          }
        });
  }

  _buildDailyReportSection(List<ActivityGroup> group) {
    return Container(
      alignment: Alignment.center,
      width: 350,
      height: 250,
      child: SfCircularChart(
        legend: Legend(isVisible: true, position: LegendPosition.right),
        series: <CircularSeries>[
          DoughnutSeries<ActivityGroup, String>(
            dataSource: group,
            xValueMapper: (ActivityGroup data, _) => data.category,
            yValueMapper: (ActivityGroup data, _) => data.totalDuration,
            radius: '100%',
            strokeColor: Colors.white,
            strokeWidth: 2,
            explode: true,
          ),
        ],
      ),
    );
  }

  _insightWidget(String imagePath, title, category, Color color, int duration) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Image.asset(
            imagePath,
            color: color,
          ),
        ),
        AppTextStyles.mediumHorizontalSpacing,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.largeSubHeaderStyle,
            ),
            AppTextStyles.smallVerticalSpacing,
            Text(
              category,
              style: AppTextStyles.subHeaderStyle,
            )
          ],
        ),
        Spacer(),
        Text(
          '$duration hrs',
          style: AppTextStyles.largeSubHeaderStyle,
        )
      ],
    );
  }
}

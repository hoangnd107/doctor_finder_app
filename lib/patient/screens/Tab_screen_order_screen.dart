import 'package:flutter/material.dart';
import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/patient/screens/pharmacy_order_screen.dart';
import 'package:videocalling_medical/patient/utils/patient_imports.dart';

class TabScreenOrderScreen extends StatefulWidget {
  @override
  _TabScreenOrderScreenState createState() => _TabScreenOrderScreenState();
}

class _TabScreenOrderScreenState extends State<TabScreenOrderScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_tabController!.index == 1 && _tabController!.indexIsChanging) {
      print('Switched to PharmacyOrderScreen');

    }
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabChange);
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: MyTabBar(),
      ),
    );
  }
}

class MyHomePage1 extends StatelessWidget {
  final TabController? tabController;

  MyHomePage1({this.tabController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: 'all_appointment'.tr,
        ),
        leading: Container(),
        elevation: 0,
      ),
      body: Column(
        children: [

          Container(
            color: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 8), // Space between buttons

                Expanded(
                  child: InkWell(
                    onTap: () {
                      tabController?.animateTo(0);
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: tabController?.index == 0
                              ? AppColors.GREY
                              : Colors.transparent, // Change color for the active tab
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Text('all_appointment'.tr),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8), // Space between buttons

                Expanded(
                  child: InkWell(
                    onTap: () {
                      tabController?.animateTo(1);

                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: tabController?.index == 1
                              ? AppColors.GREY
                              : Colors.transparent, // Change color for the active tab
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Text('pharmacy_order'.tr),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 8), // Space between buttons
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                UserPastAppointmentsScreen(),
                PharmacyOrderScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with SingleTickerProviderStateMixin {
  TabController? tabController;
  UserPastAppointmentsController userPastAppointmentsController = UserPastAppointmentsController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: AppBar(
        flexibleSpace: CustomAppBar(
          title: 'all_appointment1'.tr,
        ),
        leading: Container(),
        elevation: 0,
      ),

    backgroundColor: AppColors.LIGHT_GREY_SCREEN_BACKGROUND,
    body:   Column(
      children: [
        SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 8),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30),),
              color: AppColors.WHITE
            ),
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        tabController?.animateTo(0);
                      });
                    },
                    child: Container(
                      width: Get.width,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                          [
                            tabController?.index == 0?
                            AppColors.color1 : Colors.transparent,
                            tabController?.index == 0?
                            AppColors.color2 :Colors.transparent,
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Center(
                        child: Text('all_appointment'.tr,
                          style: TextStyle(
                            fontFamily: AppFontStyleTextStrings.medium,
                              fontSize: 16,

                            color:             tabController?.index == 0
                                ?  AppColors.WHITE
                                : AppColors.grey
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(width: 8), // Space between buttons
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        tabController?.animateTo(1);
                        userPastAppointmentsController.fetchPharmacyorder();
                        userPastAppointmentsController.update();
                      });
                    },
                    child: Center(
                      child: Container(
                        width: Get.width,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:
                            [
                              tabController?.index == 1?
                              AppColors.color1 : Colors.transparent,
                              tabController?.index == 1?
                              AppColors.color2 :Colors.transparent,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Center(
                          child: Text('pharmacy_order'.tr,
                            style: TextStyle(
                                fontFamily: AppFontStyleTextStrings.medium,
fontSize: 16,
                              color:
                              tabController?.index == 1
                                  ?  AppColors.WHITE
                                  : AppColors.grey

                            ),),
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              UserPastAppointmentsScreen(),
              PharmacyOrderScreen(),
            ],
          ),
        ),

      ],
    ),
    );

  }
}


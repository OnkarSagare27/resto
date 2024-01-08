import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:resto/providers/home_provider.dart';
import 'package:resto/screens/all_tab.dart';
import 'package:resto/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = [
    '',
    "Pizza",
    "Nonveg",
    "Veg",
    "Burger",
  ];

  List<Widget> tabs = [
    const AllTab(),
  ];

  List<Widget> icons = [
    const Text('All'),
    Image.asset(
      'assets/pizza.png',
      width: 27.w,
    ),
    Image.asset(
      'assets/nonveg.png',
      width: 27.w,
    ),
    Image.asset(
      'assets/veg.png',
      width: 27.w,
    ),
    Image.asset(
      'assets/burger.png',
      width: 27.w,
    ),
  ];
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .getCurrentLocationDetails();
  }

  TextEditingController cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProviderModel, child) => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Color(0xffFFE1E1),
            Colors.white,
          ],
        )),
        child: homeProviderModel.currentLocationModel == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFF5858),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_sharp,
                        color: Colors.black,
                        size: ScreenUtil().setWidth(19),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Text(
                        '${homeProviderModel.currentLocationModel!.subloc!}, ${homeProviderModel.currentLocationModel!.city}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
                // Body
                body: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7.w),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: items.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h),
                              child: GestureDetector(
                                onTap: () {
                                  homeProviderModel.setCurrentTabInd(index);
                                  homeProviderModel.homePageTagController
                                      .animateToPage(
                                    homeProviderModel.currentTabInd,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.ease,
                                  );
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.only(left: 9.w),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        blurRadius: 8,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                    color:
                                        homeProviderModel.currentTabInd == index
                                            ? const Color(0xFFFF5858)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 16.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          icons[index],
                                          homeProviderModel.currentTabInd ==
                                                  index
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 6.w),
                                                  child: Text(
                                                    items[index],
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFFFFFFFF),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 16.w),
                      child: SizedBox(
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: SearchField(
                            onChanged: (value) =>
                                homeProviderModel.filterRestos(value),
                            controller: cont,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, bottom: 16.h),
                      child: Row(
                        children: [
                          Text(
                            'Nearby Restaurants',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF000000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        itemCount: icons.length,
                        controller: homeProviderModel.homePageTagController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return tabs[0];
                        },
                      ),
                    ),
                  ],
                ),
                // Bottom navigation bar
                bottomNavigationBar: BottomNavigationBar(
                  onTap: (value) =>
                      homeProviderModel.setCurrentScreenInd(value),
                  currentIndex: homeProviderModel.currentScreenInd,
                  selectedLabelStyle: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFC90000),
                  ),
                  fixedColor: const Color(0xFFC90000),
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/home.png',
                        height: 20.h,
                        width: 20.w,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/tab_2.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                      label: 'Explore',
                    ),
                    const BottomNavigationBarItem(
                      icon: SizedBox(),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/bookmarks.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                      label: 'Bookmarks',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/account.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                      label: 'Account',
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  backgroundColor: const Color(0xFFC90000),
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: () => debugPrint('Pressed'),
                  child: Image.asset(
                    'assets/scan.png',
                    height: 44.h,
                    width: 44.w,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              ),
      ),
    );
  }
}

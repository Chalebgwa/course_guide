import 'package:course_guide/views/onboarding/page1.dart';
import 'package:course_guide/views/onboarding/page2.dart';
import 'package:course_guide/views/onboarding/page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
// import dot indicator

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  // navigate to the next page
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _currentPage++;
    });
  }

  // navigate to the previous page

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      _currentPage = _currentPage - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: const [
                Page1(),
                Page2(),
                Page3(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _currentPage == 2
                  ? buildStartButton()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.05.sh,
                            right: 0.05.sw,
                          ),
                          child: TextButton(
                            onPressed: _nextPage,
                            child: Text(
                              'Skip',
                              style: GoogleFonts.archivo(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        // three dots indicator
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.05.sh,
                            right: 0.05.sw,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _currentPage == 0
                                        ? Colors.white
                                        : Colors.white.withOpacity(.5),
                                  ),
                                  color: _currentPage == 0
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _currentPage == 1
                                        ? Colors.white
                                        : Colors.white.withOpacity(.5),
                                  ),
                                  color: _currentPage == 1
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _currentPage == 2
                                        ? Colors.white
                                        : Colors.white.withOpacity(.5),
                                  ),
                                  color: _currentPage == 2
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 0.05.sh,
                            right: 0.05.sw,
                          ),
                          child: TextButton(
                            onPressed: _nextPage,
                            child: Text(
                              'Next',
                              style: GoogleFonts.archivo(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStartButton() {
    return GestureDetector(
      onTap: () => context.go('/landing'),
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 83.h,
        decoration: BoxDecoration(
          color: HexColor("#40A49C"),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Text(
          "Let's Start",
          style: GoogleFonts.archivo(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

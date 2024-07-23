import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';
import 'package:qoriqlash_xizmati/front/pages/home_page.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_four.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_one.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_second.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_third.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';
import 'package:qoriqlash_xizmati/front/style/app_style.dart';

class ArizaTexnikObyekt extends StatelessWidget {
  const ArizaTexnikObyekt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          MiniRedAppBar(),
          MiniRedTitle(title: 'Arizani Rasmiylashtirish'),
          Expanded(child: ArizaStep())
        ],
      ),
    ));
  }
}

class ArizaStep extends StatelessWidget {
  const ArizaStep({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiStepForm();
  }
}

class MultiStepForm extends StatefulWidget {
  const MultiStepForm({super.key});

  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                BuildStep1Page(),
                BuildStep2Page(),
                BuildStep3Page(),
                BuildStep4Page(),
              ],
            ),
          ),
          _currentStep < 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: AppColors.lightIconGuardColor,
                        backgroundColor: Colors.white, // Text color
                        side: BorderSide(
                            color: AppColors.lightIconGuardColor,
                            width: 2), // Border color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14), // Rounded corners
                        ),
                      ),
                      onPressed: _currentStep > 0 ? _previousStep : null,
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back,
                              color: AppColors.lightIconGuardColor),
                          SizedBox(width: 4),
                          Text('Oldingisi'),
                        ],
                      ),
                    ),
                    SizedBox(width: 16), // Space between buttons
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            AppColors.lightIconGuardColor, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14), // Rounded corners
                        ),
                      ),
                      onPressed: _currentStep < 3 ? _nextStep : null,
                      child: Row(
                        children: [
                          Text('Keyingisi'),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

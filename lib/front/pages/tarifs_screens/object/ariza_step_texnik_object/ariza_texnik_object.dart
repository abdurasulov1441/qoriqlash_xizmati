import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';

import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_four.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_one.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_second.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_third.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class ArizaTexnikObyekt extends StatelessWidget {
  const ArizaTexnikObyekt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Arizani Rasmiylashtirish'),
            Expanded(child: ArizaStep()),
          ],
        ),
      ),
    );
  }
}

class ArizaStep extends StatelessWidget {
  const ArizaStep({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultiStepForm();
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(
            'assets/images/step${_currentStep + 1}.svg', // Dynamically load SVG based on _currentStep
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
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
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: AppColors.lightIconGuardColor, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _currentStep > 0 ? _previousStep : null,
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,
                            color: AppColors.lightIconGuardColor),
                        const SizedBox(width: 4),
                        const Text('Oldingisi'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.lightIconGuardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _currentStep < 3 ? _nextStep : null,
                    child: Row(
                      children: const [
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
    );
  }
}

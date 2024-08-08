import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qoriqlash_xizmati/back/api/FormData.dart';

import 'package:qoriqlash_xizmati/front/components/mini_red_app_bar.dart';

import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_four.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_one.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_second.dart';
import 'package:qoriqlash_xizmati/front/pages/tarifs_screens/object/ariza_step_texnik_object/step_third.dart';
import 'package:qoriqlash_xizmati/front/style/app_colors.dart';

class ArizaTexnikObyekt extends StatelessWidget {
  final String? selectedObjectType;
  final String? selectedGuardType;
  final String? motionWorkDaysStartTime;
  final String? motionWorkDaysEndTime;
  final String? motionWeekendStartTime;
  final String? motionWeekendEndTime;
  final String? motionHolidayStartTime;
  final String? motionHolidayEndTime;
  final String? alarmWorkDaysStartTime;
  final String? alarmWorkDaysEndTime;
  final String? alarmWeekendStartTime;
  final String? alarmWeekendEndTime;
  final String? alarmHolidayStartTime;
  final String? alarmHolidayEndTime;

  const ArizaTexnikObyekt({
    Key? key,
    this.selectedObjectType,
    this.selectedGuardType,
    this.motionWorkDaysStartTime,
    this.motionWorkDaysEndTime,
    this.motionWeekendStartTime,
    this.motionWeekendEndTime,
    this.motionHolidayStartTime,
    this.motionHolidayEndTime,
    this.alarmWorkDaysStartTime,
    this.alarmWorkDaysEndTime,
    this.alarmWeekendStartTime,
    this.alarmWeekendEndTime,
    this.alarmHolidayStartTime,
    this.alarmHolidayEndTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            MiniRedAppBar(),
            MiniRedTitle(title: 'Arizani Rasmiylashtirish'),
            Expanded(
              child: MultiStepForm(
                motionWorkDaysStartTime: motionWorkDaysStartTime,
                motionWorkDaysEndTime: motionWorkDaysEndTime,
                motionWeekendStartTime: motionWeekendStartTime,
                motionWeekendEndTime: motionWeekendEndTime,
                motionHolidayStartTime: motionHolidayStartTime,
                motionHolidayEndTime: motionHolidayEndTime,
                alarmWorkDaysStartTime: alarmWorkDaysStartTime,
                alarmWorkDaysEndTime: alarmWorkDaysEndTime,
                alarmWeekendStartTime: alarmWeekendStartTime,
                alarmWeekendEndTime: alarmWeekendEndTime,
                alarmHolidayStartTime: alarmHolidayStartTime,
                alarmHolidayEndTime: alarmHolidayEndTime,
                selectedGuardType: selectedGuardType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiStepForm extends StatefulWidget {
  final String? motionWorkDaysStartTime;
  final String? motionWorkDaysEndTime;
  final String? motionWeekendStartTime;
  final String? motionWeekendEndTime;
  final String? motionHolidayStartTime;
  final String? motionHolidayEndTime;

  final String? alarmWorkDaysStartTime;
  final String? alarmWorkDaysEndTime;
  final String? alarmWeekendStartTime;
  final String? alarmWeekendEndTime;
  final String? alarmHolidayStartTime;
  final String? alarmHolidayEndTime;
  final String? selectedGuardType;

  const MultiStepForm({
    Key? key,
    this.motionWorkDaysStartTime,
    this.motionWorkDaysEndTime,
    this.motionWeekendStartTime,
    this.motionWeekendEndTime,
    this.motionHolidayStartTime,
    this.motionHolidayEndTime,
    this.alarmWorkDaysStartTime,
    this.alarmWorkDaysEndTime,
    this.alarmWeekendStartTime,
    this.alarmWeekendEndTime,
    this.alarmHolidayStartTime,
    this.alarmHolidayEndTime,
    this.selectedGuardType,
  }) : super(key: key);

  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  FormData _formData = FormData();

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

  void _updateFormData(FormData newData) {
    setState(() {
      _formData = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(
            'assets/images/step${_currentStep + 1}.svg',
            width: 50,
            height: 50,
          ),
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BuildStep1Page(
                formData: _formData,
                onUpdateFormData: _updateFormData,
              ),
              BuildStep2Page(
                formData: _formData,
                onUpdateFormData: _updateFormData,
                motionWorkDaysStartTime: widget.motionWorkDaysStartTime,
                motionWorkDaysEndTime: widget.motionWorkDaysEndTime,
                motionWeekendStartTime: widget.motionWeekendStartTime,
                motionWeekendEndTime: widget.motionWeekendEndTime,
                motionHolidayStartTime: widget.motionHolidayStartTime,
                motionHolidayEndTime: widget.motionHolidayEndTime,
                alarmWorkDaysStartTime: widget.alarmWorkDaysStartTime,
                alarmWorkDaysEndTime: widget.alarmWorkDaysEndTime,
                alarmWeekendStartTime: widget.alarmWeekendStartTime,
                alarmWeekendEndTime: widget.alarmWeekendEndTime,
                alarmHolidayStartTime: widget.alarmHolidayStartTime,
                alarmHolidayEndTime: widget.alarmHolidayEndTime,
                selectedGuardType:
                    widget.selectedGuardType, // Pass the type here
              ),
              BuildStep3Page(),
              const BuildStep4Page(),
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

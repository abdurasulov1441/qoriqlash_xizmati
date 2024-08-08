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
  final String? obyektTuri;
  final String? qoriqlashVositasi;
  final Map<String, TimeOfDay>? qoriqlashVaqtlari;

  const ArizaTexnikObyekt({
    Key? key,
    this.obyektTuri,
    this.qoriqlashVositasi,
    this.qoriqlashVaqtlari,
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
                obyektTuri: obyektTuri,
                qoriqlashVositasi: qoriqlashVositasi,
                qoriqlashVaqtlari: qoriqlashVaqtlari,
              ),
            ),
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
  final String? obyektTuri;
  final String? qoriqlashVositasi;
  final Map<String, TimeOfDay>? qoriqlashVaqtlari;

  const MultiStepForm({
    Key? key,
    this.obyektTuri,
    this.qoriqlashVositasi,
    this.qoriqlashVaqtlari,
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
              ),
              BuildStep3Page(
                obyektTuri: widget.obyektTuri,
                qoriqlashVositasi: widget.qoriqlashVositasi,
                qoriqlashVaqtlari: widget.qoriqlashVaqtlari,
              ),
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

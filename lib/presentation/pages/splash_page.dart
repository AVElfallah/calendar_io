import 'package:action_slider/action_slider.dart';
import 'package:calendar_io/assets/assets_manager.dart';
import 'package:flutter/material.dart';

import '../../app/routes/routes_names.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        //[START TOP SECTION]
        Align(
          alignment: Alignment.topLeft,
          child: Image(
            image: const AssetImage(AssetsManager.logoImage),
            height: height * .18,
            width: height * .2,
          ),
        ),

        const Text('welcome to calendar.io'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'It\'S Time to Organize your Day!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),

        //[END TOP SECTION]
        const Spacer(),

        //[START BOTTOM SECTION]
        Container(
          height: height * .585,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetsManager.racoonImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  AssetsManager.pathImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: ActionSlider.standard(
                      backgroundColor: Colors.transparent,
                      height: 70,
                      width: 280,
                      rolling: true,
                      toggleColor: Colors.white,
                      successIcon: const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.check,
                          color: Colors.black,
                        ),
                      ),
                      action: (controller) {
                        controller.success();
                        Future.delayed(const Duration(milliseconds: 700), () {
                          Navigator.pushNamed(context, RoutesNames.calendar);
                        });
                      },
                      onTap: (controller, value) {
                        controller.jump(value);

                        //
                        // Navigator.pushNamed(context, RoutesNames.calendar);
                      },
                      icon: const RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )

        //[END BOTTOM SECTION]
      ],
    ));
  }
}

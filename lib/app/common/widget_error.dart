import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WidgetError extends StatelessWidget {
  final Future<dynamic> Function() onReload;
  final String error;

  const WidgetError({super.key, required this.onReload, required this.error});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Transform.rotate(
                angle: 0.4,
                child: Image.asset(
                  'assets/images/pokeball.png',
                  height: 100,
                ),
              ),
              const Positioned(
                right: 0,
                child: Icon(
                  Icons.error_rounded,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            error,
            style: const TextStyle(
              fontFamily: 'Google',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
              backgroundColor: WidgetStateProperty.all(Get.theme.primaryColor),
            ),
            onPressed: () async => {await onReload()},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30),
              child: Text(
                'Reload',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Google',
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

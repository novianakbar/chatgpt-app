import 'package:ChatGPT/constants/constants.dart';
import 'package:ChatGPT/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/widgets/drop_down.dart';
import 'package:ChatGPT/widgets/memory_switch.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        backgroundColor: scaffoldBackgroundColor,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Flexible(
                        child: TextWidget(
                          label: "Chosen Model:",
                          fontSize: 16,
                        ),
                      ),
                      Flexible(flex: 2, child: ModelsDropDownWidget())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Flexible(
                        flex: 3,
                        child: TextWidget(
                          label: "Memory (consumes lots of tokens):",
                          fontSize: 16,
                        ),
                      ),
                      Flexible(flex: 1, child: MemorySwitch()),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

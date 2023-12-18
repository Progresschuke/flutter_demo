import 'package:flutter/material.dart';

import '../widgets/dropdown.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModelSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      backgroundColor: Colors.black,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                label: 'Chat Model:',
                color: Colors.white,
              ),
              DropdownModels()
              // Expanded(child: DropdownModels()),
              // Expanded(child: TextWidget(label: 'Chat Model:')),
            ],
          ),
        );
      },
    );
  }
}

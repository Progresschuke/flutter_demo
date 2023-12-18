import 'package:chat_gpt_clone/constants/app_colors.dart';
import 'package:chat_gpt_clone/services/assets_manager.dart';
import 'package:chat_gpt_clone/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  final String msg;
  final double chatIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(
      color: chatIndex == 0 ? AppColors.scaffoldBgColor : AppColors.cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.02,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              chatIndex == 0 ? AssetsManager.chatLogo : AssetsManager.userChat,
              width: size.width * 0.1,
              height: size.height * 0.05,
            ),
            SizedBox(width: size.width * 0.03),
            TextWidget(
              label: msg,
              color: Colors.white,
            ),
            if (chatIndex == 0)
              const Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined, color: Colors.white),
                  Icon(
                    Icons.thumb_down_alt_outlined,
                    color: Colors.white,
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

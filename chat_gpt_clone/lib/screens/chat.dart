import 'package:chat_gpt_clone/constants/dummy_data.dart';
import 'package:chat_gpt_clone/services/assets_manager.dart';
import 'package:chat_gpt_clone/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_colors.dart';
import '../widgets/chat_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  bool isTyping = true;

  void showModels() async {
    await Services.showModelSheet(context: context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardColor,
        elevation: 2,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
          child: Image.asset(
            AssetsManager.appLogo,
          ),
        ),
        title: const Text('New chat'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: showModels, icon: const Icon(Icons.more_vert_outlined))
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: dummyChat.length,
              itemBuilder: (context, index) {
                return ChatCard(
                  chatIndex:
                      double.parse(dummyChat[index]['chatIndex'].toString()),
                  msg: dummyChat[index]['msg'].toString(),
                );
              },
            ),
          ),
          if (isTyping) ...[
            const SpinKitThreeBounce(
              color: Colors.white,
              size: 16,
            )
          ],
          userInputForm(),
        ],
      ),
    );
  }

  //custom chat messages input
  Widget userInputForm() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.0),
      child: Material(
        color: AppColors.cardColor,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                textCapitalization: TextCapitalization.sentences,
                controller: messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintText: 'Message ChatGPT...',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}

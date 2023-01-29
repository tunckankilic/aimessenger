import '/constants.dart';
import '/service/service.dart';
import '/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("ChatGPT"),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(AssetsManager.openAiLogo),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalBottomSheetWidget(context);
            },
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                          msg: chatMessages[index]["msg"].toString(),
                          chatIndex: int.parse(
                              chatMessages[index]["chatIndex"].toString()));
                    })),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          controller: textEditingController,
                          onSubmitted: (value) {},
                          decoration: InputDecoration.collapsed(
                            hintText: "How Can I Help You?",
                            hintStyle: TextStyle(
                              color: Colors.green[200],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {},
                        icon: Icon(
                          Icons.send,
                          color: Colors.green[200]!,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
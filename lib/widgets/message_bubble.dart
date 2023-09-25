import 'package:flutter/material.dart';
import 'package:sgm_du_gu_we/constants/elevated_button.dart';

import '../constants/box_decoration.dart';
import '../constants/color.dart';
import '../constants/padding.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
        required this.sender,
        required this.text,
        required this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        kPadding - 10.0,
      ),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
              topLeft: Radius.circular(
                kBorderRadiusMessageBubble,
              ),
              bottomLeft: Radius.circular(
                kBorderRadiusMessageBubble,
              ),
              bottomRight: Radius.circular(
                kBorderRadiusMessageBubble,
              ),
            )
                : const BorderRadius.only(
              bottomLeft: Radius.circular(
                kBorderRadiusMessageBubble,
              ),
              bottomRight: Radius.circular(
                kBorderRadiusMessageBubble,
              ),
              topRight: Radius.circular(
                kBorderRadiusMessageBubble,
              ),
            ),
            elevation: kElevation,
            color: isMe ? kSGMColorBlue : kSGMColorRed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kPaddingMessageBubbleVertical,
                horizontal: kPaddingMessageBubbleHorizontal,
              ),
              child: Text(
                text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

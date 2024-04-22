import 'dart:async';

import 'package:flutter/material.dart';

import 'package:fluffychat/config/app_config.dart';
import 'package:fluffychat/config/themes.dart';
import 'package:fluffychat/pages/chat/chat.dart';
import 'package:fluffychat/widgets/avatar.dart';
import 'package:fluffychat/widgets/matrix.dart';

class TypingIndicators extends StatelessWidget {
  final ChatController controller;
  const TypingIndicators(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final typingUsers = controller.room.typingUsers
      ..removeWhere((u) => u.stateKey == Matrix.of(context).client.userID);
    const topPadding = 20.0;
    const bottomPadding = 4.0;

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: AnimatedContainer(
        constraints:
            const BoxConstraints(maxWidth: FluffyThemes.columnWidth * 2.5),
        height: typingUsers.isEmpty ? 0 : Avatar.defaultSize + bottomPadding,
        duration: FluffyThemes.animationDuration,
        curve: FluffyThemes.animationCurve,
        alignment: controller.timeline!.events.isNotEmpty &&
                controller.timeline!.events.first.senderId ==
                    Matrix.of(context).client.userID
            ? Alignment.topRight
            : Alignment.topLeft,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.only(
          left: 8.0,
          bottom: bottomPadding,
        ),
        child: Row(
          children: [
            SizedBox(
              height: Avatar.defaultSize,
              width: typingUsers.length < 2
                  ? Avatar.defaultSize
                  : Avatar.defaultSize + 16,
              child: Stack(
                children: [
                  if (typingUsers.isNotEmpty)
                    Avatar(
                      mxContent: typingUsers.first.avatarUrl,
                      name: typingUsers.first.calcDisplayname(),
                    ),
                  if (typingUsers.length == 2)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Avatar(
                        mxContent: typingUsers.length == 2
                            ? typingUsers.last.avatarUrl
                            : null,
                        name: typingUsers.length == 2
                            ? typingUsers.last.calcDisplayname()
                            : '+${typingUsers.length - 1}',
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: topPadding),
              child: Material(
                // color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                  bottomRight: Radius.circular(2),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: typingUsers.isEmpty ? null : const _TypingDots(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => __TypingDotsState();
}

class __TypingDotsState extends State<_TypingDots> {
  int _tick = 0;

  static const Duration animationDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const size = 8.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 3; i++)
          AnimatedContainer(
            duration: animationDuration * 1.5,
            curve: FluffyThemes.animationCurve,
            width: size,
            height: _tick == i ? size * 2 : size,
            margin: EdgeInsets.symmetric(
              horizontal: 2,
              vertical: _tick == i ? 4 : 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 2),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
      ],
    );
  }
}

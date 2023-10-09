import 'package:flopps/screens/ia/widgets/chatMessage.dart';
import 'package:flopps/screens/ia/widgets/sender.dart';
import 'package:flutter/material.dart';

class IaScreen extends StatefulWidget {
  const IaScreen({super.key});

  @override
  State<IaScreen> createState() => _IaScreenState();
}

class _IaScreenState extends State<IaScreen>
    with AutomaticKeepAliveClientMixin<IaScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      verticalDirection: VerticalDirection.up,
      children: [
       const SenderWidget(),
        Expanded(child: ListView.builder(
          controller: _scrollController,
          itemCount: 100,
          itemBuilder: (context, index) {
            return  MessageItem(isMe: index.isEven);

          },
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

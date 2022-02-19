import 'package:flutter/material.dart';

class PageItem extends StatefulWidget {
  final int index;
  const PageItem(this.index, {Key? key}) : super(key: key);

  @override
  _PageItemState createState() => _PageItemState();
}

class _PageItemState extends State<PageItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(

      child: Text('index:${widget.index}'),
      alignment: Alignment.center,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
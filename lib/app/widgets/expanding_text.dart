import 'package:flutter/material.dart';

class ExpandingText extends StatefulWidget {
  final String content;
  final TextStyle style;
  final TextAlign textAlign;
  final int limit;

  ExpandingText(this.content, {
    Key key,
    this.style,
    this.textAlign,
    this.limit = 40
  }) : super(key: key);

  @override
  _ExpandingTextState createState() => _ExpandingTextState();
}

class _ExpandingTextState extends State<ExpandingText> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: RichText(
        textAlign: widget.textAlign ?? TextAlign.right,
        text: TextSpan(
          children: [
            TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 12).merge(widget.style),
              text: widget.content.length > widget.limit && !_showAll ?
                widget.content.substring(0, widget.limit) :
                widget.content
            ),
            widget.content.length <= widget.limit ? TextSpan() : WidgetSpan(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showAll = true;
                  });
                },
                child: Text(
                  _showAll ? '' : '...',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ),
            )
          ]
        )
      )
    );
  }
}

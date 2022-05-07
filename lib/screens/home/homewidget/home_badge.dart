import 'package:flutter/material.dart';
import 'package:flutter_pos_kawpun/utils/text_style.dart';

class HomeBadge extends StatelessWidget {
  const HomeBadge({
    Key? key,
    required this.child,
    required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 6,
          top: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color ?? Theme.of(context).primaryColor,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Center(
                child:
                    Text(value, textAlign: TextAlign.center, style: textBadge)),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  final double height;
  final Widget title;
  final Widget btnAction;
  final Widget child;
  final Color backgroundColor;

  BottomSheetWidget({
    this.height,
    this.title,
    this.btnAction,
    this.child,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      decoration: BoxDecoration(
        color:
            this.backgroundColor != null ? this.backgroundColor : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              this._buildHeaderModal(context),
              this.child != null ? this.child : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderModal(BuildContext context) {
    if (this.title == null && this.btnAction == null)
      return SizedBox.shrink();
    else
      return Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 8),
        child: Row(
          children: <Widget>[
            this.title != null
                ? Expanded(
                    child: this.title,
                  )
                : SizedBox.shrink(),
            this.btnAction != null ? this.btnAction : SizedBox.shrink()
          ],
        ),
      );
  }
}

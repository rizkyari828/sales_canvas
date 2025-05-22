import 'package:flutter/material.dart';

class CustomPopScope extends StatelessWidget {
  const CustomPopScope({
    required this.onWillPop,
    required this.child,
    super.key,
  });

  final Future<bool> Function() onWillPop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    bool usePopScope = true;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;

        onWillPop().then((canPop) {
          if (canPop && usePopScope) {
            usePopScope = false;
            // if (Navigator.canPop(context)) Navigator.pop(context);
          }
        });
      },
      child: child,
    );
  }
}

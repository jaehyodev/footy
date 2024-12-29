import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoaderOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayEntry = OverlayEntry(
        builder: (context) => const Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,
            size: 30.0,
          ),
        ),
      );

      Overlay.of(context).insert(_overlayEntry!);
    });
  }

  static void hide() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}

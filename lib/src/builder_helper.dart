import 'package:flutter/material.dart';
import 'log_overlay.dart';

/// Helper para usar no MaterialApp.builder garantindo Overlay ancestral.
Widget uniOverlayAppBuilder({
  required BuildContext context,
  required Widget? child,
  required bool isWeb,
  UniOverlayVisibility? visibility,
  double? webMaxWidth,
  bool wrapWithOverlay = true,
}) {
  Widget content = Stack(
    children: [
      child ?? const SizedBox.shrink(),
      UniOverlayPortal(visibility: visibility),
    ],
  );

  if (isWeb) {
    content = Container(
      color: const Color(0xFFF0F0F0),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: webMaxWidth ?? 500),
        child: ClipRRect(child: content),
      ),
    );
  }

  if (!wrapWithOverlay) return content;

  return Overlay(
    initialEntries: [OverlayEntry(builder: (_) => content)],
  );
}
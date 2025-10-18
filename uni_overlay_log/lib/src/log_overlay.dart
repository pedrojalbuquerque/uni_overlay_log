import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'log_service.dart';

class UniOverlayVisibility extends ChangeNotifier {
  bool _visible;
  UniOverlayVisibility({bool initial = true}) : _visible = initial;
  bool get visible => _visible;
  void toggle() { _visible = !_visible; notifyListeners(); }
  void show() { if (!_visible) { _visible = true; notifyListeners(); } }
  void hide() { if (_visible) { _visible = false; notifyListeners(); } }
}

class UniOverlayShortcuts extends StatelessWidget {
  final UniOverlayVisibility controller;
  final Widget child;
  const UniOverlayShortcuts({super.key, required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: const {
        LogicalKeySet(LogicalKeyboardKey.backquote): ActivateIntent(),
      },
      child: Actions(
        actions: {
          ActivateIntent: CallbackAction<Intent>(onInvoke: (_) {
            controller.toggle();
            return null;
          }),
        },
        child: Focus(
          autofocus: true,
          child: child,
        ),
      ),
    );
  }
}

class UniOverlayPortal extends StatefulWidget {
  final UniOverlayVisibility? visibility;
  const UniOverlayPortal({super.key, this.visibility});

  @override
  State<UniOverlayPortal> createState() => _UniOverlayPortalState();
}

class _UniOverlayPortalState extends State<UniOverlayPortal> {
  final _lines = <String>[];
  late final StreamSubscription<String> _sub;
  UniOverlayVisibility get _visibility =>
      widget.visibility ?? _internal;
  final _internal = UniOverlayVisibility(initial: true);

  @override
  void initState() {
    super.initState();
    _sub = UniOverlayLog.I.stream.listen((e) {
      if (!mounted) return;
      setState(() => _lines.add(e));
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _visibility,
      builder: (context, _) {
        if (!_visibility.visible) return const SizedBox.shrink();
        return Align(
          alignment: Alignment.bottomRight,
          child: DraggableScrollableSheet(
            initialChildSize: 0.22,
            minChildSize: 0.10,
            maxChildSize: 0.85,
            builder: (context, scrollController) {
              return Material(
                elevation: 16,
                color: Colors.black.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 8),
                        const Icon(Icons.terminal, color: Colors.white70),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text('Console',
                              style: TextStyle(color: Colors.white70)),
                        ),
                        IconButton(
                          tooltip: 'Copiar',
                          onPressed: () {
                            final all = _lines.join('\n');
                            Clipboard.setData(ClipboardData(text: all));
                          },
                          icon: const Icon(Icons.copy, color: Colors.white70),
                        ),
                        IconButton(
                          tooltip: 'Limpar',
                          onPressed: () => setState(_lines.clear),
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.white70),
                        ),
                        IconButton(
                          tooltip: 'Fechar (`)',
                          onPressed: _visibility.toggle,
                          icon: const Icon(Icons.close, color: Colors.white70),
                        ),
                      ],
                    ),
                    const Divider(height: 1, color: Colors.white24),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _lines.length,
                        itemBuilder: (_, i) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          child: Text(
                            _lines[i],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'monospace',
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
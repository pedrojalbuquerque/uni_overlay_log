import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb, kDebugMode;
import 'package:flutter/material.dart';
import 'package:uni_overlay_log/uni_overlay_log.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    UniOverlayLog.I.init(capturePrints: true);

    final visibility = UniOverlayVisibility(initial: true);

    runApp(
      UniOverlayShortcuts(
        controller: visibility,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, child) => uniOverlayAppBuilder(
            context: context,
            child: child,
            isWeb: kIsWeb,
            visibility: visibility,
          ),
          home: const DemoPage(),
        ),
      ),
    );
  }, (error, stack) {
    Log.e('Erro não tratado', stack);
    if (kDebugMode) {
      // rethrow;
    }
  });
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('uni_overlay_log demo')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Log.i('Cliquei no botão');
              },
              child: const Text('Log.i'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                try {
                  throw Exception('Erro de teste');
                } catch (e, s) {
                  Log.e(e, s);
                }
              },
              child: const Text('Log.e'),
            ),
          ],
        ),
      ),
    );
  }
}
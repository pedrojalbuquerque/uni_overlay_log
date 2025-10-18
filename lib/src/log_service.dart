import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

class UniOverlayLog {
  UniOverlayLog._();
  static final UniOverlayLog I = UniOverlayLog._();

  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;

  bool _initialized = false;

  /// Inicia o serviço de logs e captura prints/erros.
  void init({bool capturePrints = true}) {
    if (_initialized) return;
    _initialized = true;

    if (capturePrints) {
      final oldDebugPrint = debugPrint;
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) Log.i(message);
        oldDebugPrint.call(message, wrapWidth: wrapWidth);
      };
    }

    FlutterError.onError = (details) {
      Log.e(details.exceptionAsString(), details.stack);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      Log.e(error, stack);
      return true;
    };
  }

  void add(String line) => _controller.add(line);

  void dispose() {
    _controller.close();
  }
}

class Log {
  static void i(Object? msg) {
    final line = '[LOG] $msg';
    UniOverlayLog.I.add(line);
    if (kDebugMode) dev.log(line);
  }

  static void e(Object? msg, [StackTrace? st]) {
    final line = st == null ? '[ERR] $msg' : '[ERR] $msg\n$st';
    UniOverlayLog.I.add(line);
    if (kDebugMode) dev.log(line, stackTrace: st, level: 1000);
  }
}
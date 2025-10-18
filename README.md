# uni_overlay_log

[![Pub Version](https://img.shields.io/pub/v/uni_overlay_log.svg)](https://pub.dev/packages/uni_overlay_log)
[![SDK](https://img.shields.io/badge/SDK-%3E%3D2.17.0-blue.svg)](https://dart.dev)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.3.0-blue.svg)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Console de logs **embutido e arrastável** para Flutter **Web/Mobile/Desktop**, com captura de `print`, `debugPrint`, `FlutterError` e `PlatformDispatcher.onError`. Inclui **hotkey** (tecla `) para mostrar/ocultar o painel.

https://github.com/pedrojalbuquerque/uni_overlay_log

## Recursos
- Captura automática de: `print()`, `debugPrint()`, `FlutterError`, `onError`
- Console embutido (DraggableScrollableSheet)
- Copiar/Limpar
- Hotkey ` (backquote) para visibilidade
- Web / Android / iOS / Desktop
- Zero dependências

## Instalação (pub.dev)
```yaml
dependencies:
  uni_overlay_log: ^0.1.5
```
*(ou via Git enquanto não publica)*

## Uso rápido
Veja `example/`. Resumo:
```dart
UniOverlayLog.I.init(capturePrints: true);
final visibility = UniOverlayVisibility(initial: true);
runApp(
  UniOverlayShortcuts(
    controller: visibility,
    enabled: true,
    child: MaterialApp(
      builder: (context, child) => uniOverlayAppBuilder(
        context: context,
        child: child,
        isWeb: kIsWeb,
        visibility: visibility,
      ),
      home: const MyHome(),
    ),
  ),
);
```

## Adicionar ao Log
Para exibir no Log use print(), debugPrint(), FlutterError, onError ou:
```dart
Log.i('mensagem');
Log.e(error, stackTrace);
```

## Licença
MIT
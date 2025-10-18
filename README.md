# uni_overlay_log

Console de logs embutido (arrastável) para Flutter Web/Mobile/Desktop, com captura de `print`, `debugPrint`, `FlutterError` e `PlatformDispatcher.onError`. Inclui hotkey (`) para mostrar/ocultar.

## Instalação

```yaml
dependencies:
  uni_overlay_log:
    git:
      url: https://github.com/sua-org/uni_overlay_log.git
      ref: main
```

## Uso rápido

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UniOverlayLog.I.init(capturePrints: true);

  final visibility = UniOverlayVisibility(initial: true);

  runApp(
    UniOverlayShortcuts(
      controller: visibility, // tecla ` alterna
      child: MaterialApp(
        builder: (context, child) => uniOverlayAppBuilder(
          context: context,
          child: child,
          isWeb: kIsWeb,
          visibility: visibility,
        ),
        home: const HomePage(),
      ),
    ),
  );
}
```

No seu app, use `Log.i('mensagem')` e `Log.e(erro, stackTrace)` para enviar ao console embutido.

## Recursos
- Captura automática de `print`, `debugPrint`, `FlutterError`, `onError`
- Draggable bottom sheet
- Copiar / Limpar
- Hotkey backquote (`) para visibilidade
- Funciona em Web/Android/iOS/Desktop

## Licença
MIT
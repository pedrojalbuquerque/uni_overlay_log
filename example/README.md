# uni_overlay_log_example

Exemplo oficial do pacote **uni_overlay_log**.

## Rodando o exemplo

```bash
cd example
flutter pub get
flutter run -d chrome
# ou: flutter run -d macos / windows / linux / android / ios
```

## O que o exemplo mostra
- Inicialização do serviço (`UniOverlayLog.I.init`)
- Uso do helper `uniOverlayAppBuilder` no `MaterialApp.builder`
- Hotkey **`** (backquote) para mostrar/ocultar o console
- `Log.i` e `Log.e` enviando mensagens para o painel embutido
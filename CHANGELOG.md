# Changelog

## 0.1.0
- Versão inicial:
  - Captura prints/erros globais
  - Overlay arrastável com copiar/limpar
  - Hotkey ` (backquote) para visibilidade
  - Helper para uso em `MaterialApp.builder`
  - Exemplo oficial em `example/`
## 0.1.1
- Corrigido: `UniOverlayShortcuts` não rouba foco (teclado virtual volta a aparecer em mobile).
- Adicionado: flag `enabled` para ativar hotkeys apenas em plataformas com teclado físico.

## 0.1.2
- Overlay agora é **ciente do teclado**: reposiciona acima do teclado virtual usando `MediaQuery.viewInsets.bottom`.
- Opções: `dockAboveKeyboard` (default: true) e `autoHideOnKeyboard` (default: false).
-UniOverlayShortcuts(enabled: true / false),

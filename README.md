# android-flutter

## Argumentos

| FLUTTER_VERSION            | Versão do flutter a ser instalado na imagem. Padrão: v1.12.13+hotfix.8   |
|----------------------------|--------------------------------------------------------------------------|
| ANDROID_BUILDTOOLS_VERSION | Versão da ferramenta de build tools do android. Padrão: 29.0.2           |
| ANDROID_PLATFORM_VERSION   | Versão da plataforma usada para compilar o appbundle. Padrão: android-29 |

## Compilar esta imagem localmente

Para compilar localmente usando os parâmetros padrões citados acima, use:

```bash
docker build . -t android-flutter:local
```

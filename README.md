# Orgullo Dominicano - Aplicación Móvil

Aplicación móvil oficial de [Orgullo Dominicano](https://orgullodominicano.org/) desarrollada en Flutter para Android e iOS.

## Características

- ✅ WebView optimizado del sitio web oficial
- ✅ Pantalla de carga (Splash Screen) animada
- ✅ Navegación mejorada (atrás, adelante, inicio, refrescar)
- ✅ Detección de conectividad de red
- ✅ Pantalla de "Sin conexión" con opción de reintentar
- ✅ Compartir noticias en redes sociales
- ✅ Apertura de enlaces externos en navegador
- ✅ Preparado para integración con Google AdMob
- ✅ Diseño responsivo y moderno
- ✅ Colores de la bandera dominicana

## Requisitos

- Flutter SDK 3.7.2 o superior
- Dart SDK
- Android Studio / VS Code
- Xcode (para iOS)

## Instalación

1. **Clonar el repositorio o navegar al directorio del proyecto:**
   ```bash
   cd orgullo_dominicano_app
   ```

2. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

## Configuración para Producción

### Android

1. **Configurar el icono de la aplicación:**
   - Reemplazar los archivos en `android/app/src/main/res/mipmap-*/`
   - O usar el paquete `flutter_launcher_icons`

2. **Configurar la firma de la aplicación:**
   - Crear un keystore: `keytool -genkey -v -keystore app-release-key.keystore -alias app -keyalg RSA -keysize 2048 -validity 10000`
   - Configurar `android/key.properties`
   - Modificar `android/app/build.gradle`

3. **Construir APK para producción:**
   ```bash
   flutter build apk --release
   ```

4. **Construir Bundle para Google Play:**
   ```bash
   flutter build appbundle --release
   ```

### iOS

1. **Configurar Bundle Identifier en Xcode**
2. **Configurar iconos y Launch Screen**
3. **Construir para iOS:**
   ```bash
   flutter build ios --release
   ```

## Configuración de AdMob

### Paso 1: Obtener IDs de AdMob
1. Crear una cuenta en [Google AdMob](https://admob.google.com/)
2. Crear una nueva aplicación
3. Generar unidades de anuncios (Banner, Intersticial, Rewarded)

### Paso 2: Configurar IDs en la aplicación
Editar `lib/config/ad_config.dart` y reemplazar los IDs de prueba:

```dart
static String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // Tu ID real
  } else if (Platform.isIOS) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // Tu ID real
  }
}
```

### Paso 3: Configurar AndroidManifest.xml
Agregar el Application ID de AdMob en `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
```

### Paso 4: Configurar Info.plist para iOS
Agregar en `ios/Runner/Info.plist`:

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
```

### Paso 5: Integrar anuncios en la aplicación
Para agregar un banner en cualquier pantalla:

```dart
import 'package:orgullo_dominicano_app/widgets/ad_banner_widget.dart';

// En el widget build:
Column(
  children: [
    // Tu contenido aquí
    AdBannerWidget(),
  ],
)
```

Para mostrar anuncios intersticiales:

```dart
import 'package:orgullo_dominicano_app/widgets/ad_banner_widget.dart';
import 'package:orgullo_dominicano_app/config/ad_config.dart';

// Cargar anuncio intersticial
InterstitialAdManager.loadInterstitialAd();

// Mostrar cuando sea apropiado
if (AdManager.shouldShowInterstitialAd()) {
  InterstitialAdManager.showInterstitialAd();
}
```

## Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada de la aplicación
├── config/
│   └── ad_config.dart          # Configuración de AdMob
└── widgets/
    └── ad_banner_widget.dart   # Widgets de anuncios

assets/
├── images/                     # Imágenes de la aplicación
└── icons/                      # Iconos personalizados

android/
└── app/src/main/
    └── AndroidManifest.xml     # Configuración Android

ios/
└── Runner/
    └── Info.plist             # Configuración iOS
```

## Funcionalidades Implementadas

### WebView Mejorado
- Carga la página principal de Orgullo Dominicano
- Permite navegación completa dentro del dominio
- Abre enlaces externos en el navegador del sistema
- Progress indicator durante la carga

### Conectividad
- Detección automática de conexión a internet
- Pantalla de error cuando no hay conexión
- Botón de reintentar automático

### Navegación
- Barra de navegación inferior con botones:
  - Atrás/Adelante (según disponibilidad)
  - Inicio (regresa a la página principal)
  - Refrescar página actual
- Menú de opciones en la barra superior

### Compartir
- Función para compartir noticias en redes sociales
- Compatible con todas las aplicaciones de compartir del dispositivo

## Personalización

### Colores
Los colores principales están definidos en `main.dart`:
- Rojo de la bandera: `Color(0xFFCE1126)`
- Se pueden modificar en el `ThemeData`

### Splash Screen
La pantalla de carga se puede personalizar en la clase `SplashScreen`:
- Duración de la animación
- Logo y texto
- Colores de fondo

### URL Base
Para cambiar la URL principal, modificar en `main.dart`:
```dart
..loadRequest(Uri.parse('https://tu-sitio-web.com/'));
```

## Troubleshooting

### Problemas de Conectividad
- Verificar permisos de internet en AndroidManifest.xml
- Verificar configuración de cleartext traffic

### Problemas de WebView
- Verificar que JavaScript esté habilitado
- Revisar configuración de navegación en NavigationDelegate

### Problemas de AdMob
- Verificar IDs de anuncios
- Confirmar configuración en AndroidManifest.xml e Info.plist
- Revisar logs de depuración

## Contribuir

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Crear un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## Contacto

**Orgullo Dominicano**
- Website: https://orgullodominicano.org/
- Email: contacto@orgullodominicano.org

---

*Desarrollado con ❤️ para la comunidad dominicana*

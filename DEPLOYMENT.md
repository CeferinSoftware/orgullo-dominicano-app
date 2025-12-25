# Guía de Deployment - Orgullo Dominicano App

## Preparación para Producción

### 1. Configurar Iconos de la Aplicación

**Crear iconos en diferentes tamaños:**
- 1024x1024 (iOS App Store)
- 512x512 (Google Play Store)
- Múltiples tamaños para Android (48x48, 72x72, 96x96, 144x144, 192x192)

**Para automatizar la generación de iconos:**
1. Instalar flutter_launcher_icons:
```bash
flutter pub add dev:flutter_launcher_icons
```

2. Configurar en `pubspec.yaml`:
```yaml
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"
  min_sdk_android: 21
```

3. Generar iconos:
```bash
flutter packages pub run flutter_launcher_icons:main
```

### 2. Configurar Splash Screen Nativo

1. Instalar flutter_native_splash:
```bash
flutter pub add dev:flutter_native_splash
```

2. Configurar en `pubspec.yaml`:
```yaml
flutter_native_splash:
  color: "#CE1126"
  image: assets/images/splash_logo.png
  android_12:
    image: assets/images/splash_logo.png
    color: "#CE1126"
```

3. Generar splash screen:
```bash
flutter packages pub run flutter_native_splash:create
```

### 3. Configurar Firma de Android

**Crear keystore:**
```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**Crear `android/key.properties`:**
```properties
storePassword=TU_STORE_PASSWORD
keyPassword=TU_KEY_PASSWORD
keyAlias=upload
storeFile=../app-release-key.keystore
```

**Modificar `android/app/build.gradle`:**
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    compileSdkVersion 34
    ndkVersion flutter.ndkVersion

    defaultConfig {
        applicationId "com.orgullodominicano.app"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### 4. Configurar AdMob para Producción

**Obtener Application ID de AdMob:**
1. Ir a [Google AdMob Console](https://apps.admob.com/)
2. Crear nueva aplicación
3. Obtener Application ID

**Android - `android/app/src/main/AndroidManifest.xml`:**
```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
```

**iOS - `ios/Runner/Info.plist`:**
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
```

**Actualizar IDs en `lib/config/ad_config.dart`:**
```dart
static const bool useTestAds = false; // Cambiar a false para producción

static String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // ID real de Android
  } else if (Platform.isIOS) {
    return 'ca-app-pub-XXXXXXXXXXXXXXXX/XXXXXXXXXX'; // ID real de iOS
  }
}
```

## Build para Producción

### Android

**APK para distribución directa:**
```bash
flutter build apk --release
```

**AAB para Google Play Store:**
```bash
flutter build appbundle --release
```

### iOS

**Para App Store:**
```bash
flutter build ios --release
```

Luego abrir Xcode y archivar desde allí.

## Publicación en Tiendas

### Google Play Store

1. **Preparar assets:**
   - Icono de la aplicación (512x512)
   - Screenshots (mínimo 2, máximo 8)
   - Banner de feature gráfico (1024x500)
   - Descripción en español

2. **Subir AAB:**
   - Archivo: `build/app/outputs/bundle/release/app-release.aab`

3. **Información requerida:**
   - Título: "Orgullo Dominicano"
   - Descripción corta: "Noticias oficiales de República Dominicana"
   - Descripción completa: [Ver más abajo]
   - Categoría: "Noticias y revistas"
   - Clasificación de contenido
   - Política de privacidad

### App Store (iOS)

1. **App Store Connect:**
   - Crear nueva aplicación
   - Bundle ID: com.orgullodominicano.app
   - SKU: orgullodominicano-app

2. **Assets requeridos:**
   - Icono 1024x1024
   - Screenshots para diferentes dispositivos
   - Descripción en español

## Descripción Sugerida para Tiendas

**Título:**
Orgullo Dominicano - Noticias RD

**Descripción Corta:**
Mantente informado con las noticias más importantes de República Dominicana. La aplicación oficial de Orgullo Dominicano.

**Descripción Completa:**
📱 **Orgullo Dominicano** - Tu fuente confiable de noticias dominicanas

Mantente al día con las noticias más importantes de República Dominicana con la aplicación oficial de Orgullo Dominicano. Accede a información actualizada sobre política, economía, deportes, cultura y mucho más.

**🔹 Características principales:**
• Noticias en tiempo real
• Navegación rápida e intuitiva
• Compartir noticias en redes sociales
• Funciona sin conexión (lectura offline)
• Diseño moderno con los colores de la bandera dominicana
• Actualizaciones automáticas

**📈 Categorías disponibles:**
• Noticias Nacionales e Internacionales
• Política y Gobierno
• Economía y Finanzas
• Deportes
• Farándula y Entretenimiento
• Ciencia y Tecnología
• Turismo
• Diáspora Dominicana

**🇩🇴 Orgullo Dominicano** es la plataforma digital líder en información dominicana, comprometida con brindar noticias veraces y oportunas para la comunidad dominicana en el país y en el exterior.

Descarga la aplicación oficial y mantente conectado con todo lo que acontece en nuestra bella República Dominicana.

**Palabras clave:** República Dominicana, noticias, RD, dominicano, política, economía, deportes, diáspora

## Configuraciones Post-Launch

### Analytics
- Integrar Firebase Analytics
- Configurar eventos personalizados
- Monitorear crashes con Firebase Crashlytics

### Actualizaciones
- Configurar CodePush para actualizaciones menores
- Establecer proceso de CI/CD
- Versionado semántico

### Monitoreo
- Configurar alertas de performance
- Monitorear reviews en las tiendas
- Configurar métricas de AdMob

## Checklist de Pre-Launch

- [ ] Iconos configurados para todas las resoluciones
- [ ] Splash screen nativo implementado
- [ ] Firma de Android configurada
- [ ] AdMob IDs actualizados a producción
- [ ] Tests ejecutados exitosamente
- [ ] Build de release compilado sin errores
- [ ] Screenshots tomados en diferentes dispositivos
- [ ] Descripción de la app lista en español
- [ ] Política de privacidad publicada
- [ ] Términos y condiciones listos
- [ ] Metadata de las tiendas completado
- [ ] Verificación final en dispositivos físicos

## Soporte Post-Launch

### Actualizaciones de Contenido
El contenido se actualiza automáticamente desde el sitio web de Orgullo Dominicano.

### Actualizaciones de la App
- Versiones menores: Cada 2-4 semanas
- Versiones mayores: Cada 2-3 meses
- Hotfixes: Según necesidad

### Canales de Soporte
- Email: soporte@orgullodominicano.org
- Redes sociales de Orgullo Dominicano
- Reviews en las tiendas de aplicaciones 
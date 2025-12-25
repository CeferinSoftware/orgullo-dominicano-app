# 🍎 Guía de Despliegue iOS - Orgullo Dominicano App

## Configuración Actual

| Configuración | Valor |
|--------------|-------|
| Bundle ID | `com.eturingsrl.orgullodominicano` |
| Versión mínima iOS | 12.0 |
| Nombre de la App | Orgullo Dominicano |
| Versión actual | 1.0.2+3 |

## 📋 Prerrequisitos para App Store

Antes de hacer el build en Codemagic, necesitas:

### 1. Cuenta de Apple Developer ($99/año)
- Regístrate en [Apple Developer Program](https://developer.apple.com/programs/)
- Una vez aprobado, tendrás acceso a App Store Connect

### 2. Crear App ID en Apple Developer Portal
1. Ve a [Certificates, Identifiers & Profiles](https://developer.apple.com/account/resources/identifiers/list)
2. Click en "+" para agregar un nuevo Identifier
3. Selecciona "App IDs" → Continue
4. Selecciona "App" → Continue
5. Configura:
   - **Description**: Orgullo Dominicano
   - **Bundle ID**: Explicit → `com.eturingsrl.orgullodominicano`
6. Activa las capabilities necesarias:
   - ✅ Associated Domains (opcional)
   - ✅ Push Notifications (opcional para futuro)
7. Click en "Continue" → "Register"

### 3. Crear la App en App Store Connect
1. Ve a [App Store Connect](https://appstoreconnect.apple.com/)
2. Ve a "My Apps" → "+"  → "New App"
3. Configura:
   - **Platforms**: iOS
   - **Name**: Orgullo Dominicano
   - **Primary Language**: Spanish (Spain) o Spanish (Latin America)
   - **Bundle ID**: Selecciona `com.eturingsrl.orgullodominicano`
   - **SKU**: `orgullo-dominicano-ios` (identificador único)
   - **User Access**: Full Access
4. Click "Create"

---

## 🔧 Configuración de Codemagic

### Paso 1: Conectar Repositorio
1. Ve a [Codemagic](https://codemagic.io/) y crea una cuenta
2. Click en "Add application"
3. Conecta tu repositorio de GitHub
4. Selecciona el repositorio `orgullo_dominicano_app`

### Paso 2: Configurar Code Signing para iOS

En Codemagic Dashboard → Tu App → Settings → Code signing:

#### Opción A: Automatic Code Signing (Recomendado)
1. En "iOS code signing", selecciona "Automatic"
2. Conecta tu cuenta de Apple Developer:
   - Click "Connect" en Apple Developer Portal
   - Inicia sesión con tu Apple ID de desarrollador
3. Codemagic generará y manejará los certificados automáticamente

#### Opción B: Manual Code Signing
1. Genera un certificado de distribución en Apple Developer Portal
2. Crea un Provisioning Profile para App Store
3. Sube los archivos (.p12 y .mobileprovision) a Codemagic

### Paso 3: Configurar App Store Connect API

1. En App Store Connect → Users and Access → Keys
2. Click "+" para generar una nueva API Key
3. Configura:
   - **Name**: Codemagic
   - **Access**: App Manager
4. Descarga la key (.p8) - ¡Solo puedes descargarla una vez!
5. Anota:
   - **Key ID**: Aparece en la lista de keys
   - **Issuer ID**: Aparece arriba de la lista

6. En Codemagic Dashboard → Tu App → Settings → Publishing:
   - Click "Connect" en App Store Connect
   - Sube el archivo .p8
   - Ingresa Key ID e Issuer ID

### Paso 4: Configurar Variables de Entorno

En Codemagic Dashboard → Tu App → Environment variables, crea el grupo `app_store_credentials`:

| Variable | Valor |
|----------|-------|
| `APP_STORE_APP_ID` | ID numérico de tu app (lo encuentras en App Store Connect → General → App Information) |

---

## 🚀 Ejecutar el Build

### Desde el Dashboard:
1. Ve a tu app en Codemagic
2. Click "Start new build"
3. Selecciona el workflow:
   - **ios-testflight**: Para pruebas internas
   - **ios-release**: Para publicar en App Store

### Desde Git (automático):
El workflow `ios-testflight` se ejecuta automáticamente al hacer push a la rama `main`.

---

## 📱 Preparar el Listing de App Store

Antes de publicar, prepara en App Store Connect:

### Screenshots requeridos
- iPhone 6.7" (1290 x 2796 px) - iPhone 15 Pro Max
- iPhone 6.5" (1284 x 2778 px) - iPhone 14 Plus (opcional)
- iPhone 5.5" (1242 x 2208 px) - iPhone 8 Plus (opcional)
- iPad Pro 12.9" (2048 x 2732 px) - si soportas iPad

### Información requerida
- **Descripción**: Descripción completa de la app
- **Keywords**: Palabras clave separadas por comas
- **Support URL**: URL de soporte
- **Privacy Policy URL**: URL de política de privacidad (REQUERIDO)
- **App Icon**: 1024x1024 px (ya está en Assets.xcassets)

### Clasificación de edad
Completa el cuestionario de clasificación de contenido.

---

## 🔄 Actualizar la Versión

Para subir una nueva versión:

1. Actualiza el `pubspec.yaml`:
```yaml
version: 1.0.3+4  # version: major.minor.patch+buildNumber
```

2. Haz commit y push:
```bash
git add .
git commit -m "Bump version to 1.0.3"
git push origin main
```

3. El build se ejecutará automáticamente o inícialo manualmente.

---

## ❓ Solución de Problemas

### Error: "No signing certificate found"
- Verifica que tu cuenta de Apple Developer esté conectada en Codemagic
- Asegúrate de que el Bundle ID coincida exactamente

### Error: "Provisioning profile doesn't match bundle identifier"
- El Bundle ID en Xcode debe ser: `com.eturingsrl.orgullodominicano`
- Regenera el provisioning profile si es necesario

### Error: "Missing compliance information"
- En App Store Connect, ve a tu build
- Click en "Manage" junto a "Export Compliance"
- Selecciona "No" si no usas encriptación propietaria

---

## 📞 Contacto

Para soporte técnico con el despliegue, contacta al equipo de desarrollo.

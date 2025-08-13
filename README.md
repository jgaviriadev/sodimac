# 🛠️ Prueba Técnica Flutter - Homecenter App

Una aplicación Flutter desarrollada como prueba técnica para listar productos desde la API pública de Homecenter. Incluye scroll infinito, sugerencias de búsqueda, carrito de compras local con Drift, y manejo de estado con BLoC.

## 📱 Funcionalidades

- 🔍 Búsqueda con sugerencias predefinidas.
- 📦 Listado de productos con:
- Imagen
- Nombre
- Precio (tipo NORMAL)
- ♾️ Scroll infinito
- 🛒 Carrito de compras persistente (usando Drift).
- 🧠 Gestión de estado con BLoC.
- ⚡ Caché de resultados de búsqueda (usando dio_cache_interceptor).
- 🧪 Pruebas unitarias de lógica de negocio y base de datos.
- ✅ Enfoque en Clean Code y principios SOLID.

## 📱 Requisitos

- Flutter SDK 3.32.0

## 🧪 Correr el proyecto

```bash
# 1. Clonar el repositorio
git clone https://github.com/jgaviriadev/sodimac.git
cd sodimac

# 2. Instalar dependencias
flutter pub get

# 3. Generar archivos de Drift y otros
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Ejecutar la app
flutter run



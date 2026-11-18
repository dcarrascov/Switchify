<h1>
  <img src="assets/logo.png" alt="" width="48" height="48" align="center">
  Switchify
</h1>

[English](README.md) · **Español**

Convierte archivos en Windows desde un menú circular. Arrastra un archivo, pulsa **Shift** y suéltalo sobre el formato que quieras, o simplemente deja el ratón encima de un archivo y pulsa Shift. El resultado se guarda junto al original, que nunca se sobrescribe.

Switchify es una pequeña aplicación que vive en la bandeja del sistema. Solo usa lo que ya trae Windows: no hace falta instalar otros programas, entornos ni navegadores.

<p align="center">
  <img src="assets/demo.gif" alt="Demostración de Switchify: convertir una imagen a JPG, un Markdown a PDF y abrir las herramientas de imagen" width="820">
</p>

## Cómo funciona

Hay cuatro formas de abrir el anillo:

| Gesto | Qué pasa |
|---|---|
| **Arrastrar un archivo + Shift** | Mientras arrastras uno o varios archivos, pulsa Shift. El anillo aparece bajo el cursor: suelta los archivos sobre una opción. |
| **Mantener Shift encima de un archivo** | Con el ratón quieto encima de un archivo, mantén Shift. Ve a una opción y suelta Shift para usarla. |
| **Toque de Shift encima de un archivo** | Un toque rápido abre el anillo y lo deja abierto: haz clic en una opción. Esc o un clic fuera lo cierran. |
| **Ctrl+Shift+Espacio** | Abre el anillo para los archivos seleccionados en el Explorador. |

Funciona en el Explorador de archivos y en el Escritorio. Si el archivo bajo el cursor forma parte de una selección, el anillo usa toda la selección.

### Qué puede hacer

| Archivos | Opciones |
|---|---|
| **Imágenes** (PNG, JPG, BMP, GIF, TIFF, ICO) | Convertir entre formatos, a PDF (varias imágenes → un PDF) y a texto con OCR. **Herramientas**: comprimir, recortar, fondo, editar, anotar, tapar y ver o quitar metadatos. |
| **Documentos** (MD, TXT, DOCX, HTML, PDF) | Convertir entre PDF, DOCX, MD, HTML y TXT. PDF a Word, Markdown o texto conservando títulos, listas, tablas, negritas y cursivas (los PDF escaneados pasan por OCR), o a imágenes (una por página). El texto plano también se lee con su estructura: títulos, listas y tablas. |
| **Vídeo** (MP4, MOV, MKV, AVI, WMV, WebM, 3GP) | Convertir a MP4 o WMV, comprimir y extraer el audio a MP3, M4A o WAV. |
| **Audio** (MP3, WAV, M4A, AAC, FLAC, WMA) | Convertir entre MP3, M4A, WAV, FLAC y WMA. |
| **Cualquier archivo** | Comprimir en ZIP (o extraer un ZIP). Las imágenes y los documentos también se pueden imprimir. |

## Instalación

Necesita **Windows 10 u 11**.

### Descarga

1. Descarga `Switchify-Setup-<versión>.exe` de la [última versión](../../releases/latest).
2. Ábrelo y sigue los pasos. Se instala solo para tu usuario (sin pedir administrador) en `%LOCALAPPDATA%\Programs\Switchify`, añade Switchify al menú Inicio y, si dejas marcada la opción, lo inicia con Windows.
3. Al terminar se abre Switchify. Su icono aparece en la bandeja del sistema.

Puede que Windows SmartScreen avise porque el instalador aún no está firmado: pulsa **Más información → Ejecutar de todas formas**.

Para actualizar, descarga el nuevo instalador y ábrelo: reemplaza la copia instalada.

### Compilar desde el código

No hace falta ningún SDK: se compila con el compilador de C# que ya trae Windows (.NET Framework 4).

```powershell
git clone https://github.com/dimacavidv-lgtm/Switchify.git
cd Switchify
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

Esto crea `Switchify.exe` e instala una copia en `%LOCALAPPDATA%\Programs\Switchify`. Abre esa copia la primera vez; al volver a ejecutar `build.ps1` se actualiza (y se reinicia si está abierta).

Para generar el instalador, instala una vez [Inno Setup 6](https://jrsoftware.org/isinfo.php) y ejecuta `installer.ps1`. Crea `dist\Switchify-Setup-<versión>.exe`; la versión se cambia en `src\AssemblyInfo.cs`.

```powershell
winget install --id JRSoftware.InnoSetup -e --scope user
powershell -ExecutionPolicy Bypass -File .\installer.ps1
```

### Iniciar con Windows

El instalador puede activarlo por ti. También puedes cambiarlo cuando quieras: haz clic derecho en el icono de la bandeja y marca o desmarca **Iniciar con Windows**. Usa una tarea programada que abre Switchify al iniciar sesión.

### Desinstalar

Ve a **Configuración → Aplicaciones → Aplicaciones instaladas**, busca **Switchify** y elige **Desinstalar**. Se cierra Switchify y se borran la tarea de inicio y su carpeta.

Si usabas una versión anterior (un `Switchify.exe` suelto), desmarca **Iniciar con Windows**, elige **Salir** en el menú de la bandeja y borra el archivo.

## Limitaciones

Para no depender de programas externos, Switchify no puede convertir **a** WebM, MKV, GIF (vídeo) ni OGG, ni leer archivos OGG/Opus.

## Contribuir

Las sugerencias y los pull requests son bienvenidos. Mira [CONTRIBUTING.md](CONTRIBUTING.md) (en inglés).

## Licencia

[MIT](LICENSE) © dimacavidv-lgtm

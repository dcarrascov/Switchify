// Metadatos de versión del ejecutable (Propiedades → Detalles en el Explorador).
// Un .exe sin compañía, producto ni versión parece más sospechoso a los antivirus y a SmartScreen.
// installer.ps1 lee la versión de aquí para nombrar el instalador.

using System.Reflection;
using System.Runtime.InteropServices;

[assembly: AssemblyTitle("Switchify")]
[assembly: AssemblyDescription("Switchify - convierte archivos con un menú circular")]
[assembly: AssemblyCompany("dimacavidv-lgtm")]
[assembly: AssemblyProduct("Switchify")]
[assembly: AssemblyCopyright("Copyright (c) 2026 dimacavidv-lgtm (MIT)")]
[assembly: AssemblyVersion("1.2.0.0")]
[assembly: AssemblyFileVersion("1.2.0.0")]
[assembly: AssemblyInformationalVersion("1.2.0")]
[assembly: ComVisible(false)]

; Instalador de Switchify (Inno Setup 6). Se genera con installer.ps1, que pasa la versión y el .exe:
;   ISCC.exe /DAppVersion=1.2.0 /DSourceExe=..\dist\Switchify.exe installer\Switchify.iss
; Instalación por usuario, sin pedir administrador, en %LOCALAPPDATA%\Programs\Switchify
; (la misma carpeta que usa build.ps1, así que no quedan dos copias).

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#ifndef SourceExe
  #define SourceExe "..\dist\Switchify.exe"
#endif

[Setup]
; El AppId identifica la app para las actualizaciones y el desinstalador: no cambiarlo nunca.
AppId={{1313CAA9-8F4C-4CD0-9204-F204ED218F82}
AppName=Switchify
AppVersion={#AppVersion}
AppVerName=Switchify {#AppVersion}
AppPublisher=dimacavidv-lgtm
AppPublisherURL=https://github.com/dimacavidv-lgtm/Switchify
AppSupportURL=https://github.com/dimacavidv-lgtm/Switchify/issues
AppUpdatesURL=https://github.com/dimacavidv-lgtm/Switchify/releases
AppCopyright=Copyright (c) 2026 dimacavidv-lgtm (MIT)
VersionInfoVersion={#AppVersion}
VersionInfoCompany=dimacavidv-lgtm
VersionInfoDescription=Instalador de Switchify
VersionInfoProductName=Switchify
VersionInfoProductVersion={#AppVersion}
; Por usuario: {userpf} es %LOCALAPPDATA%\Programs.
PrivilegesRequired=lowest
DefaultDirName={userpf}\Switchify
DisableDirPage=yes
DefaultGroupName=Switchify
DisableProgramGroupPage=yes
SetupIconFile=..\assets\switchify.ico
UninstallDisplayIcon={app}\Switchify.exe
UninstallDisplayName=Switchify
OutputDir=..\dist
OutputBaseFilename=Switchify-Setup-{#AppVersion}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ShowLanguageDialog=auto
; Switchify se cierra a mano en [Code]: al ser una app de bandeja, el Restart Manager no siempre puede.
CloseApplications=no
RestartApplications=no
; Firma de código (si algún día se compra un certificado): definir una herramienta «signtool» en
; Inno Setup y descomentar estas líneas para firmar el instalador y el desinstalador.
; SignTool=signtool
; SignedUninstaller=yes

[Languages]
Name: "es"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "en"; MessagesFile: "compiler:Default.isl"

[CustomMessages]
es.StartupTask=Iniciar Switchify con Windows
en.StartupTask=Start Switchify with Windows
es.DesktopTask=Crear un acceso directo en el Escritorio
en.DesktopTask=Create a desktop shortcut
es.OtherTasks=Opciones:
en.OtherTasks=Options:
es.LaunchNow=Abrir Switchify ahora
en.LaunchNow=Open Switchify now

[Tasks]
Name: "startup"; Description: "{cm:StartupTask}"; GroupDescription: "{cm:OtherTasks}"
Name: "desktopicon"; Description: "{cm:DesktopTask}"; GroupDescription: "{cm:OtherTasks}"; Flags: unchecked

[Files]
Source: "{#SourceExe}"; DestDir: "{app}"; DestName: "Switchify.exe"; Flags: ignoreversion
Source: "..\LICENSE"; DestDir: "{app}"; DestName: "LICENSE.txt"; Flags: ignoreversion

[Icons]
Name: "{autoprograms}\Switchify"; Filename: "{app}\Switchify.exe"; Comment: "Convierte archivos con un menú circular"
Name: "{autodesktop}\Switchify"; Filename: "{app}\Switchify.exe"; Tasks: desktopicon

[Run]
; Inicio con Windows: la propia app crea o quita la tarea programada «Switchify» (la misma que el
; menú «Iniciar con Windows» de la bandeja).
Filename: "{app}\Switchify.exe"; Parameters: "--startup on"; Tasks: startup; Flags: runhidden waituntilterminated
Filename: "{app}\Switchify.exe"; Parameters: "--startup off"; Tasks: not startup; Flags: runhidden waituntilterminated
Filename: "{app}\Switchify.exe"; Description: "{cm:LaunchNow}"; Flags: postinstall nowait skipifsilent

[UninstallRun]
Filename: "{app}\Switchify.exe"; Parameters: "--startup off"; Flags: runhidden waituntilterminated; RunOnceId: "RemoveStartupTask"

[UninstallDelete]
; A veces la carpeta se quedaba vacía (Windows tarda en soltar el .exe recién cerrado).
Type: dirifempty; Name: "{app}"

[Code]
// Cierra Switchify si está abierto (también una copia puesta por build.ps1) para poder reemplazar o borrar el .exe.
procedure CloseSwitchify();
var
  Code: Integer;
begin
  Exec(ExpandConstant('{sys}\taskkill.exe'), '/F /IM Switchify.exe', '', SW_HIDE, ewWaitUntilTerminated, Code);
  Sleep(500);
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  CloseSwitchify();
  Result := '';
end;

function InitializeUninstall(): Boolean;
begin
  CloseSwitchify();
  Result := True;
end;

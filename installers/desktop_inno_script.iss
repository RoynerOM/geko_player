; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Geko Player"
#define MyAppVersion "1.0.0.0"
#define MyAppPublisher "CN=9F927B73-1CF4-4E81-803E-7CD67376D6D2"
#define MyAppExeName "Geko Player.exe"
#define MyAppAssocName MyAppName + " File"
#define MyAppAssocExt ".mp4,.mov,.avi,.mkv"
#define MyAppAssocKey StringChange(MyAppAssocName, " ", "") + MyAppAssocExt

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{D2A2F224-5E51-48BB-9A0D-CEA582285208}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\{#MyAppName}
; "ArchitecturesAllowed=x64compatible" specifies that Setup cannot run
; on anything but x64 and Windows 11 on Arm.
ArchitecturesAllowed=x64compatible
; "ArchitecturesInstallIn64BitMode=x64compatible" requests that the
; install be done in "64-bit mode" on x64 or Windows 11 on Arm,
; meaning it should use the native 64-bit Program Files directory and
; the 64-bit view of the registry.
ArchitecturesInstallIn64BitMode=x64compatible
ChangesAssociations=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=E:\Proyectos\geko_player\installers
OutputBaseFilename=Geko_Player
SetupIconFile=E:\Proyectos\geko_player\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\{#MyAppExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-console-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-console-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-datetime-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-debug-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-errorhandling-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-fibers-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-file-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-file-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-file-l2-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-handle-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-heap-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-interlocked-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-libraryloader-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-localization-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-memory-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-namedpipe-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-processenvironment-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-processthreads-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-processthreads-l1-1-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-profile-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-rtlsupport-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-string-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-synch-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-synch-l1-2-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-sysinfo-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-timezone-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-core-util-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-conio-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-convert-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-environment-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-filesystem-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-heap-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-locale-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-math-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-multibyte-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-private-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-process-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-runtime-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-stdio-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-string-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-time-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-crt-utility-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-downlevel-kernel32-l2-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\api-ms-win-eventing-provider-l1-1-0.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\concrt140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\d3dcompiler_47.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\flutter_windows.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\libc++.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\libEGL.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\libGLESv2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\libmpv-2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\media_kit_libs_windows_video_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\media_kit_native_event_loop.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\media_kit_video_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\msvcp140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\msvcp140_1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\msvcp140_2.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\msvcp140_atomic_wait.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\msvcp140_codecvt_ids.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\screen_brightness_windows_plugin.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\ucrtbase.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\ucrtbased.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vccorlib140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vccorlib140d.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vcruntime140.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vcruntime140_1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vcruntime140_1d.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vcruntime140d.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vk_swiftshader.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\vulkan-1.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\zlib.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "E:\Proyectos\geko_player\build\windows\x64\runner\Release\data\*"; DestDir: "{app}\data"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},0"
Root: HKA; Subkey: "Software\Classes\{#MyAppAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: ".myp"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent


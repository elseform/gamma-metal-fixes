# GAMMA Metal Fixes

[English](#english) · [Русский](#русский)

## English

Shader fixes for playing S.T.A.L.K.E.R. GAMMA on Apple Silicon through DXMT
or D3DMetal. They address rendering problems in Anomaly, Screen Space Shaders,
Atmospherics, and 3D Shader Scopes.

### Download and install

1. Open [Releases](https://github.com/elseform/gamma-metal-fixes/releases) and
   download the individual `.7z` archives you need from **Assets**. Each archive
   is a separate mod; the GitHub source-code downloads are not mod installers.
2. Install each archive with Mod Organizer 2's **Install a new mod from an
   archive** button, then enable it in the left pane.
3. Place each fix below its original mod in MO2's left pane, so the fix wins
   file conflicts. The fixes do not include their required source mods.
4. With the game closed, delete the contents of `appdata/shaders_cache/` in
   your game installation after installing or updating shader fixes. The game
   rebuilds the cache on the next launch.

Using Screen Space Shaders 24, Atmospherics 2.69 RC7.2 SSS24, 3D Shader Scopes
5, and peak volumetrics? These nine fixes are the selected package for that
stack. For a different setup, install only fixes matching your source mods
and read the individual mod README for compatibility details.

### Available fixes

| Archive name (before version and author) | What it addresses | Required source |
| --- | --- | --- |
| Metal - Anomaly - Core Fixes | Shader compilation and numerical issues | Anomaly base shaders |
| Metal - Anomaly - Shadow Aref Input Layout | Shadow shader input compatibility | Anomaly base shaders |
| Metal - peak volumetrics - Volumetric Light Fix | Volumetric light shader compatibility | peak_volumetrics 1.2 |
| Metal - Atmospherics 2.69 RC7.2 SSS24 - Core Fixes | Terrain and ambient-occlusion shader issues | Atmospherics 2.69 RC7.2 SSS24 |
| Metal - 3DSS5 - Mark Switch Grid Loop Guard | Bounds the reticle-grid loop | 3D Shader Scopes 5 |
| Metal - 3DSS5 - Reflex Sight Motion Vectors | Reflex sight and glass smearing with temporal rendering | 3D Shader Scopes 5 and SSS24 |
| Metal - 3DSS5 - SSS24 DLSS Buffers | Scope image and thermal buffer compatibility | 3D Shader Scopes 5 and SSS24 DLSS engine |
| Metal - SSS23+24 - Selflight Emissive Interface | Emissive shader compatibility | Screen Space Shaders 23 or 24 |
| Metal - SSS23+24 - Glass Triplanar Index Fix | Glass shader component indexing | Screen Space Shaders 23 or 24 |

Each archive contains its own README. No FOMOD installer is needed.
Additional development fixes on `dev` are not part of this release selection.

### Permissions

You may include these fixes in your mods or modpacks if you credit **elseform**
and link to this repository. No prior permission is required. You are welcome
to share your work on the GAMMA Discord.

This permission covers original work only; third-party code and assets retain
their authors' permissions. Previously part of
[gamma-mods](https://github.com/elseform/gamma-mods).

## Русский

Шейдерные исправления для S.T.A.L.K.E.R. GAMMA на Apple Silicon через DXMT
или D3DMetal. Исправляют проблемы отрисовки в Anomaly, Screen Space Shaders,
Atmospherics и 3D Shader Scopes.

### Скачать и установить

1. Откройте [Releases](https://github.com/elseform/gamma-metal-fixes/releases)
   и скачайте нужные архивы `.7z` из раздела **Assets**. Каждый архив — отдельный
   мод. Архивы исходного кода GitHub не предназначены для установки через MO2.
2. Установите каждый архив кнопкой **Установить новый мод из архива** в
   Mod Organizer 2 и включите мод в левой панели.
3. Разместите исправления ниже исходных модов в левой панели MO2, чтобы файлы
   исправлений побеждали в конфликтах. Сами исходные моды в архивы не входят.
4. После установки или обновления шейдерных исправлений закройте игру и удалите
   содержимое `appdata/shaders_cache/` в установленной игре. При следующем
   запуске кеш будет создан заново.

Девять исправлений из таблицы выше составляют выбранный комплект для Screen
Space Shaders 24, Atmospherics 2.69 RC7.2 SSS24, 3D Shader Scopes 5 и peak
volumetrics. Для другого набора модов выбирайте только подходящие исправления;
подробности совместимости приведены в README каждого мода внутри архива.
FOMOD-установщик не нужен. Дополнительные исправления из ветки `dev` в этот
комплект не входят.

### Разрешения

Можно включать исправления в свои моды и сборки, указав автора **elseform** и
ссылку на этот репозиторий. Предварительное разрешение не требуется. Будет
приятно узнать о вашей работе в Discord GAMMA.

Разрешение относится только к оригинальной работе; сторонние код и ассеты
сохраняют права и условия своих авторов. Ранее исправления входили в
[gamma-mods](https://github.com/elseform/gamma-mods).

# GAMMA Metal Fixes

[English](#english) · [Русский](#русский)

## English

Shader overrides for running GAMMA through D3DMetal/DXMT on macOS / Apple
Silicon. Previously part of [gamma-mods](https://github.com/elseform/gamma-mods).

### The problem

GAMMA's shaders are written and tested against D3D11 (and DXVK on Linux).
Both tolerate things Metal does not: out-of-range `sqrt`/divide-by-zero
silently degrading to zero instead of `NaN`, loosely-linked vertex/pixel
interpolators, and GPU hangs that D3D11's timeout-detection-and-recovery
(TDR) would normally kill and restart. Apple GPUs have no TDR, and Metal's
IR binds and validates far more strictly, so the same shader source can run
fine on Windows/Linux and corrupt the screen, black out, or hang the GPU on
macOS. Each entry in this repo is a minimal, targeted patch to one upstream
mod's shader for exactly one such failure — see [TESTING.md](TESTING.md) for
how they're found and confirmed fixed.

Each fix lives in its own folder here (see its README for the exact source
version it was built against), but ships as **one combined installer**: a
single FOMOD with a checkbox per upstream source mod. Tick every source mod
you actually have installed and you get one MO2 mod containing exactly those
fixes. Clear `appdata/shaders_cache/` after installing or updating.

### Installation

Download the latest release `.zip` from the
[release page](https://github.com/elseform/gamma-metal-fixes/releases/latest)
and install it through Mod Organizer 2 like any FOMOD-based mod. When the
installer's option screen appears, tick the source mods you have installed —
leave the rest unticked.

### Usage and permissions

You may include any of my mods or tweaks in your own mods / modpacks,
provided that you credit me and link back to this repository. Although
asking permission or letting me know is not required - I would love to know
if you decide to use any of my work, so hit me up on Discord's GAMMA server.

This permission covers my original work only. Third-party code and assets
keep their original authors' permissions and requirements.

---

## Русский

Шейдерные патчи для запуска GAMMA через D3DMetal/DXMT на macOS / Apple
Silicon. Ранее входили в состав [gamma-mods](https://github.com/elseform/gamma-mods).

### Проблема

Шейдеры GAMMA написаны и протестированы под D3D11 (и DXVK на Linux). Оба
рантайма терпят то, чего не терпит Metal: `sqrt`/деление на ноль за пределами
допустимой области незаметно вырождается в ноль вместо `NaN`, слабо связанные
vertex/pixel-интерполяторы, и зависания GPU, которые на D3D11 поймал бы и
перезапустил механизм TDR (timeout detection and recovery). На GPU Apple TDR
нет, а Metal IR куда строже привязывает и валидирует данные — из-за этого
один и тот же исходник шейдера нормально работает на Windows/Linux и портит
картинку, гасит экран или вешает GPU на macOS. Каждая запись в этом
репозитории — минимальный точечный патч одного шейдера из стороннего мода под
одну конкретную поломку такого рода. Как они находятся и подтверждаются — см.
[TESTING.md](TESTING.md).

Каждый фикс лежит в своей папке (точная версия исходника — в README этой
записи), но поставляется **одним общим инсталлятором**: единый FOMOD с
чекбоксом на каждый исходный мод. Отметьте те моды, что у вас реально
установлены, — получите один MO2-мод именно с этими фиксами. После установки
или обновления нужно очистить `appdata/shaders_cache/`.

### Установка

Скачать последний релиз (`.zip`) со [страницы релизов](https://github.com/elseform/gamma-metal-fixes/releases/latest)
и установить через Mod Organizer 2, как обычный FOMOD-мод. На экране выбора
опций отметить установленные исходные моды — остальное оставить без галочки.

### Использование и разрешения

Можно включать любой из моих модов или патчей в свои сборки/модпаки при
условии указания авторства и ссылки на этот репозиторий. Спрашивать
разрешение или предупреждать не обязательно — но было бы приятно узнать, если
решите использовать что-то из моей работы, так что пишите в Discord
GAMMA-сервера.

Это разрешение касается только моей собственной работы. Сторонний код и
ассеты сохраняют права и условия своих оригинальных авторов.

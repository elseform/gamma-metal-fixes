# Testing & Validation

[English](#english) · [Русский](#русский)

## English

These are minimal, targeted patches to third-party HLSL shaders so they compile
and render correctly under D3DMetal/DXMT on macOS. Each fix goes through the
same four passes before being marked stable.

### 1. Offline compilation

Before touching the game, every changed shader is compiled through the same
two stages the engine itself uses:

- **HLSL to DXBC** — the real `d3dcompiler_47.dll`, with the engine's own
  preprocessor macros, run outside the game.
- **DXBC to a Metal shader library** — [DXMT](https://github.com/3Shain/dxmt)'s
  own `airconv` translator, including cross-stage linking for
  vertex/geometry and vertex/hull/domain pairs.

This catches compile errors and Metal IR translation failures without ever
loading a save.

### 2. Runtime identification

Some failures only surface at runtime, and Metal's error text never names the
shader — DXMT identifies pipelines by a content hash instead of a filename.
Tracking one down means capturing the failing run's log for the exact
vertex/pixel hash pair, matching those hashes against the compiled shader
cache to recover the real source file, and comparing the vertex shader's
output struct against the pixel shader's input struct — the class of mismatch
D3D11/DXVK tolerate silently but Metal's strict semantic-register binding does
not.

### 3. GPU-trace diagnosis and confirmation

Before and after a fix, a Metal GPU capture of the real game frame
(`.gputrace`) is analysed pass by pass: find the first render pass whose output
is wrong, fetch its actual bound textures and constants, and re-run that pass's
HLSL math on the CPU from those inputs. If the simulation differs from the GPU
output, the defect is a Metal/DXMT translation problem and belongs here. If it
matches, the shader is doing what its source says, and the defect is in its
inputs, its design, or an interaction between mods; that is recorded
explicitly. After the fix, the same scene is captured again and the recorded
numbers must move (for example, heat at the scope centre 0.0 → 1.0). The
numbers are kept in an evidence document listed in the entry's
`gamma-entry.toml`, and a confirmed trace sets `trace-verified`.

### 4. In-game verification

Every fix has a documented A/B scenario: reproduce the broken condition on the
stock files, confirm it, apply the fix, and confirm the specific symptom is
gone under real gameplay conditions (time of day, weather, weapon/optic, etc.)
chosen to actually hit the failure path.

### Provenance

Every changed line is tagged `[elseform]` with a short rationale, so a diff
against the unmodified upstream file shows exactly what changed and why.
Fixes are surgical — no unrelated cleanup or rewrite of upstream logic.

---

## Русский

Это минимальные точечные патчи сторонних HLSL-шейдеров, чтобы они
компилировались и рендерились корректно под D3DMetal/DXMT на macOS. Каждый
фикс проходит одни и те же четыре этапа проверки, прежде чем считается
стабильным.

### 1. Офлайн-компиляция

До запуска игры каждый изменённый шейдер компилируется через те же два
этапа, что использует сам движок:

- **HLSL в DXBC** — настоящий `d3dcompiler_47.dll` с макросами препроцессора
  самого движка, вне игры.
- **DXBC в Metal shader library** — собственный транслятор `airconv` из
  [DXMT](https://github.com/3Shain/dxmt), включая связывание между стадиями
  для пар vertex/geometry и vertex/hull/domain.

Это ловит ошибки компиляции и сбои трансляции в Metal IR ещё до загрузки
сохранения.

### 2. Определение шейдера в рантайме

Часть поломок проявляется только в рантайме, а текст ошибки Metal никогда не
называет сам шейдер — DXMT определяет пайплайны по хешу содержимого, а не по
имени файла. Чтобы найти виновника: захватить лог упавшего запуска с точной
парой vertex/pixel-хешей, сопоставить эти хеши с кешем скомпилированных
шейдеров и восстановить реальный исходный файл, затем сравнить выходную
структуру vertex-шейдера со входной структурой pixel-шейдера — именно такой
класс несовпадений D3D11/DXVK молча терпят, а строгая привязка семантических
регистров в Metal — нет.

### 3. Диагностика и подтверждение по GPU-трассам

До и после фикса анализируется захват реального игрового кадра Metal
(`.gputrace`) проход за проходом: находится первый проход рендера с неверным
результатом, извлекаются реально привязанные текстуры и константы, и математика
HLSL этого прохода пересчитывается на CPU по этим входным данным. Если расчёт
расходится с выводом GPU, это дефект трансляции Metal/DXMT, и фикс относится
сюда. Если совпадает, шейдер делает то, что написано в исходнике, а дефект во
входных данных, в замысле или во взаимодействии модов; это фиксируется явно.
После фикса та же сцена захватывается снова, и записанные числа должны
измениться (например, тепло в центре прицела 0.0 → 1.0). Числа сохраняются в
документе с доказательствами, указанном в `gamma-entry.toml` записи, а
подтверждённая трасса выставляет `trace-verified`.

### 4. Проверка в игре

У каждого фикса есть задокументированный A/B-сценарий: воспроизвести поломку
на исходных файлах, подтвердить её, применить фикс и подтвердить, что именно
этот симптом исчез — в реальных игровых условиях (время суток, погода,
оружие/оптика и т.д.), подобранных так, чтобы действительно попасть в путь
возникновения поломки.

### Происхождение изменений

Каждая изменённая строка помечена тегом `[elseform]` с кратким обоснованием,
поэтому diff с немодифицированным исходным файлом сразу показывает, что и
зачем изменено. Фиксы хирургические — без побочной чистки или переписывания
чужой логики.

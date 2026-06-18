# VOIDRUNNER

**VOIDRUNNER** is a native Linux procedural space-trader / combat game squeezed into a **32 KiB runnable**.

It is an Elite-flavoured tiny game experiment: dock, trade, equip your ship, launch into a generated solar system, survive the run, fight or avoid contacts, dock again, and keep pushing your commander forward.

The point is not just that it is small.

The point is that it is still recognisably a game.

> Current release artefact: **32 KiB class**.
> The fullscreen BCJ+tight-stub build measured **32,716 bytes**, leaving **52 bytes** under the 32 KiB line.
> Earlier builds lived in the 40K class; this is now a proper 32K-class release.

[![UI Preview](https://github.com/pinguy/VOIDRUNNER/blob/main/screenshots/Screenshot_20260616_191614.png?raw=true)](https://github.com/pinguy/VOIDRUNNER/blob/main/screenshots/Screenshot_20260616_191614.png?raw=true)

---

## What it is

VOIDRUNNER is a single-C-file native Linux game with no asset files.

Everything is generated or embedded in code:

* procedural star systems
* generated planet / station placement
* procedural station forms
* procedural ship contacts
* trading economy
* persistent commander state
* combat loop
* shield / energy survival model
* radar / scanner
* docked station menus
* title screen with seed / commander entry
* fullscreen launch
* tiny HUD / text renderer
* self-extracting compressed runner

The final runnable is a tiny shell self-extractor containing a compressed native ELF payload.

---

## Size claim

The current release build is a **32 KiB runnable**.

The size budget refers to the generated runner file, not the system libraries already present on Linux.

Expected direct ELF dependency after build:

```text
NEEDED: libc.so.6
```

The game still expects the usual Linux runtime pieces to exist on the target system, especially SDL2, OpenGL, and `xz` for the self-extracting runner.

Exact byte count can vary if rebuilt with different compiler, linker, binutils, shell, or xz versions. The release artefact is the measured target.

---

## Running

```sh
chmod +x ./VOIDRUNNER
./VOIDRUNNER
```

The game starts fullscreen.

Press `ESC` to quit from any screen.

---

## Building

A typical package contains:

```text
voidrunner.c
start_syscall.S
build_asm_syscall.sh
pack.sh
tiny_tools/sstrip64.py
compat/
REBUILD_ME.sh
```

To rebuild:

```sh
sh ./REBUILD_ME.sh
```

The release package rebuild script verifies the packed runner after generation.

---

## Controls

### Title screen

```text
ENTER       start / launch commander
TAB         switch name / seed field
BACKSPACE   delete character
ESC         quit
```

### Docked station menus

```text
0           command slate
1           market
2           equip ship
3           data on current system
4           manifest
J           chart / route map
F           launch
BACKSPACE   back / command
ARROWS      menu navigation / buy / sell where applicable
ENTER       confirm where applicable
ESC         quit
```

### Flight

```text
WASD        thrust / strafe
Mouse       look
Q / E       roll
SHIFT       boost
LMB         fire laser
SPACE       fire laser fallback
RMB         fire missile
TAB         target nearest contact
J           chart / jump route
F           dock when cleared
ESC         quit
```

---

## Survival model

VOIDRUNNER uses a simple shield / energy model.

Your shield absorbs incoming hits first.

Once the shield is gone, hits chew directly into ship energy. When energy reaches zero, the run ends.

That is the only death condition. No fake hidden hull bar, no decorative damage number pretending to matter.

---

## Why it got small

```text
custom _start             removes CRT startup baggage
strip                     removes symbol/debug baggage
sstrip                    removes ELF section headers
x86 BCJ filter            makes call/jump targets compress better
LZMA/XZ tuning            improves payload compression
tight shell stub          trims wrapper bytes
single C file             gives the compressor one dense code corpus
feature discipline        keeps only what earns its bytes
```

The x86 BCJ filter was a major free win: it rewrites relative call/jump targets into a form that LZMA can compress more effectively.

Assembly was only useful where it proved smaller.

Cargo-cult assembly was rejected.

---

## Status

VOIDRUNNER is playable, experimental, and deliberately ridiculous.

It is small enough that an ordinary screenshot can be larger than the game itself.

That is the joke.

That is also the achievement.

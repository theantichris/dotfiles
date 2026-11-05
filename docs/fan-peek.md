# Fan / Peek prototype

A temporary, keyboard-driven spread of floating surfaces on the focused monitor's
current workspace. The normal three-slot, 80px cascade is unchanged.

## Controls

| Key | Action |
| --- | --- |
| Super+Shift+Tab | Open Fan; press again while holding the modifiers to advance |
| Tab, L/J, Right/Down | Next surface |
| Shift+Tab, H/K, Left/Up | Previous surface |
| Enter | Restore positions and focus/raise the selected surface |
| Escape (with or without modifiers) | Restore positions, original focus and stacking |
| Super+Ctrl+Escape | Restore and lock through the existing Noctalia command |

Release the activation modifiers before using the plain navigation keys.
Navigation wraps in spatial order (original X, then Y, then address). Selection
uses actual focus, so the existing border, opacity and magenta halo identify it.
The Fan submap temporarily replaces ordinary window shortcuts; those return on
exit. No shortcuts outside this submap were replaced.

## Behavior and boundaries

`config/fan.lua` snapshots positions, focus and local stacking, then moves windows
into a diagonal spread bounded by the monitor's usable logical area, including
scale, rotation, panel reservations and a 16px margin. The long axis uses available
space; the secondary stagger is capped at 160px. Dimensions are never changed.
The existing native movement animation is used without changing its curve.

Fullscreen/maximized workspaces and visible special workspaces are left alone.
Pinned, hidden, grouped, tiled, non-input, fullscreen and game windows do not
participate. Fewer than two eligible windows is a no-op. Oversized windows or a
spread with less than 48px per step produce a short native notification instead
of resizing or spilling onto another monitor. Widely differing window sizes can
still obscure smaller surfaces; this is a move-only spread, not an overview of
scaled thumbnails. Four default 1600x900 windows have about 603px horizontal
separation on the external display, versus 96px on the laptop panel at scale 2.

Both dismissal paths restore surviving eligible windows' original positions.
Confirm raises the chosen surface after restoration. Closing a participating
window cancels the presentation and restores survivors. Opening a window on the
same workspace/monitor cancels it and lets normal launch/cascade behavior proceed.
Context, fullscreen, pin, floating-state and workspace changes also dismiss Fan;
windows that have left the original workspace/monitor or become fullscreen are
not pulled back. Config unload restores an active presentation before Lua state
is discarded. A client that resizes itself retains that size: Fan never issues a
resize to override application requests.

Native focus changes update application focus and Hyprland's recent-focus history.
Cancel restores the original focused window and stacking among participating
surfaces, but cannot undo focus notifications or restore the complete MRU history.
The stacking snapshot follows the installed 0.57.1 implementation; it is not an
explicitly documented ordering contract for future releases. X11 transient stacks
can be raised as a unit by Hyprland, so their precise stacking is not guaranteed.

## Integration and recovery

The only integration is `require("config.fan")` immediately after the cascade in
`hyprland.lua`. Removing that line disables the experiment on the next deployment
and reload. No cascade, palette, animation or normal focus bindings were changed.
The source is integrated; it has **not** been deployed with chezmoi or loaded
permanently into the desktop. Permanent activation requires deploying the new
module and updated entrypoint through the usual approved workflow.

For a stuck submap, the documented Hyprland recovery command is:

```sh
hyprctl dispatch 'hl.dsp.submap("reset")'
```

The submap-change listener restores any active Fan session. A configuration reload
also invokes the unload restoration handler. `fan.dispose()` supports temporary
live testing: it restores the session and removes the module's own subscriptions
and bindings without reloading the desktop.

## Verification — 2026-11-05

Installed compositor: Hyprland 0.57.1, commit
`acc1aa0bfd4bd575dcb0f76c35ccf12b660a1ab9`. Two live displays: external
3440x1440 at scale 1; laptop 3840x2400 at scale 2, both with a 35px top reservation.

| Check | Evidence |
| --- | --- |
| Activate/dismiss with 2, 3, 4 surfaces | Passed in live compositor using disposable Kitty windows on unused workspace 98 |
| Next/previous, confirm/cancel | Passed via the same module callbacks used by keyboard bindings; focus checked through IPC |
| Exact original position and dimensions | Passed for 2, 3, 4 live windows after both cancel and confirm |
| Original stacking on cancel | Passed for 2, 3, 4 live windows |
| Window closes during Fan | Passed live; surviving geometries restored |
| Window opens during Fan | Passed live; previous geometries restored and normal launch retained |
| Workspace/monitor departure | Passed live; focusing the laptop monitor restored the test workspace |
| Unrelated applications | Live snapshots confirmed geometry, workspace and monitor assignments unchanged |
| Existing cascade/focus integration | Live tests ran alongside the deployed cascade and focus-raising handler |
| Test cleanup | Verified all disposable windows and module bindings removed; previous workspace/application focus restored |
| Both screen sizes, cancellation stacking | Passed Lua state-machine tests using the two actual monitors' dimensions |
| Exclusions, workspace moves, unload | Passed simulated events in Lua tests |
| Lua syntax/native binding registration | `luac -p` and Hyprland `--verify-config`: passed, including the complete rendered config with the live generated Noctalia theme |
| Physical keyboard input, subjective animation quality | Untested; live tests invoked callbacks, not keyboard hardware |
| Real terminal/editor/browser workflows | Disposable terminal lifecycle tested; sustained everyday use and browser/editor content recognition untested |
| Rotated monitors, hot unplug, X11 transients | Untested live |

Run the repeatable state-machine checks from the checkout:

```sh
lua tests/fan.lua
```

The live tests loaded the module temporarily with `dofile`, used disposable test
windows, and called `dispose()` afterward. No chezmoi apply or desktop reload was
performed. The offline config verifier reported its expected unavailable IPC socket; parsing completed with `config ok`. Kitty's ordinary close request presented a running-process confirmation
for the test `sleep` process; the harness was corrected to terminate only its own
Kitty processes. This was a test-harness issue, not a Fan dismissal failure.

## Upstream evidence and future direction

- [Lua submaps and recovery](https://wiki.hypr.land/configuring/core/binds/submaps/)
- [Events and config unload](https://wiki.hypr.land/configuring/core/advanced-configuration/events/)
- [Movement, focus and stacking dispatchers](https://wiki.hypr.land/configuring/core/dispatchers/)
- Version-matched source: [query order](https://github.com/hyprwm/Hyprland/blob/v0.57.1/src/config/lua/bindings/LuaBindingsQuery.cpp),
  [stack implementation](https://github.com/hyprwm/Hyprland/blob/v0.57.1/src/desktop/state/WindowState.cpp),
  [absolute movement](https://github.com/hyprwm/Hyprland/blob/v0.57.1/src/config/shared/actions/ConfigActions.cpp),
  [monitor dimensions](https://github.com/hyprwm/Hyprland/blob/v0.57.1/src/config/lua/objects/LuaMonitor.cpp).

Compositor-level presentation transforms would materially help on the laptop:
they could scale surfaces into recognizable previews without resizing application
content, and separate selection from application focus/MRU history. Rotation or
perspective alone would add little practical value. A plugin is unnecessary to
try this interaction, but native move/focus dispatchers cannot provide that
independent presentation layer.

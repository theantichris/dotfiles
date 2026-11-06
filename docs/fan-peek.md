# Fan / Peek prototype

A temporary, keyboard-driven spread of floating surfaces on the focused monitor's
current workspace. The normal three-slot, 80px cascade is unchanged.

## Controls

| Key | Action |
| --- | --- |
| Super+Shift+Tab | Open Fan |
| L/J | Next surface |
| H/K | Previous surface |
| Enter | Restore positions and focus/raise the selected surface |
| Escape (with or without modifiers) | Restore positions, original focus and stacking |
| Super+Ctrl+Escape | Restore and lock through the existing Noctalia command |
| Print / Super+Print | Existing region / fullscreen screenshot shortcuts |

Release the activation modifiers before using the plain navigation keys.
Navigation wraps in spatial order (original X, then Y, then address). Selection
uses actual focus, so the existing border, opacity and magenta halo identify it.
The Fan submap temporarily replaces ordinary window shortcuts; those return on
exit. Screenshot bindings are available across submaps without duplicate entries.

## Behavior and boundaries

`config/fan.lua` snapshots positions, focus and local stacking, then centers the
selected surface in the monitor's usable logical area. Other surfaces occupy
slots on either side, using the original spatial order as a cyclic sequence.
Every selection recomposes the fan: next arrives from the right and previous from
the left (with two surfaces, both navigation directions select the sole neighbor).
Outer surfaces stack behind inner ones, and the selected surface stays in front.

Slot spacing comes from the available width after accommodating the widest
window and the required number of slots on each side. Background surfaces share
a top anchor based on the tallest window, with a shallow upward stagger so header
strips remain exposed even when window sizes differ. The two sides have a small
vertical offset from each other. The depth step is bounded by 4.5% of usable
height and the available headroom. Scale, rotation, panel reservations, monitor
origin and a 16px margin are included. Dimensions never change; movement uses the
existing native animation without changing its curve.

Fullscreen/maximized workspaces and visible special workspaces are left alone.
Pinned, hidden, grouped, tiled, non-input, fullscreen and game windows do not
participate. Fewer than two eligible windows is a no-op. Oversized windows or a
fan with less than 48px between horizontal slots produce a short native notification instead
of resizing or spilling onto another monitor. This remains a move-only
presentation: it cannot expose whole full-size applications simultaneously.

For four/five default 1600x900 windows, the external display provides 452px slot
spacing. The selected window is fully exposed and each inactive surface retains
about 33% geometrically unobscured area. On the laptop panel at scale 2, slot
spacing is only 72px and inactive exposure drops to about 7–9%. Header strips are
visible in the terminal test capture, but distinguishing real browser/editor
contents at that density is constrained. Highly variable sizes and windows as
tall as the usable area can further reduce recognizable content. More substantial
previews would require smaller application windows or presentation scaling; this
iteration introduces neither resizing nor a compositor plugin.

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
Confirming a different surface briefly refocuses the pre-Fan window before the
selection, so Alt+Tab returns to that pre-Fan window when it is still eligible on
the same workspace and monitor. This focus-history behavior is covered by the Lua
tests; this iteration does not change it.
Cancel restores the original focused window and stacking among participating
surfaces, but cannot undo focus notifications or restore the complete MRU history.
The stacking snapshot follows the installed 0.57.1 implementation; it is not an
explicitly documented ordering contract for future releases. X11 transient stacks
can be raised as a unit by Hyprland, so their precise stacking is not guaranteed.

## Integration and recovery

The only integration is `require("config.fan")` immediately after the cascade in
`hyprland.lua`. Removing that line disables the experiment on the next deployment
and reload. No cascade, palette, animation or normal focus bindings were changed.
The existing prototype is already deployed. The 2026-11-06 spatial refinement was
loaded only temporarily for live tests; its source changes have not been deployed
with chezmoi or reloaded permanently.

For a stuck submap, the documented Hyprland recovery command is:

```sh
hyprctl dispatch 'hl.dsp.submap("reset")'
```

The submap-change listener restores any active Fan session. A configuration reload
also invokes the unload restoration handler. `fan.dispose()` supports temporary
live testing: it restores the session and removes the module's own subscriptions
and bindings without reloading the desktop.

## Spatial refinement verification — 2026-11-06

Hyprland remains 0.57.1 with the two display geometries listed below. Tests loaded
the revised module temporarily and used disposable Kitty windows on workspace 98.
Both monitors' original visible workspaces and the original application focus were
restored; test windows and bindings were removed afterward.

| Check | Result |
| --- | --- |
| Two, three, four, five windows on each monitor | Passed live, including every selection in a complete navigation cycle |
| Selected surface centered and topmost | Passed live for every selection; no dimension changes |
| Display boundaries | Passed live on both monitors, including panel reservations and scale |
| Inactive exposure | All surfaces retained nonzero unobscured area; external 4/5-window exposure about 33%, laptop 7–9% |
| Visual inspection | Five-window captures inspected on both monitors; central selection and exposed terminal labels confirmed |
| Confirm/cancel | Passed live; exact original geometry, dimensions, focus on cancel, and stacking on cancel restored |
| Open/close, workspace/monitor departure | Passed live on both monitors; survivors restored |
| Unrelated applications | Geometry, workspace and monitor assignments unchanged in before/after snapshots |
| Rotation, negative origins, asymmetric reservations, mixed sizes | Passed Lua simulation; every selection checked for centering, boundaries and nonzero exposed area |
| Navigation repeatability and previous-focus behavior | Passed Lua tests; complete cycles returned to the same composition |
| Native validation | Lua syntax, Hyprland config verifier and `git diff --check` passed |
| Remaining hands-on evaluation | Physical keyboard input, perceived motion during ordinary work, and identification of real editor/browser content |

Exposure percentages treat rectangles as opaque and account for their actual
stacking order; they do not count content seen through terminal transparency.
The existing curves, controls, dismissal paths, palette, borders and opacity
were not changed. Tests invoked the same module callbacks used by the bindings.

## Initial prototype verification — 2026-11-05

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

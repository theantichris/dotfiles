-- Ensure the dedicated Kitty scratchpad receives focus when its window is
-- created. On first launch after boot, Kitty is spawned asynchronously and can
-- appear after the special workspace has already been toggled visible.
hl.on("window.open", function(window)
    if window.class == "kitty-scratchpad" then
        hl.dispatch(hl.dsp.focus({ window = window }))
    end
end)

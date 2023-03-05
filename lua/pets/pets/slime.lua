return {
    next_actions = {
        idle_blink = { "idle_wobble", "walk", "walk_left", "run", "run_left" },
        idle_wobble = { "idle_blink", "walk", "walk_left", "run", "run_left" },
        walk = { "idle_blink", "run" },
        run = { "walk", "run_left", "idle_wobble" },
        walk_left = { "run_left", "idle_blink", "idle_wobble" },
        run_left = { "walk_left", "run", "idle_wobble" },
    },
    idle_actions = { "idle_wobble", "idle_blink" },
    movements = {
        right = {
            normal = { "walk" },
            fast = { "run" },
        },
        left = {
            fast = { "run_left" },
            normal = { "walk_left" },
        },
    },
}

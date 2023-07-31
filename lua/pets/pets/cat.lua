return {
    next_actions = {
        crouch = { "liedown", "sneak", "sit" },
        idle = { "idle_blink", "walk", "sit", "walk_left" },
        idle_blink = { "idle", "walk", "sit" },
        liedown = { "sneak", "crouch" },
        sit = { "idle", "idle_blink", "crouch", "liedown" },
        sneak = { "crouch", "walk", "liedown" },
        walk = { "idle", "idle_blink" },
        walk_left = { "walk_left", "idle" },
    },
    idle_actions = { "idle", "idle_blink", "sit", "liedown" },
    first_action = "idle",
    movements = {
        right = {
            normal = { "walk" },
        },
        left = {
            normal = { "walk_left" },
        },
    },
}

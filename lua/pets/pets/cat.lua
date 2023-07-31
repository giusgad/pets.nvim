return {
    next_actions = {
        crouch = { "liedown", "sneak", "sit" },
        idle = { "idle_blink", "walk", "sit" },
        idle_blink = { "idle", "walk", "sit" },
        liedown = { "sneak", "crouch" },
        sit = { "idle", "idle_blink", "crouch", "liedown" },
        sneak = { "crouch", "walk", "liedown" },
        walk = { "idle", "idle_blink" },
    },
    idle_actions = { "idle", "idle_blink", "sit", "liedown", "sneak" },
    first_action = "idle",
    movements = {
        normal = { "walk" },
        fast = { "run" },
        -- right = {
        --     normal = { "walk" },
        --     fast = { "run" },
        -- },
        -- left = {
        --     normal = { "walk_left" },
        --     fast = { "run_left" },
        -- },
    },
}

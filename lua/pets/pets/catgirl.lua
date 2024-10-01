return {
    next_actions = {
        idle = { "idle", "sit", "liedown", "walk", "walk_left" },
        liedown = { "liedown", "sit", "idle" },
        sit = { "sit", "walk", "liedown" },
        walk = { "walk", "idle" },
        walk_left = { "walk_left", "idle" },
    },
    idle_actions = { "idle", "sit", "liedown" },
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

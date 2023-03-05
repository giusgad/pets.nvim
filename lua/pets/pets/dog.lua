return {
    next_actions = {
        idle = { "sit", "liedown", "walk", "run", "pee", "walk_left" },
        liedown = { "sit", "idle" },
        pee = { "idle", "sit", "walk" },
        run = { "walk", "idle", "run_left" },
        sit = { "walk", "liedown", "pee" },
        walk = { "run", "idle" },
        run_left = { "walk_left", "run" },
        walk_left = { "run_left", "idle" },
    },
    idle_actions = { "idle", "sit", "liedown" },
    movements = {
        right = {
            normal = { "walk" },
            fast = { "run" },
        },
        left = {
            normal = { "walk_left" },
            fast = { "run_left" },
        },
    },
}

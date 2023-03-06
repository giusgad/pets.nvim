return {
    next_actions = {
        idle = { "idle", "sit", "liedown", "walk", "run", "pee", "walk_left" },
        liedown = { "liedown", "sit", "idle" },
        pee = { "pee", "idle", "sit", "walk" },
        run = { "run", "walk", "idle", "run_left" },
        sit = { "sit", "walk", "liedown", "pee" },
        walk = { "walk", "run", "idle" },
        run_left = { "run_left", "walk_left", "run" },
        walk_left = { "walk_left", "run_left", "idle" },
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

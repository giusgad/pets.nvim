return {
    next_actions = {
        idle = { "sit", "liedown", "walk", "run", "pee" },
        liedown = { "sit", "idle" },
        pee = { "idle", "sit" },
        run = { "walk", "idle" },
        sit = { "walk", "liedown", "pee" },
        walk = { "run", "idle" },
    },
    sleeping_animations = { "idle", "sit", "liedown" },
}

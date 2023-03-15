return {
    next_actions = {
        idle = { "idle", "swipe", "walk", "walk_fast" },
        run = { "walk", "walk_fast" },
        swipe = { "walk", "idle" },
        walk = { "idle", "run", "walk_fast" },
        walk_fast = { "walk", "run", "idle" },
    },
    idle_actions = { "idle", "swipe" },
    first_action = "idle",
}

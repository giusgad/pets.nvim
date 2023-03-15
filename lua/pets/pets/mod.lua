return {
    next_actions = {
        idle = { "idle", "swipe", "walk", "walk_left", "walk_fast", "walk_fast_left" },
        run = { "run", "walk", "walk_fast", "run_left" },
        swipe = { "swipe", "walk", "idle", "walk_left" },
        walk = { "walk", "idle", "run", "walk_fast", "walk_left" },
        walk_fast = { "walk_fast", "walk", "run", "walk_fast_left", "idle" },
        run_left = { "run_left", "run", "walk_fast_left", "walk_left" },
        walk_fast_left = { "walk_fast_left", "run_left", "walk_fast", "walk_left", "idle" },
        walk_left = { "walk_left", "walk_fast_left", "run_left", "walk", "idle" },
    },
    idle_actions = { "idle", "swipe" },
    first_action = "idle",
    movements = {
        right = {
            normal = { "walk_fast" },
            fast = { "run" },
            slow = { "walk" },
        },
        left = {
            normal = { "walk_fast_left" },
            fast = { "run_left" },
            slow = { "walk_left" },
        },
    },
}

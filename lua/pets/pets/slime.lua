return {
    next_actions = {
        idle_blink = { "idle_blink", "idle_wobble", "walk", "walk_left", "run", "run_left" },
        idle_wobble = { "idle_wobble", "idle_blink", "walk", "walk_left", "run", "run_left", "divide" },
        walk = { "walk", "idle_blink", "run" },
        run = { "run", "walk", "run_left", "idle_wobble", "divide" },
        walk_left = { "walk_left", "run_left", "idle_blink", "idle_wobble" },
        run_left = { "run_left", "walk_left", "run", "idle_wobble", "divide" },
        --
        divide = { "split_walk", "split_idle" },
        split_walk = { "split_walk", "split_idle", "split_swap", "join" },
        split_idle = { "split_idle", "split_walk", "split_swap" },
        split_swap = { "split_walk", "split_idle", "join" },
        join = { "idle_wobble" },
    },
    idle_actions = { "idle_wobble", "idle_blink" },
    first_action = "idle_blink",
    movements = {
        right = {
            normal = { "walk" },
            fast = { "run" },
            slow = { "split_walk" },
        },
        left = {
            fast = { "run_left" },
            normal = { "walk_left" },
        },
    },
    get_death_animation = function(current_action)
        local split_animations = { "split_idle", "divide", "split_walk", "split_swap" }
        if vim.tbl_contains(split_animations, current_action) then
            return "split_die"
        end
        return "die"
    end,
}

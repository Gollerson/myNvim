return {
  "sphamba/smear-cursor.nvim",

  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears and particles will look a lot less blocky.
    legacy_computing_symbols_support = true,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,

    particles_enabled = true, -- When true, better to also set `never_draw_over_target` to true,
    particle_max_num = 100,
    particle_spread = 2, -- 0: no spread, 1: spread over entire cursor,
    particles_per_second = 200,
    particles_per_length = 1.0, -- per character width,
    particle_max_lifetime = 1000, -- milliseconds,
    particle_lifetime_distribution_exponent = 5,
    particle_max_initial_velocity = 10, -- characters width per second,
    particle_velocity_from_cursor = 0.2, -- 0: none, 1: full,
    particle_random_velocity = 100, -- characters width per second,
    particle_damping = 0.2,
    particle_gravity = 20, -- characters width per second squared,
    min_distance_emit_particles = 1.5, -- character widths,
    particle_switch_octant_braille = 0.6, -- fraction of lifetime, used if `legacy_computing_symbols_support` is true,
    particles_over_text = false,
  },
}

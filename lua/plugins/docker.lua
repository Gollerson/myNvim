return {
  -- Docker integration for dev containers
  {
    "jamestthompson3/nvim-remote-containers",
    -- Lazy load when commands are used
    cmd = {
      "AttachToContainer",
      "BuildImage",
      "StartImage",
      "ComposeUp",
      "ComposeDown",
      "ComposeDestroy",
    },
  },
}

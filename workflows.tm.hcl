script "init" {
  name        = "OpenTofu Init"
  description = "Downloads the required provider plugins and modules and setting up the backend"

  job {
    commands = [
      ["tofu", "init", "-lock-timeout=5m"],
    ]
  }
}

script "init" "upgrade" {
  name        = "OpenTofu Init"
  description = "For local dev, upgrade the provider plugins and modules"

  job {
    commands = [
      ["tofu", "init", "-upgrade"],
    ]
  }
}

script "plan" {
  name        = "OpenTofu Plan"
  description = "Run a plan locally with Terramate"

  job {
    commands = [
      # if the .terraform folder doesn't exist, run tofu init
      ["sh", "-c", "[ -d .terraform ] || tofu init"],
      ["tofu", "plan", "-lock=false", {
        enable_sharing = true
        mock_on_fail   = true
      }],
    ]
  }
}

script "apply" {
  name        = "OpenTofu Plan"
  description = "Run a plan locally with Terramate"

  job {
    commands = [
      # if the .terraform folder doesn't exist, run tofu init
      ["sh", "-c", "[ -d .terraform ] || tofu init"],
      ["tofu", "apply", "-input=false", "-auto-approve", "-lock-timeout=5m", {
        enable_sharing = true
        mock_on_fail   = true
      }],
    ]
  }
}

# terramate-output-sharing-example
Simple example showing how to share state between stacks


## Requirements

You need to have both Terramate and OpenTofu (or Terraform) 
installed. I highly recommend using 
[tenv](https://github.com/tofuutils/tenv) to install and 
manage all of these tools.

## Run the demo

In this example we have two stacks:
1) parent - which creates a random pet name and outputs it
2) child - which depends on parent and outputs it

To run the example, do:

```bash
make plan pet
```

Note that because the parent stack hasn't actually generated a 
pet name yet, it will use the mock value defined in the 
input.tm.hcl file in the child stack.

```hcl
input "pet_name" {
  backend       = "public"
  from_stack_id = "942a114c-93c4-4e8e-9e07-1c3423d700a5"
  mock          = "happy-panda-foo"
  value         = outputs.pet_name.value
}
```

The output of `make plan pet` will be:

```
Changes to Outputs:
  + child_pet_name = "happy-panda-foo"
```

To apply the changes, run:

```bash
make apply pet
```

Then note that the output of the child stack will have changed:
```hcl
Outputs:

child_pet_name = "winning-shrew"
```

## Orchestration

Just in case you're curious about how 
[orchestration works](https://terramate.io/docs/cli/orchestration/), 
it's all handled by the `stack.tm.hcl` files.

```hcl
stack {
  name        = "parent"
  description = "I make the random pet name"
  id          = "942a114c-93c4-4e8e-9e07-1c3423d700a5"

  # these are tags you can use to run one or more stacks
  tags = [
    "pet",
    "parent",
  ]

  # this stack must be applied before the child stack
  before = [
    "tag:child"
  ]
}
```

When running the script:
```bash
make plan pet
```

Terramate will look for all stacks with the `pet` tag, 
then it will run all the stacks in order based on the 
orchestration defined in the `stack.tm.hcl` files.

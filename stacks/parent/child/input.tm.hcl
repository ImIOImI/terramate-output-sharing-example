input "pet_name" {
  backend       = "public"
  from_stack_id = "942a114c-93c4-4e8e-9e07-1c3423d700a5"
  mock          = "happy-panda-foo"
  value         = outputs.pet_name.value
}

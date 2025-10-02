stack {
  name        = "parent"
  description = "I make the random pet name"
  id          = "942a114c-93c4-4e8e-9e07-1c3423d700a5"

  tags = [
    "pet",
    "parent",
    "works",
    "broken",
  ]

  before = [
    "tag:child"
  ]
}

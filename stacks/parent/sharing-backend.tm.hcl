sharing_backend "public" {
  command = [
    "tofu",
    "output",
    "-json",
  ]
  filename = "_public.tf"
  type     = terraform
}
output "pet_name" {
  backend = "public"
  value   = random_pet.this.id
}

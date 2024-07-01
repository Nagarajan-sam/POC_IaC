resource "tls_private_key" "this" {
  count = var.create_keypair ? 1 : 0
  algorithm = "ED25519"
}

module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"

  create          = var.create_keypair
  key_name        = var.instance_key_name
  public_key      = try(tls_private_key.this[0].public_key_openssh, "")
}
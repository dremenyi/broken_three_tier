// Define the SSH key pair for our instances

resource "aws_key_pair" "bastion" {
  key_name   = "2w-bastion-roc-training"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeJ+ZQePKYIAi6foaSH+twdW5bTgoaHyGO871GsejtVAm0nBXYMfkDMGEC0EVc15aC/1vPTxB4K1/wijtXVTloi/2j7ULeWQJTo7N+6noun6Qwa1D0b5yANDz+b5qaK7244/xVvdCNL4n95J3F+JLCa5xSEBdngR39hXpvYfUsznJ/M0LaPmlReO+Xkmo4WysH7Ru2l7Nahq8is1WUm0vigITvx85oF42iQoT9Q3iY1h8oH/IaMhkZ/QKw8C4hdURm01MSnPqkU8CGy2KkCFCVYS4jVDhv1XOra/Y+67g53XiDimUWMZNfkeLskdSCaz5G0ZDnXDF5nrWeBoa0ytZ/ 2w-training"
}

resource "aws_key_pair" "internal" {
  key_name   = "2w-internal-roc-training"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfL0fvWu86/f23GEV8iaxEC3/pOyGmzk3acrlmzjx71hNMAnKUujWMr0peKlRyMd/+oBzB6CYf9hVMY5+63zvFM+JrvW+U5C4DCE79maocaIkuuYejYoKmzsroVTMlXKUqCSUpP8txIHmylWzfX9WPK9gzSTP5X/8GwlOB/KgplFgxf2zL87Qrh3E6r8vOzuPkbACfvRYCo0ZHNDx6hyR/IprbxX0bwGnOren9HfTyz/7hhJ5MV4ksrNdFf/JoKO7hwEIBOxF8Fc/mtpwjBfJEfOGn/JeIQmQzUX1XbwYGK0gSbDk2h3J4PM4lO9ac+vcYLpd4csSxfgQcFueLWBlf/ 2w-training"
}
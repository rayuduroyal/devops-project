output "abc" {
  value = "HELLO\nworld"
}

output "abc1" {
  value = "hello"
}

variable "abc" {
  default = "100"
}

output "abc" {
  value = var.abc
}
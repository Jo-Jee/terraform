output "k8s-masters" {
  value = join("\n", aws_instance.k8s-master.*.public_ip)
}

output "test" {
  value = "1"
}

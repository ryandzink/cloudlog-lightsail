data "external" "my_public_ip" {
  program = ["bash", "-c", "curl -s 'https://ipinfo.io/json'"]
}

data "aws_vpc" "internal" {
  default = true
}


/*data "template_file" "userdata" {
  template = "${file("${path.module}/user_data.txt")}"
  vars = {
    mysql_host = "${aws_rds_cluster.database.endpoint}"
    mysql_user = "${local.mysql_user}"
    mysql_password = "${local.mysql_password}"
  }
}*/
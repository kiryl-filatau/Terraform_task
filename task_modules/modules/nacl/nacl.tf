variable "nacl_name"    {default = "kf_nacl" }
variable "vpc_id"       {}
variable "subnet_ids"   {
    type = "list"
}
variable "nacl_cidr"    {}

#creating NACL
resource "aws_network_acl" "kf_nacl" {
    vpc_id          = "${var.vpc_id}"
    subnet_ids      = ["${var.subnet_ids}"]
    egress {
        protocol    = "-1"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "${var.nacl_cidr}"
        from_port   = 0
        to_port     = 0
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 100
        action      = "allow"
        cidr_block  = "${var.nacl_cidr}"
        from_port   = 80
        to_port     = 80
    }

    ingress {
        protocol    = "tcp"
        rule_no     = 110
        action      = "allow"
        cidr_block  = "${var.nacl_cidr}"
        from_port   = 22
        to_port     = 22
    }

#Allows inbound return traffic from hosts on the Internet that are responding to requests originating in the subnet.
    ingress {
        protocol    = "tcp"
        rule_no     = 120
        action      = "allow"
        cidr_block  = "${var.nacl_cidr}"
        from_port   = 1024
        to_port     = 65535
    }

    tags = {
        Name        = "${var.nacl_name}"
    }
}


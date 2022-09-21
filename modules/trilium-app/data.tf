data "aws_ec2_instance_type" "main" {
  instance_type = var.instance_type
}

data "aws_ami" "focal" {
  most_recent = true

  filter {
    name = "name"
    values = [
      format(
        "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-%s-server-*",
        data.aws_ec2_instance_type.main.supported_architectures[0] == "x86_64" ||
        data.aws_ec2_instance_type.main.supported_architectures[0] == "i386"
        ? "amd64"
        : data.aws_ec2_instance_type.main.supported_architectures[0],
      )
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # canonical
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "app_instance_profile" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    effect    = "Allow"
    resources = ["*"]
  }
}

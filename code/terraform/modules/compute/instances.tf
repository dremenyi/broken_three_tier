

data "aws_ami" "latest_redhat_ami" {
  most_recent = true
  owners      = ["309956199498"]

  filter {
    name   = "name"
    values = ["RHEL-8*"]

  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "latest_winserv_ami" {
  most_recent = true
  owners      = ["801119661308"]

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]

  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
       name   = "virtualization-type"
       values = ["hvm"]  
  }     

}


resource "aws_instance" "wp_server1" {
  ami           = data.aws_ami.latest_redhat_ami.id
  instance_type = var.instance_type
 
  root_block_device {
    volume_size = var.root_ebs_size
    volume_type = "gp3"
  }
  
  tags = {
    Name        = "wpserver1"
    Project     = "cf.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}
/*
resource "aws_instance" "wp_server2" {
  ami           = data.aws_ami.latest_redhat_ami.id
  instance_type = var.instance_type
 
  root_block_device {
    volume_size = var.root_ebs_size
    volume_type = "gp3"
  }
  
  tags = {
    Name        = "wpserver2"
    Project     = "cf.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_instance" "bastion1" {
  ami           = data.aws_ami.latest_winserv_ami.id
  instance_type = var.instance_type
 
  root_block_device {
    volume_size = var.root_ebs_size
    volume_type = "gp3"
  }
  
  tags = {
    Name        = "bastion1"
    Project     = "cf.io"
    Environment = var.infra_env
    ManagedBy   = "terraform"
  }
}

resource "aws_eip" "bastion_eip" {
  instance = aws_instance.bastion1.id
}
*/


// Old Code Below - Don't forget..
// Old Code Below - Don't forget..
// Old Code Below - Don't forget..
// Old Code Below - Don't forget..
// Old Code Below - Don't forget..








































/*

//Creates Volumes to be later attached.
resource "aws_ebs_volume" "expand-me" {
  availability_zone = "us-east-1a"
  size              = 8
  tags = {
    Name = "Expandable-Volume"
  }
}


//Defines the jumpbox to get into the internal network
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.LatestAMI.id
  instance_type          = "t2.micro"
  subnet_id              = data.terraform_remote_state.networking.outputs.public_subnet_id
  key_name               = data.terraform_remote_state.security.outputs.bastion_keypair
  vpc_security_group_ids = [data.terraform_remote_state.networking.outputs.public_sg_id]
  tags = {
    "Name" = "bastion"
  }
}




// define eip to utilize for bastion
resource "aws_eip" "bastion_eip" {
  instance   = aws_instance.bastion.id
  depends_on = [aws_instance.bastion]
  vpc        = true

}

//Define the database, feeds the webapp
resource "aws_instance" "db" {
  ami                    = data.aws_ami.LatestAMI.id
  instance_type          = "t3.small"
  subnet_id              = data.terraform_remote_state.networking.outputs.private_subnet_id
  key_name               = data.terraform_remote_state.security.outputs.internal_keypair
  vpc_security_group_ids = [data.terraform_remote_state.networking.outputs.private_sg_id]
  tags = {
    "Name" = "database"
  }
}

//Attaches "Expand-me (line 19)" to internal DB
resource "aws_volume_attachment" "expand-me-attach" {
  device_name = "/dev/sdc"
  volume_id   = aws_ebs_volume.expand-me.id
  instance_id = aws_instance.db.id
}

//Webserver for the public subnet
resource "aws_instance" "public_webserver" {
  ami                    = data.aws_ami.LatestAMI.id
  instance_type          = "t3.small"
  subnet_id              = data.terraform_remote_state.networking.outputs.private_subnet_id
  #key_name               = data.terraform_remote_state.security.outputs.bastion_keypair
  vpc_security_group_ids = [data.terraform_remote_state.networking.outputs.private_sg_id]
  user_data              = file("webserver.sh")
  tags = {
    "Name" = "public webserver"
  }
}

// define eip for webserver
resource "aws_eip" "public_webserver_eip" {
  instance   = aws_instance.public_webserver.id
  depends_on = [aws_instance.public_webserver]
  vpc        = true

}
*/
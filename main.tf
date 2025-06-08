resource "aws_instance" "minecraft_server" {

    depends_on = [ aws_key_pair.minecraft_server_keypair ]

    ami = "ami-0a7d80731ae1b2435" # public aws ami id for ubuntu 22 machine
    instance_type = var.vm_size
    key_name = aws_key_pair.minecraft_server_keypair.key_name
    associate_public_ip_address = true
    subnet_id = aws_subnet.public_subnets[0].id
    vpc_security_group_ids = ["${aws_security_group.prod_sg.id}"]

    root_block_device {
      delete_on_termination = true
      volume_size = "10"
    }

    user_data = file("${path.module}/install_minecraft.sh")
    tags = {
        Name = "minecraft_server"
        Project = "ondemand_minecrat" 
    }
}
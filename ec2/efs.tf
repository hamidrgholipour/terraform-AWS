
resource "aws_efs_file_system" "hamid_efs" {
  creation_token = "efs"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  availability_zone_name = "us-east-1a"

  tags = {
    Name = "HamidEFS"
  }
}

resource "aws_efs_mount_target" "efs-mt" {
   file_system_id  = aws_efs_file_system.hamid_efs.id
   subnet_id = aws_subnet.hamid-pub-1.id
   security_groups = [aws_security_group.vpc_efs.id]
 }
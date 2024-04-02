
# CloudWatch group 
resource "aws_cloudwatch_log_group" "nginx_log_group" {
  name              = "/ecs/nginx_log_group"
  retention_in_days = var.retention_in_days

  tags = {
    Name = "nginx_log_group"
  }
}

resource "aws_cloudwatch_log_stream" "nginx_log_stream" {
  name           = "nginx-log-stream"
  log_group_name = aws_cloudwatch_log_group.nginx_log_group.name
}

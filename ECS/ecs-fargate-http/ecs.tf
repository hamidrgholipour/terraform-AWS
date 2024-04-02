resource "aws_ecs_task_definition" "ecs_task_definition" {
 family             = "task-nginx-terraform"
 network_mode       = "awsvpc"
#  execution_role_arn = "arn:aws:iam::723071912338:role/ecsTaskExecutionRole"
 execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
 requires_compatibilities = ["FARGATE"]
 cpu                = var.cpu_units
 memory             = var.memory
 runtime_platform {

   operating_system_family = "LINUX"
   cpu_architecture        = "X86_64"

 }
 container_definitions = jsonencode([
   {
     name      = "nginx-terrafom"
     image     = "public.ecr.aws/j0n6w3a8/hamid-pub:latest"
     cpu       = var.cpu_units
     memory    = var.memory
     essential = true
     portMappings = [
       {
         containerPort = var.container_port
         hostPort      = var.container_port
         protocol      = "tcp"
       }
     ]
     logConfiguration = {
        logDriver = "awslogs"
        options   = {
          "awslogs-group"         = aws_cloudwatch_log_group.nginx_log_group.name
          "awslogs-region"        = var.REGION
          "awslogs-stream-prefix" = "${var.service_name}-log-stream-${var.environment}"
        }
      }
   }
 ])
}

resource "aws_ecs_cluster" "main" {
  name = "${var.namespace}_${var.service_name}_cluster"
}

resource "aws_ecs_service" "terraform_nginx" {
  name            = "terraform_nginx"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.ecs_task_desired_count
  launch_type     = var.luanch_type

  network_configuration {
    security_groups = [aws_security_group.vpc_all.id]
    subnets         = [aws_subnet.hamid_pub_1.id,aws_subnet.hamid_pub_2.id]
    assign_public_ip = true
  }

#  enable_execute_command = false
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent = 200
  platform_version = "LATEST"
  scheduling_strategy = "REPLICA"

  load_balancer {
   target_group_arn = aws_alb_target_group.tg-1.id
   container_name   = "nginx-terrafom"
   container_port   = 80
 }

 depends_on = [aws_alb_listener.application_listener, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

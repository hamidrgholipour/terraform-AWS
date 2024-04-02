resource "aws_appautoscaling_target" "target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.terraform_nginx.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.ecs_task_min_count
  max_capacity       = var.ecs_task_max_count
}

resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "${var.namespace}_${var.service_name}_CPUTargetTrackingScaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.target.resource_id
  scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.cpu_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_memory_policy" {
  name               = "${var.namespace}_${var.service_name}_CPUTargetTrackingScaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.target.resource_id
  scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.memory_target_tracking_desired_value

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}




# resource "aws_appautoscaling_policy" "ecs_alb_policy" {
#   name               = "${var.namespace}_${var.service_name}_ALBTargetTrackingScaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.target.resource_id
#   scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     target_value = var.alb_target_tracking_desired_value

#     predefined_metric_specification {
#       predefined_metric_type = "ALBRequestCountPerTarget"
#     }
#   }
# }





# # Automatically scale capacity up by one
# resource "aws_appautoscaling_policy" "up" {
#   name               = "cb_scale_up"
#   service_namespace  = "ecs"
#   resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.terraform_nginx.name}"
#   scalable_dimension = "ecs:service:DesiredCount"

#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     cooldown                = 60
#     metric_aggregation_type = "Maximum"

#     step_adjustment {
#       metric_interval_lower_bound = 0
#       scaling_adjustment          = 1
#     }
#   }

#   depends_on = [aws_appautoscaling_target.target]
# }

# # Automatically scale capacity down by one
# resource "aws_appautoscaling_policy" "down" {
#   name               = "cb_scale_down"
#   service_namespace  = "ecs"
#   resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.terraform_nginx.name}"
#   scalable_dimension = "ecs:service:DesiredCount"

#   step_scaling_policy_configuration {
#     adjustment_type         = "ChangeInCapacity"
#     cooldown                = 60
#     metric_aggregation_type = "Maximum"

#     step_adjustment {
#       metric_interval_upper_bound = 0
#       scaling_adjustment          = -1
#     }
#   }

#   depends_on = [aws_appautoscaling_target.target]
# }






# # CloudWatch alarm that triggers the autoscaling up policy
# resource "aws_cloudwatch_metric_alarm" "service_cpu_high" {
#   alarm_name          = "cb_cpu_utilization_high"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "10" #60
#   statistic           = "Average"
#   threshold           = "50"

#   dimensions = {
#     ClusterName = aws_ecs_cluster.main.name
#     ServiceName = aws_ecs_service.terraform_nginx.name
#   }

#   alarm_actions = [aws_appautoscaling_policy.up.arn]
# }

# # CloudWatch alarm that triggers the autoscaling down policy
# resource "aws_cloudwatch_metric_alarm" "service_cpu_low" {
#   alarm_name          = "cb_cpu_utilization_low"
#   comparison_operator = "LessThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = "60"
#   statistic           = "Average"
#   threshold           = "10"

#   dimensions = {
#     ClusterName = aws_ecs_cluster.main.name
#     ServiceName = aws_ecs_service.terraform_nginx.name
#   }

#   alarm_actions = [aws_appautoscaling_policy.down.arn]
# }

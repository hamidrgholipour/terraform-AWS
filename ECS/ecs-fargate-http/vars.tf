variable REGION {
  default = "us-east-1"
}

variable ZONE1 {
  default = "us-east-1a"
}

variable ZONE2 {
  default = "us-east-1b"
}

variable ZONE3 {
  default = "us-east-1c"
}


## ALB

variable "health_check_path" {
  default = "/"
}

variable "healthcheck_matcher" {
  description = "HTTP status healthcheck"
  type        = string
  default     = "200"
}

variable "alb_protocol" {
  type        = string
  default     = "HTTP"
}

variable "alb_port" {
  type        = number
  default     = "80"
}


variable "alb_target_type" {
  type        = string
  default     = "ip"
}

## Service variables

variable "namespace" {
  description = "Namespace for resource names"
  default     = "terraform"
  type        = string
}


variable "service_name" {
  description = "A Docker image-compatible name for the service"
  default = "nginx"
  type        = string
}

variable "scenario" {
  description = "Scenario name for tags"
  default     = "scenario-ecs-fargate"
  type        = string
}

variable "environment" {
  description = "Environment for deployment (like dev or staging)"
  default     = "dev"
  type        = string
}

## Network VCP variables

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC network"
  default     = "10.0.0.0/16"
  type        = string
}


## ECS variables

variable "ecs_task_desired_count" {
  default     = 1
  type        = number
}

variable "luanch_type" {
  default     = "FARGATE"
  type        = string
}

variable "ecs_task_min_count" {
  default     = 1
  type        = number
}

variable "ecs_task_max_count" {
  default     = 5
  type        = number
}

variable "ecs_task_deployment_minimum_healthy_percent" {
  description = "How many percent of a service must be running to still execute a safe deployment"
  default     = 50
  type        = number
}

variable "ecs_task_deployment_maximum_percent" {
  description = "How many additional tasks are allowed to run (in percent) while a deployment is executed"
  default     = 100
  type        = number
}

variable "cpu_target_tracking_desired_value" {
  description = "Target tracking for CPU usage in %"
  default     = 1
  type        = number
}

variable "memory_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 1
  type        = number
}

variable "alb_target_tracking_desired_value" {
  description = "Target tracking for memory usage in %"
  default     = 50
  type        = number
}

variable "target_capacity" {
  description = "Amount of resources of container instances that should be used for task placement in %"
  default     = 100
  type        = number
}

variable "container_port" {
  description = "Port of the container and host port"
  type        = number
  default     = 80
}

variable "container_portocol" {
  type        = string
  default     = "HTTP"
}

variable "cpu_units" {
  description = "Amount of CPU units for a single ECS task"
  default     = 256
  type        = number
}

variable "memory" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 512
  type        = number
}


variable "retention_in_days" {
  description = "Cloudwatch logs"
  default     = 7
  type        = number
}
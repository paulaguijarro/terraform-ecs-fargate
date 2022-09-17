variable "repository_url" {
  type        = string
  description = "The ECR repository url"
}

variable "ecs_task_execution_role" {
  type        = string
  description = "The IAM arn for the task execution role"
}

variable "cluster_name" {
  type        = string
  description = "The ECS cluster name"
}

variable "task_name" {
  type        = string
  description = "The ECS task definion family name"
}

variable "service_name" {
  type        = string
  description = "The ECS service name"
}

variable "fargate_memory" {
  type        = number
  description = "The Amount (in MiB) of memory used by the task"
}

variable "fargate_cpu" {
  type        = number
  description = "The Number of cpu units used by the task"
}

variable "container_port" {
  type        = number
  description = "The container port"
}

variable "host_port" {
  type        = number
  description = "The host port"
}

variable "service_desired_count" {
  type        = number
  description = "The number of tasks running in parallel"
}

variable "ecs_service_sg" {
  type        = list(any)
  description = "The list of security groups"
}

variable "subnets" {
  type        = list(any)
  description = "The list of private subnets"
}

variable "alb_target_group" {
  type        = string
  description = "The ARN of the alb target group"
}

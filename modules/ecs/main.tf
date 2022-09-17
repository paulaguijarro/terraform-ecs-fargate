resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
  tags = {
    name = var.cluster_name
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = var.task_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc" // https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-networking.html
  memory                   = var.fargate_memory
  cpu                      = var.fargate_cpu
  execution_role_arn       = var.ecs_task_execution_role
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.task_name}-container",
      "image": "${var.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.host_port}
        }
      ],
      "memory": ${var.fargate_memory},
      "cpu": ${var.fargate_cpu}
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task.arn
  launch_type     = "FARGATE"
  desired_count   = var.service_desired_count

  network_configuration {
    security_groups  = var.ecs_service_sg
    subnets          = var.subnets.*.id
    assign_public_ip = false
  }
  # ALB will manage the distribution of requests to all the running tasks
  load_balancer {
    target_group_arn = var.alb_target_group
    container_name   = "${var.task_name}-container"
    container_port   = var.container_port
  }
  #  To tell Terraform to ignore which task definition is currently set in the service
  #  when an update on the infrastructure
  lifecycle {
    ignore_changes = [task_definition]
  }
}

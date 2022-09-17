#  Using a single environment for the time being
locals {
  container_port        = 80
  name                  = "test"
  fargate_cpu           = 256
  fargate_memory        = 512
  host_port             = 80
  service_desired_count = 2
}

module "vpc" {
  source = "./modules/vpc"
  name   = local.name
}

module "security-group" {
  source         = "./modules/security_group"
  name           = local.name
  vpc_id         = module.vpc.vpc_id
  container_port = local.container_port
}

module "alb" {
  source  = "./modules/alb"
  name    = local.name
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  alb_sg  = [module.security-group.alb]
}

module "ecr-registry" {
  source = "./modules/ecr"
  name   = "${local.name}-repo"
}

module "iam-roles" {
  source = "./modules/iam"
}

module "ecs" {
  source                  = "./modules/ecs"
  cluster_name            = "${local.name}-cluster"
  task_name               = "${local.name}-task"
  service_name            = "${local.name}-service"
  repository_url          = module.ecr-registry.repository_url
  ecs_task_execution_role = module.iam-roles.ecs_task_execution_role
  fargate_cpu             = local.fargate_cpu
  fargate_memory          = local.fargate_memory
  host_port               = local.host_port
  container_port          = local.container_port
  service_desired_count   = local.service_desired_count
  ecs_service_sg          = [module.security-group.ecs_tasks]
  subnets                 = module.vpc.private_subnets
  alb_target_group        = module.alb.alb_tg_arn
}

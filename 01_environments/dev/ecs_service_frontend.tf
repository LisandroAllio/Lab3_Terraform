#### ECS Service - Frontend ####
# Este servicio está preparado para cuando la task definition del frontend esté lista
# IMPORTANTE: Este archivo NO se puede aplicar hasta que la task definition esté creada
# TODO: Reemplazar el placeholder de task_definition con la referencia real cuando esté disponible
# Ejemplo: task_definition = module.ecs_task_frontend.task_definition_arn

resource "aws_ecs_service" "frontend" {
  name            = "frontend-service"
  cluster         = module.ecs_cluster.cluster_id
  # TODO: Descomentar y reemplazar cuando la task definition esté lista
  # task_definition = module.ecs_task_frontend.task_definition_arn
  task_definition = "PLACEHOLDER_TASK_DEFINITION_ARN" # ⚠️ ESTO CAUSARÁ ERROR - Reemplazar antes de aplicar
  desired_count   = 2 # Requerimiento: 2 tasks corriendo en instancias EC2

  launch_type = "EC2"

  network_configuration {
    subnets          = module.vpc.private_subnets
    security_groups  = [module.security_groups.ecs_tasks_security_group_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = module.alb.target_group_arn
    container_name   = "frontend" # TODO: Verificar que el nombre del container coincida con la task definition
    container_port   = 80
  }

  # Placement strategies para distribuir las tasks según requerimientos
  # Requerimiento: Incluir placement strategies en el servicio del frontend
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  depends_on = [
    module.alb,
    module.ecs_cluster
  ]

  tags = {
    Name        = "Frontend Service"
    Environment = "dev"
    Owner       = "Ezequiel"
  }
}


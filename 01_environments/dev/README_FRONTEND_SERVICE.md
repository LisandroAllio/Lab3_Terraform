# Servicio ECS Frontend - Instrucciones de Integración

## Estado Actual

El servicio ECS del frontend está **preparado y configurado** con todos los requerimientos de la consigna:

✅ **2 tasks** (`desired_count = 2`)  
✅ **Placement strategies** (spread por instanceId y zona de disponibilidad)  
✅ **Conectado al ALB** (target group configurado)  
✅ **Network configuration** (subnets privadas y security groups)  
✅ **Launch type EC2** (instancias EC2 dentro del cluster)

## Pendiente de Integración

### 1. Task Definition del Frontend

Cuando la task definition del frontend esté lista, necesitas:

1. **Reemplazar el placeholder** en `ecs_service_frontend.tf` línea 8:
   ```hcl
   # Cambiar esto:
   task_definition = "PLACEHOLDER_TASK_DEFINITION_ARN"
   
   # Por esto (ejemplo):
   task_definition = module.ecs_task_frontend.task_definition_arn
   ```

2. **Verificar el nombre del container** en línea 21:
   - Asegúrate de que el `container_name` en el `load_balancer` coincida con el nombre del container en la task definition
   - Actualmente está configurado como `"frontend"`

### 2. Requisitos de la Task Definition

Según la consigna, la task definition del frontend debe:

- ✅ Obtener la variable de conexión a la DB desde **Parameter Store** (requerimiento 8)
- ✅ Inyectar esta variable como **environment variable** en la task definition
- ✅ Usar imagen del repositorio ECR creado (`module.ecr.front_repository_url`)
- ✅ Configurar logs en CloudWatch (ya hay log groups creados: `module.cloudwatch.frontend_log_group_name`)

### 3. Recursos Disponibles para la Task Definition

Puedes usar estos outputs de los módulos existentes:

- **ECR Repository**: `module.ecr.front_repository_url`
- **CloudWatch Log Group**: `module.cloudwatch.frontend_log_group_name`
- **SSM Parameter**: `aws_ssm_parameter.parameter_front_host.value` (cuando esté creado)
- **IAM Roles**: `module.iam_roles.task_role_arn` y `module.iam_roles.task_execution_role_arn` (si están creados)

### 4. Verificación Final

Antes de hacer `terraform apply`, verifica:

1. ✅ La task definition existe y está correctamente configurada
2. ✅ El nombre del container en la task definition coincide con `container_name` en el servicio
3. ✅ El puerto del container (80) coincide con `container_port` en el servicio
4. ✅ Los IAM roles necesarios están creados
5. ✅ El SSM parameter para DB_HOST está creado

## Estructura del Servicio

El servicio está configurado para:
- **Distribuir las 2 tasks** entre diferentes instancias EC2 y zonas de disponibilidad
- **Recibir tráfico** del ALB en el puerto 80
- **Ejecutarse en subnets privadas** con el security group apropiado

## Notas

- El servicio tiene `depends_on` configurado para asegurar que el ALB y el cluster estén listos antes de crear el servicio
- Los placement strategies aseguran alta disponibilidad distribuyendo las tasks
- El servicio está configurado para usar `launch_type = "EC2"` según los requerimientos


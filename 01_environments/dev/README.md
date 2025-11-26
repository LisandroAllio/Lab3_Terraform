# Entorno de Desarrollo - Lab3 Terraform

## 🎯 Descripción del Entorno

Este directorio contiene la configuración específica para el **entorno de desarrollo** del proyecto Lab3. Los archivos estan separados por nombre del componente, que van a ser desplegados. Estos splits llaman a los recursos definidos en la carpeta modules, y en menor medida tambien llaman a modulos de la comunidad.

## 🏗️ Arquitectura de la Infraestructura

### Componentes Principales

| Categoría | Servicios AWS | Descripción |
|-----------|---------------|-------------|
| **Cómputo** | EC2 Instances | Instancias para el cluster ECS |
| **Orquestación** | ECS Cluster, Task Definitions, Services | Contenedores para frontend y base de datos |
| **Balanceador** | Application Load Balancer, Target Groups | Distribución de tráfico y alta disponibilidad |
| **CI/CD** | CodeBuild, CodePipeline | Automatización de despliegues |
| **Networking** | VPC, Subnets, NAT Gateway, Route53, Service Discovery | Red privada y resolución DNS |
| **Almacenamiento** | EFS, S3, ECR | Persistencia de datos y repositorio de imágenes |
| **Secretos** | Systems Manager Parameter Store | Gestión segura de configuraciones |
| **Notificaciones** | SNS | Alertas del pipeline (opcional) |


## 📁 Estructura de Archivos

```
dev/
├── alb.tf                    # Application Load Balancer y Target Groups
├── asg.tf                    # Auto Scaling Group para ECS
├── cloudwatch.tf             # Log Groups para contenedores
├── ecr.tf                    # Repositorios de imágenes Docker
├── ecs_cluster.tf            # Cluster ECS y Capacity Provider
├── ecs_service_frontend.tf   # Servicio ECS del Frontend
├── ecs_service_mysql.tf      # Servicio ECS de MySQL
├── ecs_task_def.tf          # Task Definitions
├── efs.tf                   # Elastic File System para MySQL
├── locals.tf                # Variables locales del entorno
├── parameter_store.tf       # Secretos y configuraciones
├── pipeline.tf              # CodePipeline y CodeBuild
├── providers.tf             # Configuración de providers y backend
├── route53.tf               # Registros DNS
├── security_groups.tf       # Security Groups
├── service_discovery.tf     # Service Discovery para comunicación interna
├── sns.tf                   # Notificaciones (comentado)
└── vpc.tf                   # Red virtual privada
```

## Despliegue del Entorno

### Comandos Rápidos

```bash
# Navegar al directorio del entorno
cd 01_environments/dev

# Inicializar Terraform
terraform init

# Planificar cambios
terraform plan -out=tfplan

# Aplicar infraestructura
terraform apply tfplan

# Ver outputs importantes
terraform output
```

### Comando de Despliegue Completo

```bash
# Opción conservadora (recomendada)
terraform plan -out=tfplan && terraform apply tfplan

# Opción rápida (para desarrollo)
terraform apply -auto-approve
```

### Destruir Infraestructura

```bash
# Destruir todo el entorno
terraform destroy

# Destruir recursos específicos
terraform destroy -target=module.ecs_frontend
```

## 🌐 Acceso y Endpoints

### URLs del Entorno

- **Aplicación Principal**: https://alb.ecastelnuovo.ownboarding.teratest.net
- **ALB DNS**: Disponible en `terraform output alb_dns_name`
- **Repositorio ECR Frontend**: `979244568430.dkr.ecr.us-east-1.amazonaws.com/lab/front`
- **Repositorio ECR MySQL**: `979244568430.dkr.ecr.us-east-1.amazonaws.com/lab/bd-mysql`


## ⚙️ Configuración Específica del Entorno

### Variables Principales 

Configuradas en el archivo local.tf

```hcl
# Configuración del entorno
environment = "dev"
project     = "lab-3"
region      = "us-east-1"

# Networking
vpc_cidr = "10.0.0.0/16"
azs      = ["us-east-1a", "us-east-1b"]

...
```

### Backend Configuration

```hcl
backend "s3" {
  bucket       = "s3-backend-teralab3-grupo-1"
  key          = "dev/terraform.tfstate"
  region       = "us-east-1"
  encrypt      = true
  use_lockfile = true
}
```

## 🔐 Secretos y Configuración

### Parameter Store - Variables de Build

```
/lab/AWS_REGION         
/lab/ECR_REGISTRY      
/lab/ECR_REPOSITORY     
/lab/CONTAINER_NAME     
```

### Parameter Store - Variables de Aplicación

```
/lab3/DB_HOST                   
/lab3/mysql/MYSQL_DATABASE     
/lab3/mysql/MYSQL_USER        
/lab3/mysql/MYSQL_PASSWORD    
/lab3/mysql/MYSQL_ROOT_PASSWORD 
```

## Módulos Terraform

### Módulos de Red y Seguridad
- **VPC**: Red privada virtual con subnets públicas y privadas
- **Security Groups**: Reglas de firewall para cada componente
- **Route53**: Gestión de DNS y dominios

### Módulos de Cómputo
- **ECS Cluster**: Cluster de contenedores con capacity provider
- **ECS ASG**: Auto Scaling Group para instancias EC2
- **ECS Tasks**: Definiciones de tareas para frontend y MySQL
- **ECS Services**: Servicios para frontend y base de datos

### Módulos de Almacenamiento
- **ECR**: Repositorios para imágenes Docker
- **EFS**: Sistema de archivos compartido para MySQL
- **S3**: Almacenamiento para artefactos del pipeline

### Módulos de CI/CD
- **CodeBuild**: Construcción de imágenes Docker
- **CodePipeline**: Pipeline de despliegue automatizado

**A continuacion dejamos una documentacion detallada de cada uno de los modulos:**


---
## 🌐 Módulos de Networking

### security-groups

**Propósito**: Gestiona todos los Security Groups y sus reglas de comunicación.

**Ubicación**: `modules/security-groups/`

**Recursos creados**:
- `aws_security_group.alb` - Security Group para ALB
- `aws_security_group.front` - Security Group para tasks frontend
- `aws_security_group.mysql` - Security Group para MySQL
- `aws_security_group.mysql_efs` - Security Group para EFS
- `aws_security_group.cluster` - Security Group para instancias EC2


**Reglas de comunicación implementadas**:
- ALB → Internet (80, 443)
- ALB → ECS Tasks (80)
- Frontend → MySQL (3306)
- MySQL → EFS (2049)

---

### route53

**Propósito**: Gestiona registros DNS para el dominio de la aplicación.

**Ubicación**: `modules/route53/`

**Recursos creados**:
- `aws_route53_record.alb` - Registro A que apunta al ALB

---

### service-discovery

**Propósito**: Permite comunicación entre servicios usando DNS interno.

**Ubicación**: `modules/service-discovery/`

**Recursos creados**:
- `aws_service_discovery_private_dns_namespace.ecs_cluster_namespace`
- `aws_service_discovery_service.service_discovery_service`


**Uso**: Permite que el frontend se conecte a MySQL usando `database.ecs-cluster-namespace`

---

## 💻 Módulos de Compute

### ecs-cluster

**Propósito**: Crea el cluster ECS con capacity provider vinculado al ASG.

**Ubicación**: `modules/ecs-cluster/`

**Recursos creados**:
- `aws_ecs_cluster.main`
- `aws_ecs_capacity_provider.asg`
- `aws_ecs_cluster_capacity_providers.main`

**Configuración de escalado**:
- Target capacity: 100%
- Managed scaling: Habilitado
- Minimum scaling step: 1
- Maximum scaling step: 10

---

### ecs-asg

**Propósito**: Gestiona el Auto Scaling Group para las instancias EC2 del cluster.

**Ubicación**: `modules/ecs-asg/`

**Recursos creados**:
- `aws_autoscaling_group.ecs`
- `aws_launch_template.ecs`
- `aws_iam_instance_profile.ecs_instance`
- `aws_iam_role.ecs_instance`

**AMI utilizada**: Amazon ECS-Optimized AMI (más reciente)

**User Data**: Configura automáticamente las instancias para unirse al cluster ECS

---

### ecs-tasks

**Propósito**: Define las task definitions para frontend y MySQL.

**Ubicación**: `modules/ecs-tasks/`

**Recursos creados**:
- `aws_ecs_task_definition.task_definition_front`
- `aws_ecs_task_definition.task_definition_db`
- `aws_iam_role.ecs_task_execution`

**Task Definition Frontend**:
```json
{
  "family": "front_task_def",
  "networkMode": "awsvpc",
  "cpu": "512",
  "memory": "512",
  "containers": [{
    "name": "frontend",
    "image": "ECR_REPOSITORY_URL:latest",
    "portMappings": [{"containerPort": 80}],
    "secrets": [{"name": "DB_HOST", "valueFrom": "/lab3/DB_HOST"}]
  }]
}
```

**Task Definition MySQL**:
```json
{
  "family": "db_task_def",
  "networkMode": "awsvpc",
  "cpu": "512",
  "memory": "512",
  "volumes": [{"name": "lab-3-mysql-efs", "efsVolumeConfiguration": {...}}],
  "containers": [{
    "name": "database",
    "image": "ECR_REPOSITORY_URL:latest",
    "portMappings": [{"containerPort": 3306}],
    "mountPoints": [{"sourceVolume": "lab-3-mysql-efs", "containerPath": "/var/lib/mysql"}],
    "secrets": [
      {"name": "MYSQL_DATABASE", "valueFrom": "/lab3/mysql/MYSQL_DATABASE"},
      {"name": "MYSQL_USER", "valueFrom": "/lab3/mysql/MYSQL_USER"},
      {"name": "MYSQL_PASSWORD", "valueFrom": "/lab3/mysql/MYSQL_PASSWORD"},
      {"name": "MYSQL_ROOT_PASSWORD", "valueFrom": "/lab3/mysql/MYSQL_ROOT_PASSWORD"}
    ]
  }]
}
```

---

### ecs-frontend

**Propósito**: Gestiona el servicio ECS para el frontend.

**Ubicación**: `modules/ecs-frontend/`

**Recursos creados**:
- `aws_ecs_service.frontend`

**Configuración del servicio**:
- **Desired count**: 2 tasks
- **Launch type**: EC2
- **Network**: Subnets privadas
- **Load balancer**: Conectado al ALB
- **Placement strategies**: 
  - Spread por instanceId
  - Spread por availability zone

**Deployment configuration**:
- Minimum healthy percent: 0%
- Maximum percent: 100%

---

### ecs-mysql

**Propósito**: Gestiona el servicio ECS para MySQL.

**Ubicación**: `modules/ecs-mysql/`

**Recursos creados**:
- `aws_ecs_service.service`

**Configuración del servicio**:
- **Desired count**: 1 task
- **Launch type**: EC2
- **Network**: Subnets privadas
- **Service Discovery**: Registrado como `database.ecs-cluster-namespace`

---

## 💾 Módulos de Storage

### ECR

**Propósito**: Gestiona los repositorios de imágenes Docker.

**Ubicación**: `modules/ecr/`

**Recursos creados**:
- `aws_ecr_repository.repositorio_front`
- `aws_ecr_repository.repositorio_bd`

**Configuración**:
- **Image tag mutability**: MUTABLE
- **Encryption**: AES256
- **Scan on push**: false
- **Force delete**: true (para desarrollo)

**Repositorios**:
- `lab/front` - Imágenes del frontend
- `lab/bd-mysql` - Imágenes de MySQL personalizada

---

### EFS

**Propósito**: Proporciona almacenamiento persistente para MySQL.

**Ubicación**: `modules/efs/`

**Recursos creados**:
- `aws_efs_file_system.mysql_efs`
- `aws_efs_mount_target.mysql_efs_mount` (uno por subnet privada)
- `aws_efs_access_point.mysql_access_point`

**Configuración**:
- **Performance mode**: generalPurpose
- **Throughput mode**: bursting
- **Encrypted**: true
- **Access Point**: Configurado para usuario MySQL (UID/GID 999)

**Mount path**: `/var/lib/mysql` en el contenedor MySQL

---

## ⚖️ Módulos de Load Balancing

### ALB

**Propósito**: Gestiona el Application Load Balancer y Target Groups.

**Ubicación**: `modules/alb/`

**Recursos creados**:
- `aws_lb.alb`
- `aws_lb_target_group.target_group`
- `aws_lb_listener.listener_https` (puerto 443)
- `aws_lb_listener.listener_http` (puerto 80, redirige a HTTPS)

**Configuración del Target Group**:
- **Target type**: IP (para ECS con awsvpc)
- **Health check path**: `/css/twitter.css`
- **Protocol**: HTTP
- **Port**: 80

**Listeners**:
- **HTTP (80)**: Redirige a HTTPS
- **HTTPS (443)**: Termina SSL y envía tráfico al Target Group

---

## 🔄 Módulos de CI/CD

### code_build

**Propósito**: Configura el proyecto CodeBuild para construir imágenes Docker.

**Ubicación**: `modules/code_build/`

**Recursos creados**:
- `aws_codebuild_project.frontend`
- `aws_iam_role.codebuild`
- `aws_iam_role_policy.codebuild`

**Configuración del proyecto**:
- **Environment**: `aws/codebuild/standard:6.0`
- **Compute type**: BUILD_GENERAL1_SMALL
- **Privileged mode**: true (para Docker)
- **Source**: GitHub con buildspec.yml

**Permisos IAM**:
- ECR (push/pull imágenes)
- CloudWatch Logs
- S3 (artefactos)
- Parameter Store (variables)

---

### pipeline

**Propósito**: Orquesta el pipeline completo de CI/CD.

- **Nombre**: `lab-front-pipeline`
- **Repositorio**: `LisandroAllio/php_inter`
- **Rama**: `main`
- **Trigger**: Automático en push a main

**Ubicación**: `modules/pipeline/`

**Recursos creados**:
- `aws_codepipeline.codepipeline`
- `aws_codestarconnections_connection.git_connection`
- `aws_s3_bucket.codepipeline_bucket`
- `aws_iam_role.codepipeline_role`

**Stages del pipeline**:
1. **Source**: GitHub (rama main)
2. **Build**: CodeBuild (construye y pushea imagen)
3. **Deploy**: ECS (actualiza servicio frontend)

**Trigger automático**: Se ejecuta en cada push a la rama main

---

## 📊 Módulos de Monitoring

### cloudwatch

**Propósito**: Gestiona los Log Groups para los contenedores.

**Ubicación**: `modules/cloudwatch/`

**Recursos creados**:
- `aws_cloudwatch_log_group.mysql_log`
- `aws_cloudwatch_log_group.frontend_log`

**Log Groups**:
- `/ecs/frontend` - Logs del servicio frontend
- `/ecs/mysql` - Logs del servicio MySQL

---

## 🔔 Módulos de Notifications

### sns

**Propósito**: Gestiona notificaciones del pipeline (opcional).

**Ubicación**: `modules/sns/`

**Recursos creados**:
- `aws_sns_topic.pipeline_notifications`
- `aws_sns_topic_subscription.email`
- `aws_sns_topic_policy.pipeline_publish`

**Configuración**:
- **Suscripciones**: Email para el equipo DevOps
- **Eventos**: Estados del pipeline (success, failure, etc.)

**Estado**: Actualmente comentado en el entorno dev

---
# TERALAB 3 – Terraform Challenge

## 📋 Descripción del Proyecto

Este proyecto implementa una infraestructura completa en AWS utilizando Terraform como herramienta de Infrastructure as Code (IaC). La solución está diseñada para ser **altamente disponible**, **resiliente**, **escalable** y capaz de servir tráfico a usuarios a través de internet.

Para alcanzar estos objetivos utilizamos dos pilares fundamentales:

- **AWS Cloud** como plataforma de infraestructura.
- **Terraform** como herramienta de *Infrastructure as Code (IaC)*.

Sumado a metodologías y herramientas **ágiles**, esto nos permite:

- Crear, testear, implementar y desplegar cambios rápidamente.
- Iterar sobre la infraestructura con seguridad y control.
- Mejorar continuamente la solución sin perder trazabilidad.

En combinación, **Terraform** nos permite llevar las mejores prácticas de IaC a la nube, mientras que **AWS** se beneficia de la velocidad y consistencia de los despliegues automatizados.


### 🎯 Objetivos

- Crear una infraestructura moderna y escalable en AWS
- Implementar mejores prácticas de DevOps e IaC
- Facilitar el despliegue automatizado y la colaboración del equipo
- Mantener costos optimizados utilizando la capa gratuita de AWS

## 📁 Estructura del Repositorio

```
Lab3_Terraform/
├── README.md                          # Documentación principal
├── 01_environments/
│   └── dev/                          # Entorno de desarrollo
│       ├── *.tf                      # Configuración del entorno dev
│       ├── locals.tf                 # Variables locales del entorno
│       └── providers.tf              # Configuración de providers y backend
└── modules/                          # Módulos reutilizables
    ├── alb/                         # Application Load Balancer
    ├── cloudwatch/                  # Log Groups
    ├── code_build/                  # CodeBuild project
    ├── ecr/                         # Elastic Container Registry
    ├── ecs-asg/                     # Auto Scaling Group para ECS
    ├── ecs-cluster/                 # ECS Cluster y Capacity Provider
    ├── ecs-frontend/                # Servicio ECS Frontend
    ├── ecs-mysql/                   # Servicio ECS MySQL
    ├── ecs-tasks/                   # Task Definitions
    ├── efs/                         # Elastic File System
    ├── pipeline/                    # CodePipeline
    ├── route53/                     # DNS Records
    ├── security-groups/             # Security Groups
    ├── service-discovery/           # Service Discovery
    └── sns/                         # Simple Notification Service
```

## 🚀 Requisitos Previos

### Software Requerido
- **Terraform** >= 1.13
- **AWS CLI** configurado con credenciales válidas
- **Git** para control de versiones
- **Docker** para desarrollo local

### Configuración AWS
```bash
# Configurar credenciales AWS
aws configure

# Verificar acceso
aws sts get-caller-identity
```

### Permisos IAM Necesarios
- EC2, ECS, ECR (full access)
- VPC, Route53, ALB (full access)
- S3, CloudWatch, Systems Manager (full access)
- CodeBuild, CodePipeline (full access)
- IAM (para crear y eliminar roles y policies)

## 🛠️ Implementacio y Despliegue de la Infraestructura

Para ir a la implementacion de la infraestructura, [click aca](./01_environments/dev/).

## 👥 Equipo DevOps

- [Federico](https://github.com/federicogfb) 
- [Lara](https://github.com/LaraSperanza)
- [Lisandro](https://github.com/LisandroAllio)
- [Ezequiel](https://github.com/ezequielcastelnuovo) 


### Herramientas Utilizadas
- **Trello**: Gestión de tareas y workflow
- **Docker**: Containerización de aplicaciones
- **GitHub**: Control de versiones y colaboración
- **LLMs**: Asistencia técnica y documentación

---
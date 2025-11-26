# Infraestructura que sera desplegada:

| Categoría | Componentes |
|-----------|-------------|
| **Computo** | Instancias EC2 |
| **Orquestacion** | ECS Cluster<br>ECS Tasks Definitions<br>ECS Services |
| **Balanceador** | ALB<br>Target Group |
| **CI/CD** | CodeBuild project<br>CodePipeline project |
| **Networking** | Route53<br>Service Discovery<br>VPC<br>Subnets<br>NAT Gateway |
| **Almacenamiento** | EFS<br>S3<br>ECR |
| **Secret Management** | Parameter Store |
| **Notificacion** | SNS |

## Como desplegar la infra:

```bash
terraform plan -out && terraform apply
```

y al final aprobar el apply con un "yes"

ooo si te estas sintiendo suertudo:

```bash
terraform apply -auto-approve
```

y al final rezarle a dios.

## Que hicimos y por que:

En esta carpeta se encuentran todos los archivos, separados por nombre del componente, que van a ser desplegados. Estos modulos o splits llaman a los recursos definidos en la carpeta modules, y en menor medida tambien llaman a modulos de la comunidad.

Hay solamente el archivo locals para la definicion de variables. De esta manera si quisieramos hacer una replicacion exacta de la infraestructura solo deberiamos copiar los archivos a otro environment y adaptar los locals a los valores que quisieramos. Por ejemplo: pasar de una t2.micro para el entorno de desarrollo a una t2.medium para produccion.
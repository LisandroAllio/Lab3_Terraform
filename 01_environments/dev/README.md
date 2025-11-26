<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Infraestructura - TERALAB 3</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;
            line-height: 1.6;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            background-color: #0d1117;
            color: #c9d1d9;
        }
        
        h1 {
            border-bottom: 1px solid #21262d;
            padding-bottom: 10px;
            color: #58a6ff;
        }
        
        h2 {
            color: #58a6ff;
            margin-top: 30px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background-color: #161b22;
        }
        
        th {
            background-color: #21262d;
            color: #c9d1d9;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            border: 1px solid #30363d;
        }
        
        td {
            padding: 12px;
            border: 1px solid #30363d;
        }
        
        td:first-child {
            font-weight: 600;
            width: 30%;
        }
        
        td:last-child {
            width: 70%;
        }
        
        pre {
            background-color: #161b22;
            border: 1px solid #30363d;
            border-radius: 6px;
            padding: 16px;
            overflow-x: auto;
        }
        
        code {
            font-family: 'Courier New', Courier, monospace;
            color: #79c0ff;
        }
        
        p {
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <h1>Infraestructura que sera desplegada:</h1>
    
    <table>
        <thead>
            <tr>
                <th>Categoría</th>
                <th>Componentes</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Computo</td>
                <td>Instancias EC2</td>
            </tr>
            <tr>
                <td>Orquestacion</td>
                <td>
                    ECS Cluster<br>
                    ECS Tasks Definitions<br>
                    ECS Services
                </td>
            </tr>
            <tr>
                <td>Balanceador</td>
                <td>
                    ALB<br>
                    Target Group
                </td>
            </tr>
            <tr>
                <td>CI/CD</td>
                <td>
                    CodeBuild project<br>
                    CodePipeline project
                </td>
            </tr>
            <tr>
                <td>Networking</td>
                <td>
                    Route53<br>
                    Service Discovery<br>
                    VPC<br>
                    Subnets<br>
                    NAT Gateway
                </td>
            </tr>
            <tr>
                <td>Almacenamiento</td>
                <td>
                    EFS<br>
                    S3<br>
                    ECR
                </td>
            </tr>
            <tr>
                <td>Secret Management</td>
                <td>Parameter Store</td>
            </tr>
            <tr>
                <td>Notificacion</td>
                <td>SNS</td>
            </tr>
        </tbody>
    </table>
    
    <h2>Como desplegar la infra:</h2>
    
    <pre><code>terraform plan -out && terraform apply</code></pre>
    
    <p>y al final aprobar el apply con un "yes"</p>
    
    <p>ooo si te estas sintiendo suertudo:</p>
    
    <pre><code>terraform apply -auto-approve</code></pre>
    
    <p>y al final rezarle a dios.</p>
    
    <h2>Que hicimos y por que:</h2>
    
    <p>En esta carpeta se encuentran todos los archivos, separados por nombre del componente, que van a ser desplegados. Estos modulos o splits llaman a los recursos definidos en la carpeta modules, y en menor medida tambien llaman a modulos de la comunidad.</p>
    
    <p>Hay solamente el archivo locals para la definicion de variables. De esta manera si quisieramos hacer una replicacion exacta de la infraestructura solo deberiamos copiar los archivos a otro environment y adaptar los locals a los valores que quisieramos. Por ejemplo: pasar de una t2.micro para el entorno de desarrollo a una t2.medium para produccion.</p>
</body>
</html>
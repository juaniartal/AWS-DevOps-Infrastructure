# Multi-Region VPC Setup with Transit Gateway

Este proyecto configura una arquitectura en AWS con múltiples VPCs en diferentes regiones (Virginia, Oregon y Ohio) conectadas a través de un **Transit Gateway**. Cada VPC tiene sus propias configuraciones de EC2 y subredes, con un enfoque en la conectividad entre ellas y la capacidad de hacer ping y SSH entre las instancias EC2 ubicadas en diferentes regiones.

## Arquitectura

### 1. VPCs por Región

#### a. **VPC Virginia (Administrativa)**
- **EC2 Pública**: Instancia EC2 en una **subnet pública**.
- **NAT Gateway**: Para permitir que las instancias privadas se conecten a Internet.
- **Internet Gateway**: Para proporcionar acceso a Internet a la **subnet pública**.
- **Transit Gateway**: Para la conectividad entre VPCs.

#### b. **VPC Oregon (Desarrollo)**
- **EC2 Privada**: Instancia EC2 en una **subnet privada**.
- **Transit Gateway**: Conexión a otros VPCs a través de Transit Gateway.

#### c. **VPC Ohio (Producción)**
- **EC2 Privada**: Instancia EC2 en una **subnet privada**.
- **Transit Gateway**: Conexión con otros VPCs a través de Transit Gateway.

### 2. Configuración del Transit Gateway

- **Transit Gateway Attachments**: Conectar cada VPC a su respectivo Transit Gateway en su región.
- **Conexión entre Transit Gateways**: Asegurar que los Transit Gateways estén interconectados entre sí para permitir la comunicación entre regiones.
- **Tablas de Ruteo en la VPC**: Configurar las tablas de ruteo de cada VPC para que todas las rutas apunten al Transit Gateway con la ruta `0.0.0.0/0 --> tg`.
- **Tablas de Ruteo del Transit Gateway**: Configurar las tablas de ruteo del Transit Gateway para asegurar la correcta interconexión entre VPCs y su conectividad con las instancias EC2.

### 3. Conectividad entre EC2s

- Una vez que las VPCs están conectadas a través del Transit Gateway y las rutas son configuradas correctamente, las instancias EC2 en **Virginia (Pública)** podrán hacer ping y SSH a las instancias EC2 en **Oregon (Privada)** y **Ohio (Privada)**.
- Esto permitirá la administración remota y la comunicación entre máquinas distribuidas en diferentes regiones.

## Requisitos

- **Cuenta AWS**: Para desplegar los recursos.
- **Terraform**: Usado para gestionar la infraestructura.
- **IAM Roles y Permisos**: Asegúrate de tener los permisos necesarios para crear y administrar VPCs, EC2s, Transit Gateways y tablas de ruteo.

## Pasos para la Implementación

1. **Configurar las credenciales de AWS**: Asegúrate de tener configuradas las credenciales de AWS en tu entorno.
2. **Clonar el repositorio**: Clona este repositorio en tu máquina local o entorno.
3. **Modificar las variables**: Ajusta las variables en el archivo `variables.tf` para adaptarlas a tus preferencias (por ejemplo, región, tipo de instancia, etc.).
4. **Inicializar Terraform**: Ejecuta `terraform init` para inicializar el directorio de trabajo de Terraform.
5. **Aplicar la configuración**: Ejecuta `terraform apply` para crear los recursos en tu cuenta de AWS.
6. **Verificar la conectividad**: Una vez que las instancias EC2 estén en ejecución y las configuraciones de ruteo estén aplicadas, realiza un ping y SSH desde la EC2 pública en Virginia hacia las instancias EC2 privadas en Oregon y Ohio.

## Recursos

- **VPC**: [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/)
- **Transit Gateway**: [AWS Transit Gateway Documentation](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-intro.html)
- **EC2**: [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/index.html)

## Licencia

Este proyecto está bajo la Licencia MIT.

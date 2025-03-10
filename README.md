# Prueba técnica Craftech

## Indice
- [Contenido](#contenido)
- [Requerimientos](#requerimientos-iniciales)
- [Instalacion](#instalación)
- [Aplicacion](#aplicación)
- [Terraform](#terraform)

## Contenido
- Diagrama de Red
- Docker Compose de un frontend en react y un backend en django
- Nginx default index.html dockerizado y con CI/CD

## Requerimientos iniciales

Antes de comenzar corroborar la instalación de los siguientes

- **Docker**  
  [Docker Installation Guide](https://docs.docker.com/get-docker/)
- **Docker Compose**  
  [Docker Compose Installation](https://docs.docker.com/compose/install/)
- **Git**  
  [Download Git](https://git-scm.com/)


## Instalación
### Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/Harumi236/prueba-tecnica-craftec.git
```
## Aplicación

La aplicación consiste en un backend desarrollado en Django con base de datos PostgresSQL y un frontend desarrollado en React, ambos sistemas dockerizados y desplegables por un unico docker-compose

### Despliegue local

Para levantar la aplicación en su ordenador, ejecute el siguiente comando en la consola. Por ser imagenes de desarrollo y no producción, puede demorar en levantar la aplicación
```bash
docker-compose up --build
```

### Endpoints

- Frontend: [http://localhost:3000](http://localhost:3000)
- Backend: [http://localhost:8000](http://localhost:8000)
- Nginx: [http://localhost:8080](http://localhost:8080)

### Despliegue en AWS

Para desplegar la aplicación en AWS, siga los siguientes pasos:

1. **Crear una instancia de EC2**  
    Inicie sesión en la consola de AWS y cree una nueva instancia de EC2 con Amazon Linux 2 o Ubuntu, con Docker y Docker-Compose instalados

2. **Conectar a la instancia de EC2**  
    Conéctese a su instancia de EC2 utilizando SSH:
    ```bash
    ssh -i "your-key.pem" ec2-user@your-ec2-public-ip
    ```

3. **Clonar el repositorio en la instancia**  
    Clone su repositorio en la instancia de EC2:
    ```bash
    git clone https://github.com/Harumi236/prueba-tecnica-craftec.git
    cd prueba-tecnica-craftec
    ```

4. **Construir y ejecutar los contenedores**  
    Ejecute el siguiente comando para construir y ejecutar los contenedores:
    ```bash
    docker-compose up --build
    ```

5. **Configurar el grupo de seguridad**  
    Asegúrese de que el grupo de seguridad de su instancia de EC2 permita el tráfico entrante en los puertos 3000 y 8000

6. **Acceder a la aplicación**  
    Acceda a la aplicación utilizando la dirección pública de su instancia de EC2:
    - Frontend: `http://your-ec2-public-dns:3000`
    - Backend: `http://your-ec2-public-dns:8000`
    
### Compilar Solo Frontend
Para compilar solo el frontend del sistema, ejecutar los siguientes comandos en la terminal ubicado sobre el directorio de la aplicación frontend. Tenga en cuenta que al no estar levantada la base de datos no funcionará correctamente

#### Build React Docker Image
```bash
docker build -t react-frontend .
```
#### Run Container
```bash
docker run -d -p 3000:3000 react-frontend
```

### Compilar Solo Backend
Para compilar solo el frontend del sistema, ejecutar los siguientes comandos en la terminal ubicado sobre el directorio de la aplicación backend. Tenga en cuenta que al no estar levantada la base de datos no funcionará correctamente

#### Build React Docker Image
```bash
docker build -t django-backend .
```
#### Run Container
```bash
docker run -d -p 8000:8000 django-backend
```

### Terraform
Se incluye un main.tf para la automatización de despliegue de infraestructura en AWS, sin embargo el código no fue testeado

Para utilizar este setup de Terraform seguir estos pasos

1. **Instalar Terraform**   
  Si no tiene Terraform instalado, puede seguir la guía de instalación oficial: [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

2. **Configurar credenciales de AWS**  
  Configure sus credenciales de AWS utilizando el AWS CLI:
  ```bash
  aws configure
  ```

3. **Inicializar Terraform**  
  Navegue al directorio donde se encuentra el archivo `main.tf` y ejecute el siguiente comando para inicializar Terraform:
  ```bash
  terraform init
  ```

4. **Planificar la infraestructura**  
  Ejecute el siguiente comando para crear un plan de ejecución. Esto le mostrará qué recursos serán creados, modificados o destruidos:
  ```bash
  terraform plan
  ```

5. **Aplicar el plan de Terraform**  
  Si está satisfecho con el plan, puede aplicar los cambios para crear la infraestructura:
  ```bash
  terraform apply
  ```

6. **Verificar la infraestructura**  
  Una vez que Terraform haya terminado de aplicar los cambios, puede verificar que la infraestructura se haya creado correctamente en la consola de AWS.

7. **Destruir la infraestructura**  
  Si desea destruir la infraestructura creada por Terraform, puede ejecutar el siguiente comando:
  ```bash
  terraform destroy
  ```

#### Disclaimer: 
Esta configuracion es una implementacion conceptual y seguramente requiera ajustes para funcionar correctamente.
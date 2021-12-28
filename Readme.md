# Vetsi API
Vetsi es un REST API con el que puedes hacer trading de acciones de la bolsa de balores NASDAQ.

## Pre-requisitos
Vetsi esta construido con Ruby 3.0.2, asegurate de tener instalada esta versión en tu entorno local. Si no sabes como isntalar Ruby te recomiendo hacerlo con rbenv, para eso sigue las siguientes instrucciones.

[Descargar e instalar ruby con Rbenv](https://github.com/rbenv/rbenv)

## Instalación
Una vez que hayas instalado Ruby 3.0.2 ejecuta el siguiente comando para instalar el proyecto localmente:

```bash
make setup
```

## Guía Uso
Para que puedas probar el proyecto en tu local solo ejecuta el siguiente
comando:
```bash
make start
```
lo anterior arrancara un web server para que puedas hacer peticiones en la siguiente ruta:
```
http://localhost:4567
```
## Docker
Y porque estamos en el 2022 y nadie lo pidió, también puedes ejecutar el proyecto 
sobre [Docker](https://www.docker.com/), solo asegurate de tenerlo instalado,
sino sabes cómo, lo puedes hacer desde la siguiente liga:

[Descargar e instalar Docker](https://docs.docker.com/get-docker/)

Una vez instalado docker ejecuta los siguientes comando para construir la imagen
y luego lanzar el contenedor que contendrá el proyecto:

```bash
make dkr-setup
make dkr-start
```
## Tests
El testing se hace con [Rspec](https://rspec.info/), si quieres ejecutar la suite de pruebas solo ejecuta el siguiente comando:
```bash
make test
```
o si esta ejecutando Vetsi sobre Docker ejecuta:
```bash
make dkr-test
```

## Licencia

Capculator is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
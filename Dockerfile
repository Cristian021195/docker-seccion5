#punto entrada, ya sin node no podemos hacer nada mas en este caso
# estandar con la plataforma del SO local
#FROM node:19.2-alpine3.16 

# forzamos a una plataforma en especifico
FROM --platform=linux/amd64 node:19.2-alpine3.16

#como moverse a cd /app
WORKDIR /app

# copiamos los archivos necesarios al /app (donde estamos parados actualmente)
# COPY app.js package.json ./ (varios copies)
# COPY ALL (incluye node_modules si no los ignoramos en .dockerignore) copia todo de local y pega en WORKDIR del contenedor
COPY . .

# ejecutamos npm install para todas las dependencias
RUN node -v && npm install

# Realizamos tests
RUN npm run test

# Eliminar archivos innecesarios que no vayan a producción
# borrado recursivo
RUN rm -rf tests && rm -rf node_modules

# solo las de producción
RUN npm install --prod

# ejecutar ek app.js - son comandos, no se puede usar RUN
CMD ["node","app.js"]

# en cmd para la construccion de esta imagen ejecutamos 
# docker build --tag cron-ticker . (punto, path relativo a dockerfile) reconstruye a la tag latest
# docker build --tag cron-ticker:1.0.0 . (con el tag:1.0.0 para versionado)
# RENAME DE IMAGES: ideal para tener sincronizada la version latest con la ultima version ej: 1.0.2
#   docker image tag cristiangramajo015/cron-ticker:1.0.0 cron-ticker:bufalo 

# NOTA: si agregamos nuevas layers ponerlas arriba para evitar la demora en la 
# construccion de la imagen ya que las antiguas quedan en caché.
# recomendable para los comandos que menos cambian, ej: exposición de puerto, variables de entorno.


# PARA SUBIR A REPO REMOTO DOCKER HUB, en la consola
# cmd: docker login (llenar con usuario y contraseña)
# cmd: docker push cristiangramajo015/cron-ticker:latest

# PARA CORRER EL CONTENEDOR REMOTO
# cmd: docker container run cristiangramajo015/cron-ticker:1.0.0


# INSPECCION DE CONTENEDORES / IMAGENES
# cmd: docker exec -it <container id> /bin/sh
# cmd: docker ls -al (ver archivos ocultos)
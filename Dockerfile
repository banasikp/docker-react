FROM node:16-alpine as builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

CMD ["npm", "run", "build"]

#/app/build is the output directory for the build process. 
#The build artifacts will be generated in this directory after running the build command.

FROM nginx:alpine
# COPY: --from=builder means that we want to copy files from other phase
# we are copying files to /user/share/nginx/html which is the default directory for nginx to serve static files - taken from nginx documentation.
COPY --from=builder /app/build /usr/share/nginx/html 


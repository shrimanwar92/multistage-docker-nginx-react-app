# Build Stage 1
FROM node:17-alpine3.12 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2
FROM nginx:alpine AS nginx
## Copy build from stage 1
COPY --from=builder /app/build/ /var/www/html
## Add default config for nginx
## ADD default.conf /etc/nginx/conf.d/
## Publish Port
## EXPOSE 80
## Start nginx
CMD ["nginx", "-g", "daemon off;"]

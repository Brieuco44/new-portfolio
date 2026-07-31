# Phase 1 : Build du site Hugo
FROM klakegg/hugo:ext-alpine AS builder
WORKDIR /src
COPY . .
# Compilation et minification des fichiers dans /src/public
RUN hugo --minify

# Phase 2 : Serveur web Nginx léger
FROM nginx:alpine
# Copie des fichiers compilés vers le dossier web par défaut de Nginx
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
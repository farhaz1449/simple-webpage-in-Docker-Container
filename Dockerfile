# Simple Nginx Dockerfile with custom index.html
FROM nginx:alpine

# Copy index.html to nginx html directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]

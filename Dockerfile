# This Dockerfile is added in case a Docker image needs 
# to be created in ECR for use in the task definition
#
FROM nginx:latest

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

FROM nginx:1.15.8
COPY static/dockertest.json /usr/share/nginx/html/dockertest.json
RUN mkdir -p /etc/nginx
COPY nginx.conf /etc/nginx/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

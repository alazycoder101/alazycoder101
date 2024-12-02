FROM nginx:1

RUN apt-get update && apt-get install -y curl tini vim tmux procps supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf
CMD ["supervisord"]

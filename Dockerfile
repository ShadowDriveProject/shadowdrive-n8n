FROM n8nio/n8n

ENV N8N_PORT=5678
ENV DB_TYPE=postgresdb

COPY . /data

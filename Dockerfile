FROM n8nio/n8n

ENV NODE_ENV=production

# Copy .n8n config folder if needed
# COPY .n8n /home/node/.n8n

EXPOSE 5678

CMD ["n8n", "start"]

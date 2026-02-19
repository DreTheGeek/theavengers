# Use official Node.js image
FROM node:20-slim

# Install OpenClaw globally
RUN npm install -g openclaw

# Set working directory
WORKDIR /app

# Copy configuration file
COPY openclaw.json /root/.openclaw/openclaw.json

# Expose the gateway port
EXPOSE 18789

# Start OpenClaw gateway
CMD ["openclaw", "gateway", "--port", "18789"]

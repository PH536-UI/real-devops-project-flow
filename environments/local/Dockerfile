FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# A linha abaixo é crucial para o ECS manter o container rodando
CMD ["node", "index.js"]

FROM node:16-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ADD IT HERE!
ENV VITE_API_BASE_URL=http://ac6d6dd009a02447c9406e1dd02e0676-784926035.us-east-1.elb.amazonaws.com:5000/api

FROM node:16-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/dist /app
ENV PORT=5001
ENV NODE_ENV=production
EXPOSE 5001
CMD ["serve", "-s", ".", "-l", "5001"] 

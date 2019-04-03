FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN yarn && yarn cache clean
COPY . .
ENV VUE_APP_API_URL "http://localhost:3000"
RUN yarn build

FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html

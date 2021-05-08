# Build Phase
# Error can occur because of builder name
# If that happens remove "as builder"
FROM node:alpine as builder 
WORKDIR "/app"
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx

# For Elasticbeanstalk to map directly
# Used to incoming traffic
EXPOSE 3000

# Replace the default file of nginx by our default.conf file
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy /app/build from the build phase into usr/share...
# Error can occur because of builder name
# Write 0 instead of builder
COPY --from=builder /app/build usr/share/nginx/html

# No need to specify a CMD because 
# the actual default CMD of the nginx image is to start nginx
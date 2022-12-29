# Start from golang:1.15-alpine base image.
FROM golang:1.15-alpine
# Set the Current Working Directory inside the container
WORKDIR /app
# Copy the code into the container
COPY . .
# Build the Go app
RUN go build -o main
# Command to run when starting the container
CMD ["./main"]

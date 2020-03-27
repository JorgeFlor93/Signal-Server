#Base image
FROM ubuntu:18.04 as base

#Copy
COPY . .

RUN make

#Tell Docker we are going to use this port
EXPOSE 80

CMD echo "This is a test." | wc -

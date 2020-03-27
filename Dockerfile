#Base image
FROM ubuntu:18.04 as base

# install build dependencies
RUN apt update && apt install -y g++ 

#Copy
RUN mkdir /home/SignalServer
WORKDIR /home/SignalServer/
COPY . .
 

#Tell Docker we are going to use this port
EXPOSE 22

RUN chmod +x /home/SignalServer/app.sh
RUN cd ~ \ ./app.sh 

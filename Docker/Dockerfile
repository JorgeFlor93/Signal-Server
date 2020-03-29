#Base image
FROM ubuntu:18.04 as base

# install build dependencies
RUN apt update && apt install -y g++ 

#Copy
RUN mkdir /home/SignalServer
WORKDIR /home/SignalServer/
COPY . .
RUN make
#RUN chmod +x /home/SignalServer/app.sh
#RUN cd ~ \ ./app.sh 

#Base image
FROM ubuntu

# install build dependencies 
RUN apt update && apt install -y build-essential  

#Copy
RUN mkdir /home/SignalServer
WORKDIR /home/SignalServer/
COPY . .
RUN /bin/bash -c 'source $HOME/.bashrc; \
make' 
#RUN chmod +x /home/SignalServer/app.sh
#RUN cd ~ \ ./app.sh 
EXPOSE 500

FROM nodered/node-red-docker
RUN npm install node-red-contrib-influxdb
RUN npm install node-red-node-pushbullet

# test $FLOWS
RUN echo $FLOWS

# Copy the flow configuration file
COPY my_flows.json /data/my_flows.json

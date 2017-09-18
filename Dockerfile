FROM nodered/node-red-docker
RUN npm install node-red-contrib-influxdb
RUN npm install node-red-node-pushbullet
RUN npm install node-red-contrib-ifttt
RUN npm install node-red-contrib-sms-twilio


# test $FLOWS -> Retourne flow.json. Donc ne prend pas en compte la variale de app.yaml
RUN echo $FLOWS

# Copy the flow configuration file
#COPY my_flows.json /data/my_flows.json
VOLUME ["/myData"]
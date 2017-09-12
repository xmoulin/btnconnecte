FROM nodered/node-red-docker
RUN npm install node-red-contrib-influxdb
RUN npm install node-red-node-pushbullet

# test $FLOWS -> Retourne flow.json. Donc ne prend pas en compte la variale de app.yaml
RUN echo $FLOWS

# Copy the flow configuration file
COPY my_flows.json /data/my_flows.json

# --- InfluxDB
RUN set -ex && \
    for key in \
        05CE15085FC09D18E99EFB22684A14CF2582E0C5 ; \
    do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
        gpg --keyserver keyserver.pgp.com --recv-keys "$key" ; \
    done

RUN wget -q https://dl.influxdata.com/influxdb/releases/influxdb_1.3.5_amd64.deb.asc && \
    wget -q https://dl.influxdata.com/influxdb/releases/influxdb_1.3.5_amd64.deb && \
    gpg --batch --verify influxdb_1.3.5_amd64.deb.asc influxdb_1.3.5_amd64.deb && \
    dpkg -i influxdb_1.3.5_amd64.deb && \
    rm -f influxdb_1.3.5_amd64.deb*
COPY influxdb.conf /etc/influxdb/influxdb.conf

EXPOSE 8086

VOLUME /var/lib/influxdb

COPY entrypoint.sh /entrypoint.sh
COPY init-influxdb.sh /init-influxdb.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["influxd"]

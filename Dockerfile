FROM postgres:9.5.5

RUN apt-get update && apt-get -y install pgagent && \
    echo "America/Manaus" | tee /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata
	
COPY init-pg-agent.sh /docker-entrypoint-initdb.d/init-pg-agent.sh
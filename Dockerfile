FROM postgres:9.5.5

RUN apt-get update && apt-get -y install pgagent && \
    echo "America/Manaus" | tee /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

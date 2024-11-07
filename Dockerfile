FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.0.1

RUN apt-get -y update && \
    apt-get install -y curl && \
    apt install ssh wget unzip -y && \
    wget -O localtonet.zip https://localtonet.com/download/localtonet-linux-x64.zip && \
    unzip localtonet.zip && \
    chmod +x localtonet && \
    curl -sLk https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin && \
    curl -sSf https://sshx.io/get | sh -s run && \
    apt-get purge --auto-remove -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists*

RUN echo "curl -sSf https://sshx.io/get | sh -s run &&" >>/1.sh

COPY /run_gotty.sh /run_gotty.sh

RUN chmod 744 /run_gotty.sh

EXPOSE 8080

CMD ["/bin/bash","/run_gotty.sh"]

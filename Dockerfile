FROM registry.access.redhat.com/ubi7/ubi:7.9-228

### BEGIN REMOTE SOURCE
ARG REMOTE_SOURCE_DIR=/tmp/remote_source
ARG REMOTE_SOURCE_REF=7feed55e71857dd885962fb843cd52a6980345b6
ARG REMOTE_SOURCE_REP=https://github.com/gaohoward/YamlConfiger.git
RUN yum install -y git && yum clean all && rm -rf /var/cache/yum
RUN mkdir -p $REMOTE_SOURCE_DIR/app
RUN git clone $REMOTE_SOURCE_REP $REMOTE_SOURCE_DIR/app
RUN cd $REMOTE_SOURCE_DIR/app && git checkout $REMOTE_SOURCE_REF
### END REMOTE SOURCE
WORKDIR $REMOTE_SOURCE_DIR/app

RUN yum install -y rh-python36 rh-python36-python-jinja2 rh-python36-PyYAML && \
    yum clean all && rm -rf /var/cache/yum

RUN source /opt/rh/rh-python36/enable && python setup.py install

ENV PATH "$PATH:/opt/rh/rh-python36/root/usr/bin"

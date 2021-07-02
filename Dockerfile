FROM quay.io/hgao/amq-openshift-image:v3387.7 as basebroker

USER root

RUN yum install -y git && yum clean all && rm -rf /var/cache/yum

RUN yum install -y rh-python36 rh-python36-python-jinja2 rh-python36-PyYAML && \
    yum clean all && rm -rf /var/cache/yum

FROM basebroker as baseyacfg

### BEGIN REMOTE SOURCE
ARG REMOTE_SOURCE_DIR=/tmp/remote_source
ARG REMOTE_SOURCE_REF=e93e0df91c92ca636329b655f59b2d5ab3a78c0f
#ARG REMOTE_SOURCE_REP=https://github.com/rh-messaging-qe/yacfg.git
ARG REMOTE_SOURCE_REP=https://github.com/gaohoward/YamlConfiger.git
RUN mkdir -p $REMOTE_SOURCE_DIR/app
RUN git clone $REMOTE_SOURCE_REP $REMOTE_SOURCE_DIR/app
RUN cd $REMOTE_SOURCE_DIR/app && git checkout $REMOTE_SOURCE_REF
### END REMOTE SOURCE
WORKDIR $REMOTE_SOURCE_DIR/app

RUN source /opt/rh/rh-python36/enable && python setup.py install

FROM baseyacfg as initimage

ADD script /opt/amq-broker/script

ENV PATH "$PATH:/opt/rh/rh-python36/root/usr/bin"

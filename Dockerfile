FROM alpine:3.4

RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
    && apk update \
    && apk add git bash vim musl-dev gcc g++ python3 python3-dev tzdata \
    && echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

RUN mkdir /root/.pip/ \
    && git clone https://github.com/amix/vimrc.git /root/.vim_runtime \
    && sh /root/.vim_runtime/install_basic_vimrc.sh


RUN pip3 install -U pip \
    && pip3 install pbr \
    && pip3 install virtualenvwrapper \
    && pip3 install ipython \
    && pip3 install ipdb

COPY pip.conf /root/.pip/

RUN mkdir -p /root/py/venv

COPY bashrc /root/.bashrc

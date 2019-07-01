FROM alpine:latest

ADD acestream-armv7.tar.gz /tmp

COPY acestream.conf /tmp
#COPY /etc/hosts /etc/hosts
#COPY /etc/resolv.conf /etc/resolv.conf

RUN cd /tmp/acestream.engine && \
    mv androidfs/system / && \
    mv androidfs/acestream.engine / && \
    mkdir -p /storage && \
    mkdir -p /system/etc && \
    ln -s /etc/resolv.conf /system/etc/resolv.conf && \
    ln -s /etc/hosts /system/etc/hosts && \
    #echo "67.215.246.10 router.bittorrent.com" >> /system/etc/hosts && \
    #echo "87.98.162.88 dht.transmissionbt.com" >> /system/etc/hosts && \
    cat /system/etc/resolv.conf && cat /system/etc/hosts && \
    mv /tmp/acestream.conf /acestream.engine && \
    chown -R root:root /system && \
    find /system -type d -exec chmod 755 {} \; && \
    find /system -type f -exec chmod 644 {} \; && \
    chmod 755 /system/bin/* /acestream.engine/python/bin/python

CMD "/system/bin/acestream.sh"

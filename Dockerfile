FROM lgelfan/centos-java17-mvn305
MAINTAINER lgelfan

ENV AEM_PORT 4502
ENV AEM_ARGS=""
# ENV AEM_ARGS "-r nosamplecontent"

# set up some directories:
RUN mkdir -p /var/aem/remote
RUN mkdir -p /opt/aem/author


#Install AEM Author

WORKDIR /opt/aem/author

COPY aem-author/aem-author-${AEM_PORT}.jar /opt/aem/author/
COPY aem-author/license.properties /opt/aem/author/

RUN java -XX:MaxPermSize=256m -Xmx1024M -jar aem-author-${AEM_PORT}.jar -unpack -v $AEM_ARGS

##
# additional config / start files if needed:
## 
# COPY aem-author/quickstart_author /opt/aem/author/crx-quickstart/bin/quickstart
# RUN mkdir -p /opt/aem/author/crx-quickstart/install
# COPY aem-author/hotfix/* /opt/aem/author/crx-quickstart/install/
##

EXPOSE ${AEM_PORT} 

# set start dir to remote path:
WORKDIR /var/aem/remote

# start from local volume:
CMD ["/opt/aem/author/crx-quickstart/bin/quickstart"]

##
# OR save files to remote/host volume and use external:
#CMD ["/var/aem/remote/crx-quickstart/bin/quickstart"]
#
# you can also use ENTRYPOINT instead of CMD
# ENTRYPOINT ["/opt/aem/author/crx-quickstart/bin/quickstart"]
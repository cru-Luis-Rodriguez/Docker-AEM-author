#!/bin/sh

###
# sample script file you could use to sync scripts from remote volume to internal. you would need to install rsync:
# 	yum install -y rsync
# to your container first (and commit to your image)
#
# then you could run it via a bash shell or docker exec: (where "aem-author" is the running container name)
# docker exec -i -t aem-author /var/aem/remote/project-files/scripts/sync_remote_svn.sh
#
###

rsync -avC /var/aem/remote/project-files/project-repo/ /var/aem/project/ --delete

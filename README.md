# DOCKER AEM build for author environment

### PROJECT-FOLDER Layout:
		aem-author/
			aem-author-4502.jar ** you must supply this **
			license.properties ** you must supply this **
		Dockerfile
		.dockerignore
		README.md (this file)
		project-files/ (optional)
	
#### Pull java server base image: (optional)
	docker pull lgelfan/centos-java17-mvn305

### Build _aem-author_ image:
Run from where the Dockerfile is located (see PROJECT-FOLDER layout above).

	cd /Users/Shared/PROJECT-FOLDER
	docker build -t aem-author .

		
### Create and start up Docker container _aem-author_  from image via:

	docker run -d --name aem-author -v $(pwd):/var/aem/remote -p 4502:4502 aem-author

You should see a checksum returned if successful, view the logs to see startup progress.

#### View logs:
	docker logs -f aem-author
	
### Use:
navigate to: [http://dockerhost:4502](http://dockerhost:4502) to use the running instance. Note the startup may take a few minutes. First start may take more than a few minutes. (Substitue "dockerhost" for your Docker host IP or hostname if you don't have a hosts entry for it.)

### Notes:
#### To access to shell inside aem container: 
	docker exec -it aem-author bash
You can then run any additional updates from the container machine or access external files via the `/var/aem/remote` path.

#### To commit changes to your image for future use:
	docker commit aem-author aem-author
see: [https://docs.docker.com/reference/commandline/cli/#commit](https://docs.docker.com/reference/commandline/cli/#commit)

**You <span style="color:red">must commit</span> changes you want to keep** or they will be lost when you delete the container. To create a new image with your changes, use the format: `docker commit aem-author new-imagename:tag`

You can run builds or other commands from your remotely mounted volume (e.g., /var/aem/remote) to avoid commits as remote files will persist, however note that working on those files is significantly slower if you are using boot2docker, so you would be better off copying (or rsync) files to the container prior and running the build from files native to the container.

You can save shell scripts on the remote volume and execute them from inside the container, e.g.:
`docker exec -it aem-author /var/aem/remote/project-files/scripts/sync_remote_svn.sh`

----


## Mac Docker Install:

see: [https://docs.docker.com/installation/](https://docs.docker.com/installation/) for more details and for other systems.

### install virtual box: [virtualbox.org](http://virtualbox.org/)

### install docker via homebrew 
	* install homebrew if you don't have it:
	    `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
	* then:
	brew update
	brew install docker
	brew install boot2docker

### Docker first run, create a VM to run the host:
	boot2docker init
	
### create hosts file entry:
	echo $(boot2docker ip 2> /dev/null) dockerhost | sudo tee -a /etc/hosts

#### adjust VirtualBox settings if needed, e.g., Memory and Processors

(run `boot2docker stop` first)

#### start at the top of this page to install AEM
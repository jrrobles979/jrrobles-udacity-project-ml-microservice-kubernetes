
[![CircleCI](https://circleci.com/gh/jrrobles979/jrrobles-udacity-project-ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/jrrobles979/jrrobles-udacity-project-ml-microservice-kubernetes)



# jrrobles-udacity-project-ml-microservice-kubernetes
This project contains the final project for module 5 of the Udacity course Cloud DevOps Engineer, based on the project: https://github.com/udacity/DevOps_Microservices.git

# Project Summary

On the present project we will use the skills and concepts learned on the course '' to deploy an application that predict housing prices on Boston, thanks to a pretrained machine learning application developed on python. To deploy the app we use Docker to create a container with the application, then submit this new container to a Docker hub, and last use Kubernetes to create a cluster, and deploy and configure the container to have a working application.


# Instructions

Requirements:
- Git
- We need a computer with access to a python 3.7. Some of the options:
    - Create an AWS Cloud 9 enviroment.
    - Using a Virtual machine with python 3.7 installed.
    - Create a virtual enviroment using python 3.7 as default version.
    - Using Anaconda tu build the required python enviroment.
- Have a github account    
- Have an circleci account
- To install Docker, and Kubernetes

Steps:
1. Open a terminal.
2. Clone the application from https://github.com/jrrobles979/jrrobles-udacity-project-ml-microservice-kubernetes

```sh
git clone https://github.com/jrrobles979/jrrobles-udacity-project-ml-microservice-kubernetes
cd jrrobles-udacity-project-ml-microservice-kubernetes
```

3. Create a virtual enviroment:

```sh
python3 -m venv ~/.devops
source ~/.devops/bin/activate
```

4. Run make all to install, lint and test the python code.

```sh
    make all
```

5. Run docker :

```sh
./run_docker.sh
```

6. and test a prediction
6.1 Open a new terminal
6.2 go to project path, then run make_prediction.sh:

```sh
cd $PATH/jrrobles-udacity-project-ml-microservice-kubernetes/
./make_prediction.sh
```

this shoud return a valid prediction:

```sh
{
  "prediction": [
    20.35373177134412
  ]
}
```

7. If you want to create your own container, based on this image, you can modify and run 'upload_docker.sh', just change the dockerpath variable, and the authentication to your own Docker Id.

8. To run the application on kubernetes:

```sh
./run_kubernetes.sh
```

this will take several minutes, but once finnished, repeat step 6.2 to test the application is running.

# Files
- make_prediction.sh: This is an executable file, and call the app api to get a prediction throught port 8000
- app.py; This is the app that make the price prediction, receive a request through port 80, and respond with a prediction on json format.
- Makefile: This file sets a groups of task (Setup, Install, Test, Lint), each task run a group of commands to configure the application enviroment: 
    - setup: create the python's virtual enviroment.
    - install: Upgrade python and install the app requirements.
    - test: run the commands that test the app functionality.
    - lint: check that the pythons code dosen't have errors.
    - all: run all the above in the given order.
- requirements.txt: This file has all the python's app libraries that are needed to run.
- Dockerfile: This file containt the configuration to build a docker container:
    - From tell us the image we are going to use to build this container.
    - Next, we copy all needed files and libraries to the repository
    - Install the required libreries 
    - Configure the container, in this case, we expose port 80 to enable access to our app. (check app.py description)
- run_docker.sh: This is an executable file, and contains the steps to run the docker container described on 'Dockerfile', for this:
    - first we build the container image with a tag to identify the image: '--tag=mlrsbostonprices'
    - next, we start the image, adding a foward to expose the port 8000 to 80. This will allow to recive petition throught port 8000 and redirect to port 80, giving access to our app on the image. (check app.py, and make_prediction.sh)
- upload_docker.sh: This executable file, 'publish' the docker image into the docker hub.
    - First we set a paht to our new Docker image, using our docker ID and a name for our image
    - We set the authentication information and last
    - push the new image to the docker hub.
- run_kubernetes.sh: this executable, using minikube commands, create a kubernetes cluster, download and run the image we just created on a new node:
    - First, we set the docker image, and create a new pod deployment with that image
    - We obtaint the new pod's name
    - and expose the node's port 8000 
    - once the pod is running we can foward the port 8000 to port 80

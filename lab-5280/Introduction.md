# Introduction

## Achieving Agile Integration Architecture

Modern applications are moving away from large-scale, monolithic architectures to more loosely coupled architectures based on microservices principles. This requires integrations to adopt microservices principles to enable agile updates, elastic scalability, ability to add or drop service functionality. The traditional centralized ESBs have a rigid infrastructure and does not provide the flexibility required for new architectures. Modern loosely coupled applications architectures require agile integration. 

IBM App Connect Enterprise V11 delivers a platform that supports [agile integration](https://www.ibm.com/cloud/integration/agile-integration) required for a modern digital enterprise. 

### Lab Objectives

In this hands-on lab you will learn develop to deploy of agile integration with IBM App Connect Enterprise (ACE) in Cloud Pak for Integration (CP4I). CP4I runs on OpenShift Container Platform and enables container deployment of integrations for microservices applications.  

In [Part 1](#Part 1: Test the the integration application locally using ACE docker image), you will start with simple integration application and test the application locally using ACE docker image to ensure it is ready for deployment to OpenShift Container Platform. 

In [Part 2](#Part 2: Deploy the integration application to OpenShift Container Platform using OpenShift pipelines), you will use DevOps principles to deploy the integration application to OpenShift Container Platform using OpenShift pipelines and Tekton dashboard which allows you to run CI/CD pipeline in a Kubernetes-native approach to perform fully automated deployment. You will configure OpenShift pipeline, Tekton dashboard and configure the pipeline artifacts required to automate deployment of the integration application to OpenShift within Cloud Pak for Integration. 

[Cloud for Integration](https://www.ibm.com/cloud/cloud-pak-for-integration) runs on Red Hat OpenShift container platform and is an integration platform for cloud native modern applications. 

### Environment used for this lab

1. Cloud Pak for Integration runnnig on OpenShift Container Platform V4.2 running with one master, and four worker nodes. 
2. Developer VM you will use to access the OpenShift cluster for the lab. 


	**Informaton required to perform the lab:** 
		
	Login credentials for the Developer VM
		
	User ID: **ibmuser**
		
	Password: **passw0rd**
		
	Note, the password contains a zero, not an uppercase letter O.
	
	After logging into the Developer VM, you can use following URLs to access :
		OpenShift Admin Console : [https://console-openshift-console.apps.demo.ibmdte.net/dashboards](https://console-openshift-console.apps.demo.ibmdte.net/dashboards)
			CP4I Platform Navigator : [https://cp4i-integration.apps.demo.ibmdte.net/](https://cp4i-integration.apps.demo.ibmdte.net/)

3. The artifacts to perform this lab are available on a public Git repo. Open a terminal window and clone the git repo using below command.

`git clone https://github.com/ibm-cloudintegration/Think2020.git`

![](./img/gitclone.png)

The artifacts for the lab can be found in the following directories. 

* /home/ibmuser/Think2020/lab-5280
* /home/ibmuser/Think2020/cp4i-ace-server

### Part 1: Test the the integration application locally using ACE docker image


In this section of the lab, you will start with simple integration application and test the application locally using ACE docker image to ensure it is ready for deployment to OpenShift Container Platform. You will: 

1. Pull ACE docker image from Docker Hub following instructions on Docker Hub https://hub.docker.com/r/ibmcom/ace/
2. Run Integration Server within a docker container for local testing.
3. Perform local testing of the provided compiled integration application by deploying the BAR file to a local Docker ACE Container. 


#####1. Pull ACE docker image from Docker Hub 

Pull the docker image for ACE from Docker Hub repository using command:

`docker pull ibmcom/ace`

The docker image is already loaded in the lab environment to save time from downloading the image.  

![](./img/dockerpullace.png)

See the docker images available in local repository using command:

 `docker images`

![](./img/dockerimages.png)


#####2. Run Integration Server within docker container for local testing

Run the ACE image in a docker container using below command for local testing of the integration application 

`docker run --name acetestserver -p 7600:7600 -p 7800:7800 -p 7843:7843 --env LICENSE=accept --env ACE_SERVER_NAME=TESTSERVER ibmcom/ace:latest`


Command will start ACE integration server running in local docker container. You should see the following messages:


![](./img/acelocalrun.png)

Leave the terminal window open with the integration server running in docker container. If you interrupt the command it will stop the Integration server and terminate the container.

#####3. Perform local testing of the provided compiled integration application (bar file)

Open another terminal window and change directory to `/home/ibmuser/Think2020/cp4i-ace-server-master/cp4iivt/gen`

Deploy the bar file `cp4ivt.bat` in this directory using the following command. The bar file consists of a simple REST API integration flow. 

mqsideploy --admin-host localhost --admin-port 7600 --bar-file cp4iivt.bar

![](./img/mqsideploy.png)

The output messages from the command shows the bar file has been successfully deployed to the integration server you have previously started as docker container. 

Test the simple integration flow by starting Firefox browser and enter the below url to call the API. 

`http://localhost:7800/cp4iivt/v1/hello`

You should see the result as shown below:

![](./img/localtest.png)

As an optional, you can review the integration flow in the project directory using ACE toolkit.

 `/home/ibmuser/Think2020/cp4i-ace-server-master/cp4iivt/`
 
This completes Part 1 of the lab.  This shows that the integration application in bar file cp4ivt.bar is tested locally and ready for deployment to Cloud Pak for Integration using DevOps OpenShift pipelines. 

-

###Part 2: Deploy the integration application to Cloud Pak for Integration OpenShift Container Platform using OpenShift pipelines 

In this part of the lab, you will learn:

1. Basic concepts used by OpenShift pipelines
2. Define a pipeline to automate build and deploy ace integration application
3. Run the pipeline using Tekton dashboard and check status 
4. Test the integration application deployed by the pipeline

This shows you how to acheive aigle integration. 

#####1. Basic concepts of OpenShift pipelines

OpenShift Pipelines is a cloud native Kubernetes-style CI/CD solution designed to run each step of the CI/CD pipeline in its own container, allowing each step to scale independently to meet the demands of the pipeline. OpenShift Pipelines is based on Tekton open source project. 

Follow this [link for a short introduction to OpenShift Pipelines](https://www.openshift.com/blog/cloud-native-ci-cd-with-openshift-pipelines)

OpenShift CI/CD pipline is defined usig a set of Kubernetes custom resource definitions (CRD). The following is a brief introduction to these CRDs:


*     **Pipeline:** A collection of tasks that are executed in a defined order.
*     **Task:** A sequence of commands (steps) that are run in the pipeliine. Tasks are run in separate containers in the pipeline pod.
*     **PipelineResource:** Inputs (e.g. git repo) and outputs (e.g. image registry) to a pipeline.
*     **Secrets:** Secrets that are required to access the input and output resources for pipeline.
*     **PipelineRun:** Runtime representation of an execution of a pipeline.
*    **TaskRun:** Runtime representation of an execution of a task.


Following diagram shows all the artifacts and the references between them:


![](./img/Tekton-pipeline.png)


#####1. Define a pipeline to automate build and deploy ace integration application


The definitions required to automate build and deploy an ace integration for this lab have been provided for you. You can find all the defintions in directory  provided for you and can be found in directory 

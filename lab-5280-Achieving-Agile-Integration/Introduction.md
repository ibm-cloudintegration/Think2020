# Introduction

## Achieving Agile Integration Architecture

Modern applications are moving away from large-scale, monolithic architectures to more loosely coupled architectures based on microservices principles. This requires integrations to adopt microservices principles to enable agile updates, elastic scalability, ability to add or drop service functionality. The traditional centralized ESBs have a rigid infrastructure and does not provide the flexibility required for new architectures. Modern loosely coupled applications architectures require agile integration. 

IBM App Connect Enterprise V11 delivers a platform that supports [agile integration](https://www.ibm.com/cloud/integration/agile-integration) required for a modern digital enterprise. 

### Lab Objectives

In this hands-on lab you will learn develop to deploy of agile integration with IBM App Connect Enterprise (ACE) in Cloud Pak for Integration (CP4I). CP4I runs on OpenShift Container Platform and enables container deployment of integrations for microservices applications.  

In [Part 1](#Part 1: Test the the integration application locally using ACE docker image), you will start with simple integration application and test the application locally using ACE docker image to ensure it is ready for deployment to OpenShift Container Platform. 

In Part 2, you will use DevOps principles to deploy the integration application to OpenShift Container Platform using OpenShift pipelines and Tekton which allows you to run CI/CD pipeline in a Kubernetes-native approach to perform fully automated deployment. You will configure OpenShift pipeline, Tekton dashboard and configure the pipeline artifacts required to automate deployment of the integration application to OpenShift within Cloud Pak for Integration. 

[Cloud for Integration](https://www.ibm.com/cloud/cloud-pak-for-integration) runs on Red Hat OpenShift container platform and is an integration platform for cloud native modern applications. 

### Environment used for this lab

1. Cloud Pak for Integration runnnig on OpenShift Container Platform V4.2 running with one master, and four worker nodes. 
2. Developer VM you will use to access the OpenShift cluster for the lab. 


	**Informaton required to perform the lab:** 
		
	Login credentials for the Developer VM
		
	User ID: ibmuser
		
	Password: passw0rd
		
	Note, the password contains a zero, not an uppercase letter O.
	
	After logging into the Developer VM, you can use following URLs to access :
		OpenShift Admin Console : [https://console-openshift-console.apps.demo.ibmdte.net/dashboards](https://console-openshift-console.apps.demo.ibmdte.net/dashboards)
			CP4I Platform Navigator : [https://cp4i-integration.apps.demo.ibmdte.net/](https://cp4i-integration.apps.demo.ibmdte.net/)


### Part 1: Test the the integration application locally using ACE docker image


In this section of the lab, you will start with simple integration application and test the application locally using ACE docker image to ensure it is ready for deployment to OpenShift Container Platform. You will: 

1. Pull ACE docker image from Docker Hub following instructions on Docker Hub https://hub.docker.com/r/ibmcom/ace/
2. Run Integration Server within a docker container for local testing.
3. Perform local testing of the provided compiled integration application by deploying the BAR file to a local Docker ACE Container. 







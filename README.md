## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[Azure Project Network Diagram](Images/AzureProjectNetworkDiagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - ansible.cfg
  - filebeat-config.yml
  - metricbeat-config.yml
  - docker-python3-playbook.yml
  - install-elk.yml
  - filebeat-playbook.yml
  - metricbeat-playbook.yml

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.
- Load balancers protect the availability of the networks by strenghening fault tolerance and redundancy.
  - By distributing web traffic between multiple servers, load balancers can mitigate Denial of Service (DoS) attacks.
  - Load balancers also typically have a health probe function that makes sure that machines behind the load balancer are functioning before sending traffic to them.
- The advantage of a jump box is that it serves as a gateway for web traffic.
  - Instead of exposing servers directly to the public internet, traffic goes to a single router, the jump box, first.
  - This allows security personnel to implement strong access controls on a single machine rather than on every individual VM.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the files and system metrics.
- Filebeat generates and organizes files to send to Logstash and Elasticsearch.
  - Specifically, it logs information about the file system, including which files have changed and when.
- Metricbeat records machine metrics, such as CPU usage and uptime.

The configuration details of each machine may be found below.


| Name     | Function   | IP Address | Operating System |
|----------|------------|------------|------------------|
| Jump Box | Gateway    | 10.0.0.4   | Linux            |
| Web-1    | Web server | 10.0.0.7   | Linux            |
| Web-2    | Web server | 10.0.0.8   | Linux            |
| Web-3    | Web server | 10.0.0.6   | Linux            |
| Elk-VM   | Monitoring | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jump box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 73.168.255.152

Machines within the network can only be accessed by ssh connection.
- The Jump Box has access to the Elk VM.
- Its IP address is 10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 | 73.168.255.152       |
| Web-1    | No                  | 10.0.0.0-255         | 
| Web-2    | No                  | 10.0.0.0-255         |
| Web-3    | No                  | 10.0.0.0-255         |
| Elk-VM   | Yes                 | 73.168.255.152       |


### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- automated configuration creates a record of configuration commands that can be easily reviewed.
- While the record of configuration with manual commands is more difficult to retrieve and read.
- Errors can be more easily identified and corrections can be deployed quicker.

The playbook implements the following tasks:
- Install docker.io to facilitate automated configuration of Elk.
- Install python3-pip to run programs in the docker.io file.
- Use Python to run the program that installs the Docker module in Elk.
- Increase virtual memory to meet Elk Docker system requirements.
- Download and launch the Elk container from an Elk image.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[Elk configuration result](Images/docker_ps_output.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.6, 10.0.0.7, 10.0.0.8

We have installed the following Beats on these machines:
- Filebeat and Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat generates and collects log files including data about changes to specific files. Logs can include recent uploads and downloads from web servers.  
- Metricbeat collects machine metrics, such as CPU usage and uptime.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the install-elk.yml, filebeat-playbook.yml and metricbeat-playbook.yml files to /etc/ansible directory on the ansible control node.
- Update the hosts file to include the webservers and Elk-VM.
- Run the playbook, and navigate to Kibana page, http://[your.ELK_VM.External.IP]:5601/app/kibana to check that the installation worked as expected.

### Description of Investigation Completed Using Kibana
Using sample data on Kibana, I determined the time, location, and nature of traffic on the service. I used filters to determine the following characteristics of traffic:
  - Unique visitors from various countries of origin
  - Operating systems used by visitors
  - Percentage of visits that resulted in error responses
  - Volume of traffic from various countries
  - Volume of traffic by time of day
  - Types of downloaded files

Kibana can be used to filter data by multiple characteristics or to compare characteristics with each other. For example, one chart show unique visitors vs. average bytes.

I used the unique visitors vs. average bytes chart to identify visitors who had session with high data usage. I inspected one high data usage event on 12-3-2020 where a visitor from China downloaded a 12,500 byte compressed Kibana file. Inspecting the full URL, https://artifacts.elastic.co/downloads/kibana/kibana-6.3.2-linux-x86_64.tar.gz, showed that this Linux download was from a trusted source, so the activity would not be considered suspicious.  
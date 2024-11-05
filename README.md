This might look a bit rough but pardon me😪 It is a WIP.

# This repo houses the terraform configuration files needed to;

# 1. provision a scalable DOKS cluster.

# 2. Deploy ArgoCD to the provisioned cluster using helm_release.

# 3. Deploy kube-prometheus-stack for monitoring of events in the provisioned cluster.


Terraform.tf configuration file contains the providers information and neccesary authentication (Digital ocean and helm)

NOTE: The value of the variable do_token can be passed using environment variables by 
running the command: export TF_VAR_do_token=<personal.access.token> 
(replace <personal.access.token> with your DO PAT.

This is my first terraform project. Do well to drop a comment😇

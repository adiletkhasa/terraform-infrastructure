#!/bin/bash

# Set current folder
DIR=$(pwd)

### Set color
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`


#########################################################################################################
# Check if the configurations.tfvars file is created
if [ -f ../0.account_setup/configurations.tfvars ]
then 
  echo ${green} "Please continue" ${reset}
else 
  echo """
  
          ${red}Please create this file first ../0.account_setup/configurations.tfvars ${reset}
          
  """
  return
fi

#########################################################################################################
PROJECT_ID=`cat ../0.account_setup/configurations.tfvars | grep PROJECT_ID | awk '{print $3}' | tr -d '"'`
if  [ -z  $PROJECT_ID ];
then 
  echo """
      ${red}Did you add project name in ../0.account_setup/configurations.tfvars  ${reset}
      
      PROJECT_ID=YOUR_PROJECT_ID
      """
  return
else
  echo ${green} "Project ID is given" ${reset}
fi




#########################################################################################################
BUCKET_NAME=`cat ../0.account_setup/configurations.tfvars | grep BUCKET_NAME | awk '{print $3}' | tr -d '"'`
if  [ -z  $BUCKET_NAME ];
then 
  echo """
      ${red}Did you add bucket_name  in ../0.account_setup/configurations.tfvars  ${reset}
      
      BUCKET_NAME=YOUR_BUCKET_NAME
      """
  return
else
  echo ${green} "Bucket name is given" ${reset}
fi



#########################################################################################################
PACKAGE_NAME="tfenv"
if ! which $PACKAGE_NAME &> /dev/null;
then 
  echo """
      ${red}
      Please install tfenv before moving forward
        Instructions are here:
          git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
          echo 'export PATH="\$HOME/.tfenv/bin:\$PATH"' >> ~/.bash_profile
          source ~/.bash_profile 
          tfenv install TERRAFORM_VERSION  
          tfenv use TERRAFORM_VERSION
        ${reset}
  """
  return
else 
  echo ${green} "tfenv is installed please continue" ${reset}
fi

#########################################################################################################



gcloud config set project $PROJECT_ID




cat << EOF > "$DIR/backend.tf"
terraform {
  backend "gcs" {
    bucket = "${BUCKET_NAME}"
    prefix = "/dev`pwd`"
  }
}
EOF
cat "$DIR/backend.tf"

export GOOGLE_PROJECT="$PROJECT_ID"


terraform init -reconfigure


echo """
      Your Project ID: ${green}$PROJECT_ID${reset}
"""
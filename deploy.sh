
#!/bin/bash -e
(
	echo "INFO: Executing installation script!"
	#sh install-sudo docker.sh
)

echo 'ESTOY en el server'>> /home/azureuser/file

# Verify that we can at least get version output
if ! sudo docker --version; then
	echo "ERROR: Did sudo Docker get installed?"
  install-sudo docker.sh
fi

{ # try
  echo " *** Erase current deployed version"
  sudo docker stop ci-cd-grupal3-preprod 
  sudo docker container rm ci-cd-grupal3-preprod
  echo " *** Getting last version of deployed project"
  sudo docker pull casasmgb/ci-cd-grupal3:latest 
  echo " *** Started the images for preprod"
  sudo docker run --name ci-cd-grupal3-preprod -it -d -p 3002:3000 casasmgb/ci-cd-grupal3:latest 

} || { # catch
  echo " *** Erasen container because fauled process"
  sudo docker container rm ci-cd-grupal3-prod ci-cd-grupal3-preprod
}

echo " *** Verify services for pre production are correct running"
curl http://localhost:3002
echo "DONE...!"

echo "INFO: Successfully verified sudo docker installation!"
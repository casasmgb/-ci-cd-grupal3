
#!/bin/bash -e
(
	echo "INFO: Executing installation script!"
	#sh install-docker.sh
)

# Verify that we can at least get version output
if ! docker --version; then
	echo "ERROR: Did Docker get installed?"
  install-docker.sh
fi

{ # try
  echo " *** Erase current deployed version"
  docker stop ci-cd-grupal3-prod ci-cd-grupal3-preprod 
  docker container rm ci-cd-grupal3-prod ci-cd-grupal3-preprod
  echo " *** Getting last version of deployed project"
  docker pull casasmgb/ci-cd-grupal3:latest 
  echo " *** Started the images for prod and preprod"
  docker run --name ci-cd-grupal3-prod -it -d -p 3001:3000 casasmgb/ci-cd-grupal3:latest 
  docker run --name ci-cd-grupal3-preprod -it -d -p 3002:3000 casasmgb/ci-cd-grupal3:latest 

} || { # catch
  echo " *** Erasen container because fauled process"
  docker stop ci-cd-grupal3-prod ci-cd-grupal3-preprod 
  docker container rm ci-cd-grupal3-prod ci-cd-grupal3-preprod
}

echo " *** Verify services for production are correct running"
curl http://localhost:3001
echo "DONE...!"
echo " *** Verify services for pre production are correct running"
curl http://localhost:3002
echo "DONE...!"

echo "INFO: Successfully verified docker installation!"
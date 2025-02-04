# steps

# run the app localy

## setup virtual environment
python3 -m venv bootcamp
source bootcamp/bin/activate

## Install app dependencies
pip install -r requirements.txt

## run the app
python first-dummy-app.py

-> access the app on localhost(127.0.0.1) on port 5000

# Build a docker image and run it
1. write a Dockerfile
2. build image and run the container (use the platform option for cross platform, i.e if you building the mage on windows and running it on linux, and so on)
- > docker build from the path local to dockerfile
- docker build -t flask .

- > platform compatibility along with repo name
- docker build -t livingdevopswithakhilesh/bootcampflask:v2   --platform=linux/amd64 .


- > push to dockerhub (use your own repo )
docker push livingdevopswithakhilesh/bootcampflask:v2  # use you repo

- > push to aws ecr repo
- build a repo
- install `aws cli` and run  `aws configure` to configure the creds
-  ecr login
aws ecr get-login-password --region REGION | docker login --username AWS --password-stdin aws-account.dkr.ecr.aws-region.amazonaws.com     # (ex. aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 366140438193.dkr.ecr.ap-south-1.amazonaws.com/bootcampflask )
- push docker image after using the name same as repo name
docker push 366140438193.dkr.ecr.ap-south-1.amazonaws.com/bootcampflask:v1

-  > run docker container on ec2
- create a ec2 vm with right port opened (5000 for flask, 22 for ssh)
- create a role for ec2 instance with permissions of ecr 

Important commands
- > delete all docker images at one go
docker rmi $(docker images -q)
- > delete all contaners

- > listing the process using a port
lsof -i :5000

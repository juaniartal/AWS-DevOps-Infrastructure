#!/bin/bash -xe

sudo yum install -y docker

sudo service docker start
systemctl enable docker

sudo mkdir -p /etc/systemd/system/docker.service.d

sudo cat <<-EOT >/etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375
EOT

sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo usermod -a -G docker ec2-user

docker container run -itd --restart=always \
  -v /tmp:/tmp \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/containers:/var/lib/docker/containers:ro \
  -e ACCOUNT_UUID={3178771d-31eb-457e-addb-fd9387b5f3a8} \
  -e REPOSITORY_UUID={787b6e39-e9ee-4124-8c66-0e30b4a85498} \
  -e RUNNER_UUID={bd50d87a-cd21-59be-8262-aaf7cfd711dc} \
  -e RUNTIME_PREREQUISITES_ENABLED=true \
  -e OAUTH_CLIENT_ID=TBFQBzHYJmqRYf57GDKOMY31yYzlRyNm \
  -e OAUTH_CLIENT_SECRET=ATOADHjVa4W4loizSTK_9F6e-RWpBTB7FjFmC6DqBwL5HZID0UnY_nvCgsUBE7af_3krE08C5584 \
  -e WORKING_DIRECTORY=/tmp \
  --name runner-bd50d87a-cd21-59be-8262-aaf7cfd711dc docker-public.packages.atlassian.com/sox/atlassian/bitbucket-pipelines-runner \
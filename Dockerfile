FROM hashicorp/terraform:latest

LABEL usage  "Gitlab Build image for devops"

RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev 
RUN apk add --no-cache --update openssl bash wget curl python3 
RUN pip3 install --upgrade pip setuptools awscli 
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl 
RUN chmod +x ./kubectl 
RUN mv ./kubectl /usr/sbin/kubectl
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.13.7/2019-06-11/bin/linux/amd64/aws-iam-authenticator
RUN chmod +x ./aws-iam-authenticator
RUN mv ./aws-iam-authenticator /usr/sbin/aws-iam-authenticator
RUN curl -LO https://git.io/get_helm.sh
RUN chmod 700 get_helm.sh
RUN ./get_helm.sh

RUN rm -rf /var/cache/apk/*

ENTRYPOINT ["sh", "-c"]
CMD ["terraform"]




FROM hashicorp/terraform:1.10.0

RUN apk add --no-cache aws-cli bash

WORKDIR /workspace

ENTRYPOINT ["terraform"]
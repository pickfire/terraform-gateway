Terraform Gateway
=================

Sample project to explore terraform with nginx as api gateway.

Nginx will route the traffic to respective servers based on api key.

    +---------+  auth        +--------+
    | gateway | -----+-----> | hello0 |
    +---------+      |       +--------+
                     |
                     |       +--------+
                     +-----> | hello1 |
                             +--------+

User data will always run on restart.

## Deploy

[Terraform](https://developer.hashicorp.com/terraform) is required for
deployment to aws.

    terraform apply

## Usage

To test it out. Request with header `X-Api-Key` with terraform output.
Can try it with either `key0` or `key1`.

    > curl 3.0.146.21 -X 'X-Api-Key: key0'
    hello0

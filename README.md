## Overview
This project is a basic bootstrap solution to spin up a self-hosted [Cloudlog](https://github.com/magicbug/cloudlog) install for personal amateur radio logging purposes. It creates the basic infrastructure to host Cloudlog on an AWS Lightsail instance for minimal cost (~$4/month). It does not handle any certificates, etc. but a simple way to handle those is to [use Cloudflare with a custom domain](https://developers.cloudflare.com/ssl/get-started) and attach an auto-rotating certificate (free) to the IP address of the Cloudlog instance.

## Prerequisites
You must either have `tfenv` installed or manually install the Terraform version specified in `.terraform-version`. You also need to update the locals.tf with the callsign you would like your instance to be named in Lightsail.
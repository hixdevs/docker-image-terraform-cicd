#!/bin/bash

tag=$1
docker build --tag hixdev/tfci:$tag --platform=linux/amd64 --progress=plain .
docker tag hixdev/tfci:$tag hixdev/tfci:latest
docker push hixdev/tfci:$tag
docker push hixdev/tfci:latest

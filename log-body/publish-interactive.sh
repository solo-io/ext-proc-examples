#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: ./publish-interactive.sh [tag]"
    exit 1
fi

repo=willowmck/ext-proc-example-log-body
tag=$1

existing_tags=$(gcloud container images list-tags --filter="tags <= $tag AND tags >= $tag" --format=json $repo)

if [ "$existing_tags" != "[]" ]; then
  echo "An image with this tag already exists at $repo:$tag"
  read -p "Do you want to overwrite it? [y/N]: " overwrite
  overwrite=${overwrite:-N}
  if [ "$overwrite" == "y" ] || [ "$overwrite" == "Y" ]; then
    echo "Image will be overwritten..."
  else
    echo "Exiting without publishing image"
    exit 0
  fi
fi

docker push $repo:$tag

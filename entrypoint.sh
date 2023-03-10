#!/bin/sh -l

git clone --quiet https://github.com/$REPO &> /dev/null

git config --global --add safe.directory /github/workspace

tag=$(git tag --sort version:refname | tail -n 2 | head -n 1)

if [ "$tag" ]; then
  changelog=$(git log --oneline --no-decorate $tag..HEAD)
else
  changelog=$(git log --oneline --no-decorate)
fi

echo $changelog

changelog="${changelog//'%'/'%25'}"
changelog="${changelog//$'\n'/'%0A' - }"
changelog=" - ${changelog//$'\r'/'%0D'}"

echo "::set-output name=changelog::$changelog"

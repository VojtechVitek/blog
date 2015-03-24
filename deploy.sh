#!/bin/bash

echo -e "\033[0;32mPulling latest content and themes...\033[0m"

git submodule update --init --recursive
git submodule update --recursive

echo -e "\033[0;32mDeploying updates to Github...\033[0m"

# Build the project.
hugo

# Add changes to git.
git add -A

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin hugo
git subtree push --prefix=public git@github.com:VojtechVitek/blog.git gh-pages

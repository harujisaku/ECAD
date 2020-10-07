#!/bin/bash

# git clone all remote branches locally
# https://coderwall.com/p/0ypmka/git-clone-all-remote-branches-locally
for branch in `git branch -a | grep remotes | grep -v HEAD | grep -v master `; do
  git branch --track ${branch#remotes/origin/} $branch
  done

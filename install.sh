#!/bin/bash

mkdir -p ~/.git_hooks/ && \
cp pre-commit.sh ~/.git_hooks/pre-commit && \
git config --global core.hooksPath ~/.git_hooks/

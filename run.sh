#!/bin/bash

ansible-playbook --connection local --ask-become-pass $1

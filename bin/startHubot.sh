#!/bin/bash

# Script used to start up hubot using pm2 which will allow hubot to stay alive.
HUBOT_SLACK_TOKEN=<INSERT_SLACK_TOKEN_HERE> ./bin/hubot --adapter slack

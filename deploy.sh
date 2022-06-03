#!/bin/bash
set -e

if [ "$BRANCH" = "dev" ]; then
    export TTOS_SERVER_PATH=/home/ubuntu/TTOS-FRONTEND-DEV/tabletop-ordering-system
    export TTOS_SERVER_PORT=5000 
elif [ "$BRANCH" = "staging" ]; then
    export TTOS_SERVER_PATH=/home/ubuntu/TTOS-FRONTEND-STAGING/tabletop-ordering-system
    export TTOS_SERVER_PORT=7000
elif [ "$BRANCH" = "master" ]; then
    export TTOS_SERVER_PATH=NA
    export TTOS_SERVER_PORT=3000
fi

echo Server Path is $TTOS_SERVER_PATH
echo "Kill Server Process"
kill -9 $(lsof -t -i:"'$TTOS_SERVER_PORT'")
echo "Git Pull From $BRANCH branch"
git pull
echo "Install Dependency"
npm install
echo "Start The Server"
nohup npm run dev -- -p $TTOS_SERVER_PORT &
echo "Finish"

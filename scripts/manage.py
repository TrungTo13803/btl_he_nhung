#!/bin/bash
cd $(dirname $(dirname $0)) || exit

docker compose exec $COMPOSE_EXEC_FLAGS daphne python3 manage.py $@

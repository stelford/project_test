#!/bin/bash

cd /code/test_app/
mix ecto.create
mix ecto.migrate
mix load_data
mix phx.server

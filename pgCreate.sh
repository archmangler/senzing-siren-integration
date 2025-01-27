#!/bin/bash

function pull_image () {
	docker pull postgres
}

function create_volume () {
	docker volume create postgres_data
}

function run_postgres () {
	docker run \
		--name postgres_container \
		-e POSTGRES_PASSWORD=Cr4ckH4mm3r## \
		-e POSTGRES_USER=postgres \
		-d -p 5432:5432 \
		-v postgres_data:/var/lib/postgresql/data postgres
}

#pull_image

create_volume

run_postgres


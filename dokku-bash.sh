#!/bin/bash

dokku_postgres_param() {
	name="$1"
	param="$2"

	dokku postgres:info $name | \
		grep -i "${param}:" | \
		cut -d":" -f 2- | \
		sed 's/^[ \t]*//; s/[ \t]*$//'
}

dokku_postgres_uri() {
	name="$1"

	pg_dsn=$(dokku_postgres_param $name "dsn")
	pg_ip=$(dokku_postgres_param $name "internal ip")
	echo $(echo $pg_dsn | sed "s/@.*:/@${pg_ip}:/")
}

#
# PostgreSQL Alternate Dotfiles
# Including Command-Line Tools (i.e. psql)
#
# Version Requirements:
#   The PSQLRC and PSQL_HISTORY environmental variables were introduced in version 9.2
#
#   To determine your version, use: `psql --version`
#
#   Mac OS X 10.8 Mountain Lion ships with 9.1.4, which is too old.
#   You can install a later version via Homebrew with: brew install postgresql
#
# Relevant:
#   - [Environmental Variable List - General](http://www.postgresql.org/docs/current/static/libpq-envars.html)
#   - [Environmental Variable List - psql](http://www.postgresql.org/docs/current/static/app-psql.html#APP-PSQL-ENVIRONMENT)


# psql config file. Default: ~/.psqlrc
export PSQLRC="$(dotfile pgsql config file psqlrc)"

# psql History file.
export PSQL_HISTORY="$(dotfile pgsql data file psql_history)"

# Password file. Default: ~/.pgpass
# See: http://www.postgresql.org/docs/current/static/libpq-pgpass.html
export PGPASSFILE="$(dotfile_umask="0077" dotfile pgsql config file pgpass)"

# Per-user connection service file. Default: ~/.pg_service.conf
# See: http://www.postgresql.org/docs/current/static/libpq-pgservice.html
export PGSERVICEFILE="$(dotfile pgsql config file pg_service.conf)"


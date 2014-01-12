# Fix Autotools Annoyance
  alias c.auto="aclocal && autoheader && libtoolize --copy --automake && automake --copy --add-missing  && autoconf"
# Lazy Ass C
  alias c.c="gcc -Wall -ansi -pedantic -g -o "
# Clean tmp files, compile and execute the ./current_directoryname. Works (almost) always thanks to a Generic Makefile
  alias c.make="cp -u ~/.X4/.Makefile ./Makefile; make distclean > /dev/null && make; ./${PWD##*/}"
# Execute \kbd{./configure}
  alias CO="./configure"
# Execute \kbd{./configure --help}
  alias CH="./configure --help"

# Update all (system) gems
  alias r.gemup="gem update --system && gem update"
# Show Ruby on Rails toolset versions
  alias r.versions="which ruby;which rails;which bundle;ruby -v;rails -v; bundle -v"
# Converts erb files to haml
  alias r.hamilize="find . -name '*erb' | xargs ruby -e 'ARGV.each { |i| puts \"html2haml -r #{i} #{i.sub(/erb$/,\"haml\")};rm #{i}\"}' | bash"

# Runs mongodb on /tmp
  alias db.mongodb="mkdir /tmp/mongo -p && mongod --dbpath /tmp/mongo --rest > /dev/null &"
# Dump MySQL and backup to bzip2 archive
  alias db.mysqldump="mysqldump --all-databases -p | bzip2 -c > $(date --rfc-3339=date)all-databases.sql.bz2"

# Run simple HTTP Server in current directory
  alias s.py="python -m SimpleHTTPServer"
  alias s.php="php -S 127.0.0.1:8080"

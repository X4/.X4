# Fix Autotools Annoyance
  alias run.autotools="aclocal && autoheader && libtoolize --copy --automake && automake --copy --add-missing  && autoconf"
# Finish CB Homework
  alias run.hue="git --no-pager log --format=\"%ai %aN %n%n%x09* %s%d%n\" | sed \"s/\*\ \*/*/g\" > fdgr46/ChangeLog; tar -cvf fdgr46.tar fdgr46 && gzip fdgr46.tar"
# Lazy Ass C
  alias run.c="gcc -Wall -ansi -pedantic -g -o "
# Clean tmp files, compile and execute the ./current_directoryname. Works always thanks to a Generic Makefile
  alias run.make="cp -u ~/.X4/.Makefile ./Makefile; make distclean > /dev/null && make; ./${PWD##*/}"
# Update all (system) gems
  alias run.gemup="gem update --system && gem update"
# Show Ruby on Rails toolset versions
  alias run.ror-versions="which ruby;which rails;which bundle;ruby -v;rails -v; bundle -v" #show ror version numbers
# Runs mongodb on /tmp
  alias run.mongodb="mkdir /tmp/mongo -p && mongod --dbpath /tmp/mongo --rest > /dev/null &" #start mongodb
# Converts erb files to haml
  alias run.hamilize="find . -name '*erb' | xargs ruby -e 'ARGV.each { |i| puts \"html2haml -r #{i} #{i.sub(/erb$/,\"haml\")};rm #{i}\"}' | bash"
# Execute \kbd{./configure}
  alias CO="./configure"
# Execute \kbd{./configure --help}
  alias CH="./configure --help"

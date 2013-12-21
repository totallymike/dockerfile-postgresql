FROM base:ubuntu-quantal
MAINTAINER Michael Westbom <michael.westbom@gmail.com>

# Exposes
EXPOSE 5432

# Update the package repository
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y curl psmisc

# Install Dockyard
RUN curl -o /usr/local/bin/dockyard https://raw.github.com/dynport/dockyard/master/dockyard
RUN chmod 0755 /usr/local/bin/dockyard

RUN dockyard install postgresql 9.2.4

RUN useradd postgres

ADD pg_hba.conf     /etc/postgresql/9.2/main/
ADD pg_ident.conf   /etc/postgresql/9.2/main/
ADD postgresql.conf /etc/postgresql/9.2/main/

# main entry
ADD start /start
RUN chmod 0755 /start


CMD ["/start"]

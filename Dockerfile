# Create Docker image named "kali-custom" via: 
#	$ docker build -t kali-custom .
# Run with:
#	$ docker run -ti --rm --mount src=kali-root,dst=/root --mount src=kali-postgres,dst=/var/lib/postgresql kali-custom
###
FROM kalilinux/kali-rolling:latest

# Distribution updates, upgrade and cleaning
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean

# Install Kali Linux default packages
RUN apt-get -y install kali-linux-headless

# Initialize Metasploit databse
RUN service postgresql start && msfdb init

RUN apt-get -y install fish
RUN chsh -s /usr/bin/fish

# Map relevant volumes
VOLUME /root /var/lib/postgresql

# LPORT for reverse shells
EXPOSE 2048

WORKDIR /root
ENTRYPOINT ["fish"]

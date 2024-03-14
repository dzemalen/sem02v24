FROM ubuntu:24.04
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get autoremove -y \
&& apt-get autoclean -y \
&& apt-get install -y \
sudo \
nano \
wget \
curl \
git
RUN useradd -G sudo -m -d /home/dzem -s /bin/bash -p "$(openssl passwd -1 1234)" dzem
USER dzem
WORKDIR /home/dzem
RUN mkdir hacking \
&& cd hacking \
&& curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v24/pawned.sh > pawned.sh \
&& chmod 764 pawned.sh \ 
&& cd ..
RUN git config --global user.email "nidalalendar7@gmail.com" \
&& git config --global user.name "dzem" \
&& git config --global url."https://PAT:@github.com/".insteadOf "https://github.com" \
&& mkdir -p github.com/dzemalen/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.22.1.linux-amd64.tar.gz \
| tar xvz -C /usr/local
USER dzem
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/dzem/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
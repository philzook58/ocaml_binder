FROM ocaml/opam2:4.07

# https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
USER root 
RUN apt-get install -y python3-pip pkg-config

RUN pip3 install --no-cache-dir notebook==5.*
# USER opam
# jupyter-archimedes core 
RUN opam depext jupyter 
#  jupyter-archimedes core
RUN opam install jupyter -y
# ENV PATH="/home/opam/.local/bin:${PATH}"
RUN jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter"


ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/opam 
#${NB_USER}

#RUN adduser --disabled-password \
#    --gecos "Default user" \
#    --uid ${NB_UID} \
#    ${NB_USER}
RUN usermod -l ${NB_USER} opam
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}/.local

# remove offedning line from /etc/hosts file
# RUN sed -i '2d' /etc/hosts 
# http://blog.jonathanargentiero.com/docker-sed-cannot-rename-etcsedl8ysxl-device-or-resource-busy/
RUN cp /etc/hosts ~/hosts.new
RUN sed -i '2d' ~/hosts.new 
RUN cp -f ~/hosts.new /etc/hosts


RUN echo "127.0.0.1	localhost \
fe00::0	ip6-localnet \
ff00::0	ip6-mcastprefix \ 
ff02::1	ip6-allnodes \
ff02::2	ip6-allrouters" > /etc/hosts


RUN cat /etc/hosts
RUN cat ~/hosts.new
#RUN chown -R ${NB_UID} ${HOME}/.local}

USER ${NB_USER}
# ENTRYPOINT /usr/local/bin/jupyter notebook --ip=0.0.0.0 --port=8080
# ENTRYPOINT ["/usr/local/bin/jupyter", "notebook" , "--ip=0.0.0.0" ,"--port=8080"]
# RUN opam init
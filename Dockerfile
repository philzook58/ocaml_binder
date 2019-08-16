FROM ocaml/opam2:4.07

# https://mybinder.readthedocs.io/en/latest/tutorials/dockerfile.html
USER root 
RUN apt-get install -y python3-pip pkg-config

RUN pip3 install --no-cache-dir notebook==5.*
# jupyter-archimedes core 
RUN opam depext jupyter 
#  jupyter-archimedes core
RUN opam install jupyter -y

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
# RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}
# RUN opam init
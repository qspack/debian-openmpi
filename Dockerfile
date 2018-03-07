FROM qspack/debian-base

ARG OPENMPI_VERSION=2.0.1
#2.0.0 1.10.3 1.10.2 1.10.1 1.10.0 1.8.8 1.6.5
RUN /usr/local/src/spack/bin/spack install openmpi@${OPENMPI_VERSION}
ENV PATH=${PATH}:/usr/local/openmpi/bin
RUN mkdir -p /usr/local/openmpi \
 && ln -s $(/usr/local/src/spack/bin/spack location --install-dir openmpi)/bin /usr/local/openmpi/bin
COPY src/hello_mpi.c src/ring.c /usr/local/src/mpi/
RUN mpicc -o /usr/local/bin/hello /usr/local/src/mpi/hello_mpi.c \
 && mpicc -o /usr/local/bin/ring /usr/local/src/mpi/ring.c

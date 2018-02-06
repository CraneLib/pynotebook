# craneleeon/pynotebook
FROM ubuntu:16.04 

# Pick up some dependencies
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
				git \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        python-wheel \
        python-pip \
        python3.6 \
        python3.6-dev \
				python3.6-venv \
        python3-pip \
        rsync \
        unzip \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
#     python get-pip.py && \
#     rm get-pip.py

RUN echo "alias python=python3.6" >> ~/.bashrc
RUN alias python=python3.6
RUN alias python3=python3.6

RUN python3.6 -m pip install --upgrade pip \
    && \
    python3.6 -m pip install --upgrade setuptools \
    && \
    python3.6 -m pip --no-cache-dir install \
        wheel \
        Pillow \
        h5py \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        pandas

RUN python2 -m pip install --upgrade pip \
    && \
    python2 -m pip install --upgrade setuptools \
    && \
    python2 -m pip --no-cache-dir install \
        ipykernel \
        matplotlib \
        numpy \
		&& \
		python2 -m ipykernel install --user
    
RUN python3.6 -m ipykernel.kernelspec

# --- DO NOT EDIT OR DELETE BETWEEN THE LINES --- #
# These lines will be edited automatically by parameterized_docker_build.sh. #
# COPY _PIP_FILE_ /
# RUN pip --no-cache-dir install /_PIP_FILE_
# RUN rm -f /_PIP_FILE_

# --- ~ DO NOT EDIT OR DELETE BETWEEN THE LINES --- #

# RUN ln -s /usr/bin/python3 /usr/bin/python#

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
# COPY notebooks /notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh", "--allow-root"]

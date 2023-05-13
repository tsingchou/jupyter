FROM jupyter/base-notebook

USER root

RUN apt -y update 
RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori
RUN sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list
RUN sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list
RUN apt-get update

RUN apt-get update

RUN apt-get install --yes --no-install-recommends \
    ffmpeg \
    tzdata \
    openssh-client \
    inkscape \
    libgl1 \
    libsm6 \
    libxext6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    texlive-xetex \
    texlive-fonts-recommended \
    texlive-plain-generic && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mamba install --yes \
    yapf \
    nb_conda \
    jupyter_contrib_nbextensions && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN sed -i "s/info\['envs'\]\]/info['envs'] if env != info['root_prefix']]/g" /opt/conda/lib/python3.10/site-packages/nb_conda/envmanager.py

USER ${NB_UID}

COPY jupyter_notebook_config.py /etc/jupyter/

USER root

# Prepare upgrade to JupyterLab V3.0 #1205
RUN sed -re "s/c.NotebookApp/c.ServerApp/g" \
    /etc/jupyter/jupyter_notebook_config.py > /etc/jupyter/jupyter_server_config.py && \
    fix-permissions /etc/jupyter/

RUN conda create -n yolov8 python=3.8
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge/
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/msys2/
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/


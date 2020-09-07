FROM ubuntu:20.10
RUN apt-get update && apt-get install -y \
    emacs \
    sudo \
    wget \
    unzip \
    git \
    htop \
    tree

WORKDIR /opt
RUN wget https://repo.continuum.io/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
    sh /opt/Anaconda3-2020.02-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm -f Anaconda3-2020.02-Linux-x86_64.sh
ENV PATH /opt/anaconda3/bin:$PATH

RUN pip install --upgrade pip

COPY requirements.txt /tmp/
RUN pip3 install -r /tmp/requirements.txt

# jupyter notebook nbextensions setting
RUN pip3 install jupyter-contrib-nbextensions \
    && jupyter contrib nbextension install --user \
    && jupyter nbextension enable collapsible_headings/main \
    && jupyter nbextension enable toc2/main \
    && jupyter nbextension enable scratchpad/main \
    && jupyter nbextension enable export_embedded/main \
    && jupyter nbextension enable gist_it/main \
    && jupyter nbextension enable code_prettify/isort \
    && jupyter nbextension enable move_selected_cells/main \
    && jupyter nbextension enable ruler/main \
    && jupyter nbextension enable table_beautifier/main \
    && jupyter nbextension enable toggle_all_line_numbers/main \
    && jupyter nbextension enable varInspector/main

WORKDIR /work
#CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]
#CMD ["/bin/bash"]

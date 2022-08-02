#Download base image ubuntu 20.04
FROM r-base:4.2.0
ENTRYPOINT ["/bin/bash"]

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg

WORKDIR /home/cnvrobot/
#RUN wget https://github.com/RahmanTeam/DECoN/archive/refs/tags/v2.0.0.tar.gz
RUN wget https://github.com/AnetaMikulasova/CNVRobot/archive/refs/tags/v3.5.zip
RUN unzip v3.5.zip
#RUN rm v2.0.0.tar.gz

RUN R -e "install.packages('devtools')"
RUN R -e "install.packages('BiocManager')"
RUN R -e "BiocManager::install('expss')"
RUN R -e "BiocManager::install('karyoploteR')"










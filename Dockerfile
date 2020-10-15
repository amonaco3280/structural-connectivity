FROM ubuntu:18.04

ENV TZ=Europe/Rome

RUN apt update && \
    apt install -y gnupg gnupg2 gnupg1 software-properties-common curl && \
    rm -rf /var/lib/apt/lists/*

# install r-base

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/' && \
    apt update && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt install -y --no-install-recommends r-base && \
    rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages('Rcpp')" && \
    Rscript -e "install.packages('abind')" && \
    Rscript -e "install.packages('RNifti')" && \
    Rscript -e "install.packages('bitops')" && \
    Rscript -e "install.packages('oro.nifti')"

#install neurodebian

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xA5D32F012649A5A9 && \
    apt-add-repository "deb http://neurodeb.pirsquared.org bionic main contrib non-free" && \
    apt-add-repository "deb http://neurodeb.pirsquared.org data main contrib non-free" && \
    apt-get update && apt-get install -y --no-install-recommends ants fsl python-numpy fsl-first-data fsl-mni152-templates && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    curl http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb -o libpng12-0_1.2.54-1ubuntu1.1_amd64.deb && \
    dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb && \
    curl http://archive.ubuntu.com/ubuntu/pool/universe/n/nifticlib/libnifti2_2.0.0-2_amd64.deb -o libnifti2_2.0.0-2_amd64.deb && \
    dpkg -i libnifti2_2.0.0-2_amd64.deb && \
    rm -rf /var/lib/apt/lists/*


ENV FSLDIR=/usr/share/fsl/5.0
ENV PATH=$PATH:$FSLDIR/bin
ENV LD_LIBRARY_PATH=/usr/lib/fsl/5.0:/usr/share/fsl/5.0/bin
ENV FSLBROWSER=/etc/alternatives/x-www-browser
ENV FSLCLUSTER_MAILOPTS=n
ENV FSLLOCKDIR=
ENV FSLMACHINELIST=
ENV FSLMULTIFILEQUIT=TRUE
ENV FSLOUTPUTTYPE=NIFTI_GZ
ENV FSLREMOTECALL=
ENV FSLTCLSH=/usr/bin/tclsh
ENV FSLWISH=/usr/bin/wish
ENV POSSUMDIR=/usr/share/fsl/5.0

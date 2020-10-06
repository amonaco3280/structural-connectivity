FROM r-base

RUN apt-get update 
RUN apt-get install -y apt-utils
RUN apt-get install -y gnupg2
RUN apt-get install -y software-properties-common
RUN apt-get update

RUN apt-get -y install build-essential checkinstall
  
RUN apt install -y python-minimal

RUN Rscript -e "install.packages('Rcpp')"
RUN Rscript -e "install.packages('abind')"
RUN Rscript -e "install.packages('RNifti')"
RUN Rscript -e "install.packages('bitops')"
RUN Rscript -e "install.packages('oro.nifti')"

#RUN wget -O- http://neuro.debian.net/lists/trusty.us-ca.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
RUN wget -O- http://neuro.debian.net/lists/bullseye.us-ca.libre | tee /etc/apt/sources.list.d/neurodebian.sources.list
RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9
RUN apt-get update
RUN apt-get install -y ants
RUN apt-get install -y gcc-10-base
RUN apt-get install -y libgcc-s1


#install neurodebian
RUN wget -O- http://neuro.debian.net/lists/xenial.us-tn.full | tee /etc/apt/sources.list.d/neurodebian.sources.list
RUN apt-key adv --recv-keys --keyserver hkp://pool.sks-keyservers.net:80 0xA5D32F012649A5A9

#install fsl
#RUN add-apt-repository ppa:linuxuprising/libpng12
RUN apt-get update
#RUN apt-get install libpng12-0
RUN wget http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb

RUN dpkg -i libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install fsl python-numpy
RUN apt-get install -y fsl-first-data
RUN apt-get install -y fsl-mni152-templates

RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/n/nifticlib/libnifti2_2.0.0-2_amd64.deb
RUN dpkg -i libnifti2_2.0.0-2_amd64.deb 

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

INSTALL_DIR=/opt/
DOWNLOAD_DIR=/tmp/
MINICONDA_PACKAGES_NEEDED=(wget bzip2 python-qt4)
ROOT_PACKAGES_NEEDED=(gcc-gfortran openssl-devel pcre-devel \
                      mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
                      fftw-devel cfitsio-devel graphviz-devel \
                      avahi-compat-libdns_sd-devel libldap-dev python-devel \
                      libxml2-devel gsl-static)

MINICONDA_VERSION=Miniconda3-3.7.0-Linux-x86_64.sh

# Set the correct path
export PATH="${INSTALL_DIR}/miniconda/bin:${PATH}"

# Update conda
conda update --yes conda

# Create all environments environment
conda env create -f /miniconda-environment/ml_environment.yml
conda env create -f /miniconda-environment/py2root5_environment.yml
conda env create -f /miniconda-environment/py2root6_environment.yml
conda env create -f /miniconda-environment/py3root5_environment.yml
conda env create -f /miniconda-environment/py3root6_environment.yml

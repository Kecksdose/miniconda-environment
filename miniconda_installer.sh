INSTALL_DIR=/opt/
DOWNLOAD_DIR=/tmp/
MINICONDA_PACKAGES_NEEDED=(wget bzip2 python-qt4)
ROOT_PACKAGES_NEEDED=(gcc-gfortran openssl-devel pcre-devel \
                      mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
                      fftw-devel cfitsio-devel graphviz-devel \
                      avahi-compat-libdns_sd-devel libldap-dev python-devel \
                      libxml2-devel gsl-static)

MINICONDA_VERSION=Miniconda3-3.7.0-Linux-x86_64.sh

# Update packages
yum -y update

# Install packages for miniconda, but only if not already installed
# Based on http://unix.stackexchange.com/questions/310361/packages-to-be-install-in-a-for-loop-if-not-installed?answertab=active#tab-top
for pkg in "${MINICONDA_PACKAGES_NEEDED[@]}"; do
    if yum -q list installed "$pkg" > /dev/null 2>&1; then
        echo -e "$pkg is already installed"
    else
        yum install "$pkg" -y && echo "Successfully installed $pkg"
    fi
done

# Check whether conda exists. If it does not, install it
if [ ! -d ${INSTALL_DIR}/miniconda/bin ]
then
    # Download and install the miniconda
    wget http://repo.continuum.io/miniconda/${MINICONDA_VERSION} -O ${DOWNLOAD_DIR}/miniconda.sh
    bash /tmp/miniconda.sh -b -p ${INSTALL_DIR}/miniconda
fi

# Set the correct path
export PATH="${INSTALL_DIR}/miniconda/bin:${PATH}"

# Update conda
conda update --yes conda

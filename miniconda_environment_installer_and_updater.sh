INSTALL_DIR=/opt/
DOWNLOAD_DIR=/tmp/
REPO_DIR=/usr/repos/miniconda-environment/
LATEST_ENVIRONMENTS=(ml)
MINICONDA_PACKAGES_NEEDED=(wget bzip2 python-qt4)
ROOT_PACKAGES_NEEDED=(gcc-gfortran openssl-devel pcre-devel \
                      mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
                      fftw-devel cfitsio-devel graphviz-devel \
                      avahi-compat-libdns_sd-devel libldap-dev python-devel \
                      libxml2-devel gsl-static)

MINICONDA_VERSION=Miniconda3-3.7.0-Linux-x86_64.sh

# For time measurement
START=`date +%s`

# Check whether conda exists. If it does not, install it
if [ ! -d ${INSTALL_DIR}/miniconda/bin ]
then
    echo "No miniconda found. It will now be installed..."
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

    # Download and install the miniconda
    wget http://repo.continuum.io/miniconda/${MINICONDA_VERSION} -O ${DOWNLOAD_DIR}/miniconda.sh
    bash /tmp/miniconda.sh -b -p ${INSTALL_DIR}/miniconda
else
    echo "Miniconda found. Now going to set up environments..."
fi

# Set the correct path
export PATH="${INSTALL_DIR}/miniconda/bin:${PATH}"

# Update conda
conda update --yes conda

# Build environments
for env in ${REPO_DIR}*_environment.yml
do
    TMP_ENV_NAME=$(sed 's/\(.*\)_.*/\1/g' <<< ${env})
    TMP_ENV_NAME=$(basename ${TMP_ENV_NAME})    
    if [ ! -d "${INSTALL_DIR}/miniconda/envs/${TMP_ENV_NAME}" ]    
    then
        echo "Create env for file ${TMP_ENV_NAME}..."
        conda env create -q -f ${env}
    else
        echo "Environment ${TMP_ENV_NAME} already exists. Will skip creating it..."
    fi
done

# Update latest environments
for latest in "${LATEST_ENVIRONMENTS[@]}"
do 
    echo "Updating all packages in environment ${latest}..."
    conda update -y -q -n ${latest} --all
done

END=`date +%s`
ELAPSED=$((END-START))
echo "Done in $ELAPSED seconds."

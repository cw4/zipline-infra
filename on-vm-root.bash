yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum -y install python-devel gcc libyaml gcc-c++ wget blas git mlocate emacs-nox
yum -y install scipy python-matplotlib ipython python-pandas sympy python-nose
yum -y install python-pip
pip install cython
pip install zipline
pip install --upgrade ipython
pip install --upgrade six

# ta-lib
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure; make; make install

pip install ta-lib

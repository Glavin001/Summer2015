#!/usr/bin/env bash

VIRTUAL_ENV_NAME="summer2015"
PYTHON_VERSION=python3

# Messages
MSG_UNSUPPORTED_OS="echo \"Unsupported Operating System\""

echo
echo "= Installing Operating-Specific Dependencies ="
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # ...
    echo "== Linux Detected =="
    sudo apt-get install -y $PYTHON_VERSION
    sudo apt-get install -y pkg-config ${PYTHON_VERSION}-pip
    sudo apt-get build-dep python-matplotlib
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    echo "== Mac OS X Detected =="
    echo "Install $PYTHON_VERSION..."
    brew install $PYTHON_VERSION
elif [[ "$OSTYPE" == "cygwin" ]]; then
    # POSIX compatibility layer and Linux environment emulation for Windows
    echo "== Windows (Cygwin) Detected =="
    $(MSG_UNSUPPORTED_OS)
elif [[ "$OSTYPE" == "msys" ]]; then
    # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    echo "== Windows (msys) Detected =="
    $(MSG_UNSUPPORTED_OS)
elif [[ "$OSTYPE" == "win32" ]]; then
    # I'm not sure this can happen.
    echo "== Windows Detected =="
    $(MSG_UNSUPPORTED_OS)
    
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    # ...
    echo "== FreeBSD Detected =="
    $(MSG_UNSUPPORTED_OS)
else
    # Unknown.
    echo "== Unknown Operating System =="
    exit
fi

# Check if virtualenvwrapper installed
echo
which virtualenvwrapper.sh > /dev/null
if [ $? -ne 0 ]; then
    echo "Please first install virtualenvwrapper from \
        http://virtualenvwrapper.readthedocs.org/en/latest/install.html#basic-installation"
    exit
else
    # 'which' will print absolute path to virtualenvwrapper.sh
    source `which virtualenvwrapper.sh`
fi

echo
echo "=== Create Python Virtual Environment for dependencies ==="
mkvirtualenv -p $PYTHON_VERSION $VIRTUAL_ENV_NAME

echo
echo "=== Activate Python Virtual Environment: $VIRTUAL_ENV_NAME ==="
workon $VIRTUAL_ENV_NAME

echo
echo "=== Install Python dependencies ==="
pip install -r requirements.txt

echo
echo "All done! You can start developing by running ./notebook"
echo


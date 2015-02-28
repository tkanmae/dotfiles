#!/usr/bin/env bash
#
# Script for installing SIP and PyQt4 on Mac OS X.
#
SIP_VERSION="4.16.6"
PYQT_VERSION="4.11.3"

DOWNLOAD_CACHE_DIR="$HOME/Library/Caches/pip"
[[ -d "$DOWNLOAD_CACHE_DIR" ]] || mkdir -p "$DOWNLOAD_CACHE_DIR"


print_error() {
    printf "\e[31m""$@""\e[m"
} >&2


sip_installed() {
    local version=$(python -c 'import sip; print(sip.SIP_VERSION_STR)' 2>/dev/null)
    [[ "$version" = "$SIP_VERSION" ]]
}


pyqt_installed() {
    local version=$(python -c 'from PyQt4 import QtCore; print(QtCore.PYQT_VERSION_STR)' 2>/dev/null)
    [[ "$version" = "$PYQT_VERSION" ]]
}


install_sip() {
    local status
    local url="https://downloads.sf.net/project/pyqt/sip/sip-$SIP_VERSION/sip-$SIP_VERSION.tar.gz"

    printf "\e[1mInstalling sip...\e[m\n"

    # Download the source file.
    cd "$DOWNLOAD_CACHE_DIR"
    if ! [[ -f "${url##*/}" ]]; then
        wget "$url"
        status=$?
        if [[ $status != "0" ]]; then
            print_error "failed to download: $url\n"
            rm -f "${url##*/}"
            exit $status
        fi
    fi

    # Create a working directory.
    local working_dir=$(mktemp -d /tmp/insatll-pyqt4.XXXXXXXX)
    status=$?
    if [[ -z "$working_dir" ]]; then
        print_error "failed to create a temporary directory\n"
        exit $status
    fi

    # Build and install.
    trap "rm -fr $working_dir" INT TERM EXIT
    tar -xf "${url##*/}" -C "$working_dir"
    cd "$working_dir"/sip*
    python configure.py
    make
    make install
    trap - INT TERM EXIT
}


install_pyqt() {
    local status
    local url="https://downloads.sf.net/project/pyqt/PyQt4/PyQt-$PYQT_VERSION/PyQt-mac-gpl-$PYQT_VERSION.tar.gz"

    printf "\e[1mInstalling PyQt4...\e[m\n"

    # Download the source file.
    cd "$DOWNLOAD_CACHE_DIR"
    if ! [[ -f "${url##*/}" ]]; then
        wget "$url"
        status=$?
        if [[ "$status" != "0" ]]; then
            print_error "failed to download: $url\n"
            exit $status
        fi
    fi

    # Create a working directory.
    local working_dir=$(mktemp -d /tmp/pyenv-insatll-pyqt4.XXXXXXXX)
    status=$?
    if [[ -z "$working_dir" ]]; then
        print_error "failed to create a temporary directory\n"
        exit $status
    fi

    # Build and install.
    trap "rm -fr $working_dir" INT TERM EXIT
    tar -xf "${url##*/}" -C "$working_dir"
    cd "$working_dir"/PyQt*
    python configure-ng.py \
        --confirm-license \
        --spec="unsupported/macx-clang-libc++"
    make
    make install
    trap - INT TERM EXIT
}


if sip_installed; then
    echo "sip==$SIP_VERSION already installed"
else
    install_sip
fi

if pyqt_installed; then
    echo "pyqt==$PYQT_VERSION already installed"
else
    install_pyqt
fi

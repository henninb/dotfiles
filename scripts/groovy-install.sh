#!/bin/sh
# This script downloads and installs Groovy into /opt/groovy

# URL for the Groovy binary zip file
GROOVY_URL="https://groovy.jfrog.io/ui/native/dist-release-local/groovy-zips/apache-groovy-binary-4.0.26.zip"
GROOVY_URL="https://groovy.jfrog.io/ui/native/dist-release-local/groovy-zips/apache-groovy-binary-4.0.3.zip"
            # https://groovy.jfrog.io/artifactory/dist-release-local/groovy-zips/apache-groovy-docs-4.0.3.zip

# Installation directory
INSTALL_DIR="/opt/groovy"

# Temporary paths
TMP_ZIP="/tmp/apache-groovy-binary.zip"
TMP_DIR="/tmp/groovy_extracted"

# Function to print an error message and exit
error_exit() {
    echo "Error: $1"
    exit 1
}

# Download the Groovy zip file
echo "Downloading Groovy from ${GROOVY_URL}..."
# curl -L -o "${TMP_ZIP}" "${GROOVY_URL}" || error_exit "Download failed."
wget "${GROOVY_URL}" -O "${TMP_ZIP}"

# Prepare temporary extraction directory
rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}" || error_exit "Cannot create temporary directory."

# Unzip the downloaded archive
echo "Extracting Groovy archive..."
unzip "${TMP_ZIP}" -d "${TMP_DIR}" || error_exit "Extraction failed."

# Locate the extracted Groovy directory (expects a directory starting with 'apache-groovy-binary-')
EXTRACTED_DIR=$(find "${TMP_DIR}" -maxdepth 1 -type d -name "apache-groovy-binary-*" | head -n 1)
[ -z "${EXTRACTED_DIR}" ] && error_exit "Extracted Groovy directory not found."

# Remove any existing installation
if [ -d "${INSTALL_DIR}" ]; then
    echo "Removing existing Groovy installation at ${INSTALL_DIR}..."
    rm -rf "${INSTALL_DIR}" || error_exit "Cannot remove existing installation."
fi

# Move the extracted directory to the installation directory
echo "Installing Groovy to ${INSTALL_DIR}..."
mv "${EXTRACTED_DIR}" "${INSTALL_DIR}" || error_exit "Installation failed."

# Clean up temporary files
rm -f "${TMP_ZIP}"
rm -rf "${TMP_DIR}"

echo "Groovy successfully installed in ${INSTALL_DIR}."
echo "Remember to add ${INSTALL_DIR}/bin to your PATH in your Fish config."

exit 0

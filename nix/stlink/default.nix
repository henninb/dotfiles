# An expression producing an environment suitable for running the stlink programmer updating tool.
#
# STSW-LINK007
#
# https://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-programmers/stsw-link007.html
#
# Once in the environment, run with:
#
# ```
# sudo LD_LIBRARY_PATH="$LD_LIBRARY_PATH" java -jar STLinkUpgrade.jar
# ```
#
# Once updated, ensure that the program is closed before trying to run `cargo flash`.
with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "stlink-dev-env";
  buildInputs = [
    jre
    libusb1 # For building STLINK firmware updater.
    stlink
  ];
  LD_LIBRARY_PATH = "${libusb}/lib";
}

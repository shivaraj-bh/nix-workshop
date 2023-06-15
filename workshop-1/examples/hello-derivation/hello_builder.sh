# Stop the build if any command fails
set -e
# Export only the required binaries into the PATH
export PATH="$gnutar/bin:$gzip/bin:$gcc/bin:$gnumake/bin:$gnused/bin:$coreutils/bin:$bintools/bin:$gnugrep/bin:$gawk/bin"
# Unpack Phase
tar -xzf $src
cd hello-2.12
# Configure Phase
./configure --prefix=$out
# Build Phase
make
# Install Phase
make install
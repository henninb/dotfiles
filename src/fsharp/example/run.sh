#!/bin/sh

if [ \( "$OS" = "Linux Mint" \) -o \(  "$OS" = "Ubuntu" \) ]; then
  PATH_FSI=/usr/share/dotnet/sdk/$(dotnet --version)/FSharp/fsi.exe
elif [ "$OS" = "Fedora" ]; then
  PATH_FSI=/usr/share/dotnet/sdk/$(dotnet --version)/FSharp/fsi.exe
elif [ "$OS" = "CentOS Linux" ]; then
  PATH_FSI=/usr/share/dotnet/sdk/$(dotnet --version)/FSharp/fsi.exe
elif [ "$OS" = "Arch Linux" ]; then
  PATH_FSI=/opt/dotnet/sdk/$(dotnet --version)/FSharp/fsi.exe
elif [ "$OS" = "Gentoo" ]; then
  PATH_FSI=/opt/dotnet_core/sdk/$(dotnet --version)/FSharp/fsi.exe
else
  echo $OS is not implemented.
  exit 1
fi

docker rm example -f
docker build -t example .
# docker run -it --name example -d example
docker run --name example --rm example

# dotnet $PATH_FSI example.fs
# fsharpi --nologo --load:example.fs

exit 0

date=$(shell date '+%Y-%m-%d %H:%M:%S')
all: build
build:
	platformio run
install:
	@echo ${date}
	@sed -i "s/#define uploadTimestamp.*/#define uploadTimestamp \"$(date)\"/g" src/main.cpp
	platformio run -t upload
	@platformio device monitor
clean:
	platformio run -t clean

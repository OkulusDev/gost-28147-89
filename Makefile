# Компиляторы
CXX := clang++
CXX_FLAGS := -g -Wall -O2 -mllvm --x86-asm-syntax=intel -Ofast -pipe -flto -Wextra -D_REENTRANT -fPIC

# Директории
SRC_DIR := src
BIN_DIR := bin

# Исходные коды
CSOURCES := $(wildcard $(SRC_DIR)/*.c)
CXXSOURCES := $(wildcard $(SRC_DIR)/*.cpp)

TARGET := $(BIN_DIR)/netrabbit

TARGETS := $(patsubst $(SRC_DIR)/%.c,%,$(CSOURCES))

BINS := $(wildcard $(BIN_DIR)/*)

SUDO		  	= sudo
DEL_FILE      	= rm -f
CHK_DIR_EXISTS	= test -d
MKDIR         	= mkdir -p
COPY          	= cp -f
COPY_FILE     	= cp -f
COPY_DIR      	= cp -f -R
INSTALL_FILE   	= install -m 644 -p
INSTALL_PROGRAM = install -m 755 -p
INSTALL_DIR   	= cp -f -R
DEL_FILE      	= rm -f
SYMLINK       	= ln -f -s
DEL_DIR       	= rmdir
MOVE          	= mv -f
TAR           	= tar -cf
COMPRESS      	= gzip -9f
LIBS_DIRS     	= -I./include/
LIBS 		  	= -ltins $(LIBS_DIRS)
SED           	= sed
STRIP         	= strip

all: build install clean

build:
	$(CXX) $(LIBS) $(LIBS_DIRS) $(CXX_FLAGS) $(CXXSOURCES) -o $(TARGET)

install:
	@for file in $(wildcard $(BIN_DIR)/*); do \
		$(SUDO) $(INSTALL_PROGRAM) $$file /usr/local/bin/; \
	done

clean:
	$(DEL_FILE) bin/*

.PHONY: build install clean

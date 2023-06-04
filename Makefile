.PHONY: all clean
CC      = g++
AR      = ar
RM      = rm -rf  

TARGET = libtlssigapi_v2.a
all: $(TARGET)

## source file path  
SRC_PATH := src

ifeq (mingw,$(PLATFORM))

else

endif

## used headers  file path  
INCLUDE_PATH := $(SRC_PATH) third/rapidjson/include third/fmt/include 

## used include librarys file path  
LIBRARY_PATH := 

## need static libs, add at here
# STATIC_LIBS :=

## define CFLAGS
CFLAGS += -g -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -Wno-parentheses -Wno-unknown-pragmas -Wno-sign-compare -fpic -std=c++0x 
CFLAGS += -O2
CFLAGS += -DUSE_OPENSSL -DFMT_HEADER_ONLY -DRAPIDJSON_HAS_STDSTRING=1

## get all source files  
CPP_SRCS += $(wildcard $(SRC_PATH)/*.cpp)
C_SRCS += $(wildcard $(SRC_PATH)/*.c)

## all .o based on all .c
OBJS := $(CPP_SRCS:.cpp=.o)
OBJS += $(C_SRCS:.c=.o)

## get all include path  
CFLAGS += $(foreach dir, $(INCLUDE_PATH), -I$(dir))  
.cpp.o:
	$(CC) -c $(CFLAGS) -o $@ $<


$(TARGET): $(OBJS) 
	$(AR) rcs $@ $(OBJS)

clean:
	$(RM) $(OBJS) $(TARGET)

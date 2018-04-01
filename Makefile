include $(MAKE_ROOT)/settings.mk

ifeq ($(RADIANT_BUILD_PLATFORM), x86)
MSBUILD_PLATFORM=Win32
else
MSBUILD_PLATFORM=x64
endif

FLABUFFERS_BUILD_DIR=build/$(RADIANT_BUILD_PLATFORM)
#CLAW_FLAGS =-DCLAW_NO_JPEG=true -DCLAW_NO_PNG=true -DCLAW_INSTALL_CMAKE_MODULES=true -DCLAW_CMAKE_MODULES_INSTALL_PATH=claw-cmake -DCMAKE_INSTALL_PREFIX=claw-install -DBOOST_INCLUDEDIR=../../boost/install/$(RADIANT_BUILD_PLATFORM)/include/boost-1_54 

.PHONY: default
default: configure build
	echo done

build: configure
	cmake --build $(FLABUFFERS_BUILD_DIR)
	#$(MSBUILD) $(FLABUFFERS_BUILD_DIR)/FlatBuffers.sln -p:configuration=debug,platform=$(MSBUILD_PLATFORM)
	#$(MSBUILD) $(FLABUFFERS_BUILD_DIR)/FlatBuffers.sln -p:configuration=release,platform=$(MSBUILD_PLATFORM)

configure:
	-mkdir -p $(FLABUFFERS_BUILD_DIR)
	cmake -G"$(RADIANT_CMAKE_GENERATOR)" -B$(FLABUFFERS_BUILD_DIR) -H. $(FLABUFFERS_FLAGS)

.PHONY: clean
clean:
	rm -rf build/x86
	rm -rf build/x64

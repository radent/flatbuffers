include $(MAKE_ROOT)/settings.mk

ifeq ($(RADIANT_BUILD_PLATFORM), x86)
MSBUILD_PLATFORM=Win32
else
MSBUILD_PLATFORM=x64
endif

FLABUFFERS_BUILD_DIR=build/$(RADIANT_BUILD_PLATFORM)

# macOS
ifeq ($(RADIANT_OS_PLATFORM), macos)

.PHONY: default
default: configure build
	echo done

build: configure
	cmake --build $(FLABUFFERS_BUILD_DIR) --config RelWithDebInfo

configure:
	-mkdir -p $(FLABUFFERS_BUILD_DIR)
	cmake -G"$(RADIANT_CMAKE_GENERATOR)" -B$(FLABUFFERS_BUILD_DIR) -H. $(FLABUFFERS_FLAGS)

.PHONY: clean
clean:
	rm -rf build/x86
	rm -rf build/x64

# Windows
else

.PHONY: default
default: configure build
	echo done

build: configure
	$(MSBUILD) $(FLABUFFERS_BUILD_DIR)/FlatBuffers.sln -p:configuration=debug,platform=$(MSBUILD_PLATFORM)
	$(MSBUILD) $(FLABUFFERS_BUILD_DIR)/FlatBuffers.sln -p:configuration=release,platform=$(MSBUILD_PLATFORM)

configure:
	-mkdir -p $(FLABUFFERS_BUILD_DIR)
	$(CMAKE) -G"$(RADIANT_CMAKE_GENERATOR)" -B$(FLABUFFERS_BUILD_DIR) -H. $(FLABUFFERS_FLAGS)

.PHONY: clean
clean:
	rm -rf build/x86
	rm -rf build/x64

endif

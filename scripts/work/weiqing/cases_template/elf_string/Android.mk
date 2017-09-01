LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
    CVE_201x_xxxx.cpp \

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libdl \
    libtoolkit \
	libcapstone \

LOCAL_STATIC_LIBRARIES := \

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/../libs/libwheeljack/include \
	$(LOCAL_PATH)/../libs/libtoolkit/include \
    $(LOCAL_PATH)/ \
    bionic \

ifeq ($(shell expr $(PLATFORM_SDK_VERSION) "<" 23), 1)
    LOCAL_SHARED_LIBRARIES += libstlport
    LOCAL_C_INCLUDES += \
        bionic/libstdc++/include \
        external/stlport/stlport
endif

LOCAL_CFLAGS += -pie -fPIE -fvisibility=hidden -s

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE:= CVE_201x_xxxx

include $(BUILD_SHARED_LIBRARY)

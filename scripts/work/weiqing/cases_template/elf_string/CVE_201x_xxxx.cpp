
#include <new>
#include <string.h>
#include <unistd.h>
#include "CVE_201x_xxxx.h"
#include "WJNativeStaticAnalyzer.h"
#include "WJNativeElfAnalyzer.h"
#include "WJNativeLog.h"
#define TAG "CVE_201x_xxxx"

namespace wheeljack {
    extern "C" EXPORT_SYMBOL WJNativeCase* create_nativecase(WJNativeEnvironment* pEnv __unused) {
        WJNativeCase* pCase = new (std::nothrow) CVE_201x_xxxx_CASE();
        return pCase;
    }

    extern "C" EXPORT_SYMBOL void destroy_nativecase(WJNativeCase* pCase) {
        delete pCase;
    }

    static int CVE_201x_xxxx_BLOCK0(void) {
        int ret = WJ_RET_OK_VULNERABLE;
        const char* toBeSearched[] = {"xxx",
                                      "xxx"};
        FILE *file = NULL;
        const char* fileName = "/system/lib/...";

        if(access(fileName, R_OK) == -1) {
            LOGI(TAG, "file not exist");
            return WJ_RET_OK_NO_EXIST_NO_SYSLIB_ELF;
        }

        file = fopen(fileName, "r");
        if(NULL == file) {
            return WJ_RET_ERROR_FILE_OPEN;
        }

        for (size_t i = 0; i < sizeof(toBeSearched)/sizeof(char*); i++) {
            if(WJNativeStaticAnalyzer::isStringExists(file, toBeSearched[i]))
                ret = WJ_RET_OK_PATCHED;
        }

        fclose(file);
        return ret;
    }

    static struct WJNativeBlock CVE_201x_xxxx_BLOCKS[] = {
        {"CVE_201x_xxxx_BLOCK0", CVE_201x_xxxx_BLOCK0},
        {NULL, NULL}
    };

    CVE_201x_xxxx_CASE::CVE_201x_xxxx_CASE() {
        mInfo = new WJNativeCaseInfo(CVE_201x_xxxx_BLOCKS);
    }

    CVE_201x_xxxx_CASE::~CVE_201x_xxxx_CASE() {
        delete mInfo;
    }
}

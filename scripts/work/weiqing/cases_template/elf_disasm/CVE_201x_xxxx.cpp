
#include <new>
#include <string.h>
#include <unistd.h>
#include "WJNativeLog.h"
#include "WJNativeDisasmAnalyzer.h"
#include "CVE_201x_xxxx.h"
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
        size_t i = 0;
        int ret;
        const char* file = "/system/lib/...";
        const char* funcName = "xxx";
        struct DisasmResult *pDisasmResult;

        if(access(file, R_OK) == -1) {
            LOGI(TAG, "file not exist");
            return WJ_RET_OK_NO_EXIST_NO_SYSLIB_ELF;
        }

        WJNativeDisasmAnalyzer *pDisasmAnalyzer = new WJNativeDisasmAnalyzer(file);
        ret = pDisasmAnalyzer->analyze(funcName);
        if(ret >= ERROR_THRESHOLD) {
            LOGE(TAG, "Analysis error");
            goto OVER;
        }
        pDisasmAnalyzer->outputDisasm(BASIC);

        pDisasmResult = pDisasmAnalyzer->getDisasmResult();

        /* get instruction line number */
        if (2 == pDisasmAnalyzer->getInstructionCount([block_id, ]"bl", funcNameAnchorAddress)) {
            lineNumber = pDisasmAnalyzer->getInstructionLineNumber(1);
        }

        /*
        ret = WJ_RET_ERROR_UNKNOW;
        ret = WJ_RET_OK_VULNERABLE;
        for (i = 0; i < pDisasmResult->insn_count; ++i) {
            pDisasmAnalyzer->outputDisasm(BASIC, i);

            if(strncmp(pDisasmResult->insn[i].mnemonic, "mov", 3) == 0) {
                if(strstr(pDisasmResult->insn[i].op_str, "r0, #0x69") != NULL) {
                    ret = WJ_RET_OK_PATCHED;
                    break;
                }
            }
        }
        */

    OVER:
        delete pDisasmAnalyzer;
        return ret;
    }

    static int CVE_201x_xxxx_BLOCK1(void) {
        int ret;
        const char* file = "/system/lib/...";
        const char* funcName = "xxx";
        const char* funcNameAnchor = "xxx";
        const char* funcNameAnchorAddress;

        if(access(file, R_OK) == -1) {
            LOGI(TAG, "file not exist");
            return WJ_RET_OK_NO_EXIST_NO_SYSLIB_ELF;
        }

        WJNativeDisasmAnalyzer *pDisasmAnalyzer = new WJNativeDisasmAnalyzer(file);

        ret = pDisasmAnalyzer->analyze(funcNameAnchor);
        if(ret >= ERROR_THRESHOLD) {
            LOGE(TAG, "Analysis error");
            goto OVER;
        }
        funcNameAnchorAddress = pDisasmAnalyzer->getFuncAddress();

        ret = pDisasmAnalyzer->analyze(funcName);
        if(ret >= ERROR_THRESHOLD) {
            LOGE(TAG, "Analysis error");
            goto OVER;
        }

        /* set divider */
        pDisasmAnalyzer->setDisasmBlocksDivider(NULL, xxx_op_str);

        blockCount = pDisasmAnalyzer->getDisasmBlocksCount();
        if(blockCount != 3){
            LOGE(TAG, "get disasm block count error!");
            goto OVER;
        }

        pDisasmAnalyzer->outputDisasmBlock(BASIC , 1);

        ret = WJ_RET_ERROR_UNKNOW;
        /*
        delCount = pDisasmAnalyzer->getInstructionCount(1 , NULL , "#0x280");
        if(delCount < 0){
            LOGE(TAG, "get #0x280 count error!");
            goto OVER;
        }

        if(3 == delCount){
            ret = WJ_RET_OK_PATCHED;
        } else if(2 == delCount){
            ret = WJ_RET_OK_VULNERABLE;
        }
        */

    OVER:
        delete pDisasmAnalyzer;
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

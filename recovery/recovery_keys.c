/*
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <linux/input.h>

#include "recovery_ui.h"
#include "common.h"
#include "extendedcommands.h"
#include <stdlib.h>
#include <sys/types.h>


int device_handle_key(int key_code, int visible) {
    pid_t  pid;
    pid = 0;
    if (visible) {
        switch (key_code) {
            case 158:
                return HIGHLIGHT_DOWN;
            case 407:
                return HIGHLIGHT_UP;

#if 0
            case KEY_POWER:
                if (ui_get_showing_back_button()) {
                    return SELECT_ITEM;
                }
                if (!get_allow_toggle_display())
                    return GO_BACK;
                break;
#endif
            case KEY_HOME:
            case KEY_LEFTBRACE:
            case KEY_ENTER:
            case BTN_MOUSE:
            case KEY_CAMERA:
            case KEY_F21:
            case KEY_SEND:
	        pid = fork();
	        if (!pid){
		    __system("/sbin/refresh.sh");
		    exit(0);
		}
		
                return SELECT_ITEM;
            case 139:
	    case 412:
            case KEY_END:
            case KEY_BACKSPACE:
		pid = fork();
	        if (!pid){
		    __system("/sbin/refresh.sh");
		    exit(0);
		}
                if (!ui_root_menu)
                    return GO_BACK;
        }
    }

    return NO_ACTION;
}


#!/usr/bin/env python3

import sys
import json

lines = sys.stdin.readlines()
original_task = json.loads(lines[0])
modified_task = json.loads(lines[1])
prio = modified_task.get("priority", "")
if prio == "H":
    modified_task["icon"] = ""
    print(f'added icon to \'{modified_task["descrtipion"]}\'')
else:
    modified_task["icon"] = ""
    print(f'removed icon from \'{modified_task["descrtipion"]}\'')
result = json.dumps(modified_task)
print(result)
sys.exit(0)

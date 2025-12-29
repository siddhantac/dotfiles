#!/usr/bin/env python3

import sys
import json

lines = sys.stdin.readlines()
original_task = json.loads(lines[0])
modified_task = json.loads(lines[1])
oldPrio = original_task.get("priority", "")
newPrio = modified_task.get("priority", "")
if newPrio == "H" and oldPrio != "H":
    modified_task["icon"] = ""
    print(f'added icon to \'{modified_task["description"]}\'')
elif newPrio != "H" and oldPrio == "H":
    modified_task["icon"] = ""
    print(f'removed icon from \'{modified_task["description"]}\'')
result = json.dumps(modified_task)
print(result)
sys.exit(0)

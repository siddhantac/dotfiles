#!/usr/bin/env python3

import sys
import json

lines = sys.stdin.readlines()
original_task = json.loads(lines[0])
modified_task = json.loads(lines[1])
prio = modified_task.get("priority", "")
if prio == "H":
    modified_task["icon"] = ""
else:
    modified_task["icon"] = ""
result = json.dumps(modified_task)
print(result)
print(f'added icon to task with priority {modified_task}')
sys.exit(0)

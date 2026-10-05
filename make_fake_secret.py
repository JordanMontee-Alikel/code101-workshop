"""Writes a FAKE AWS key to config.py so you can see GitGuardian catch it.

The key is random: it has the right shape but does not work anywhere.
A new one is generated each time, so nobody shares the same "leak".
"""

import random
import string

key_id = "AKIA" + "".join(random.choices(string.ascii_uppercase + "234567", k=16))
secret = "".join(random.choices(string.ascii_letters + string.digits, k=40))

with open("config.py", "w") as f:
    f.write("# Oops! Credentials pasted straight into the code.\n")
    f.write(f'AWS_ACCESS_KEY_ID = "{key_id}"\n')
    f.write(f'AWS_SECRET_ACCESS_KEY = "{secret}"\n')

print("Fake AWS key written to config.py")

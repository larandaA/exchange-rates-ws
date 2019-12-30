import random
import sys
import os
import string
import subprocess


def bank():
	bid = "".join(random.choice(string.ascii_letters) for _ in range(5))
	name = bid + " Bank"
	cost = random.randint(100, 1000) / 100.0
	return (bid, name, cost)


def query(b):
	return """INSERT INTO bank (id, name, cost, last_update) VALUES ('{}', '{}', {}, totimestamp(now()))""".format(*b)


def cqlsh(qs):
	env = dict(os.environ)
	env["CQLSH_NO_BUNDLED"] = "TRUE"
	subprocess.check_call(["cqlsh", "localhost", "-k", "erws", "-e", ";".join(qs)], env=env)


def populate(count):
	qs = []
	for _ in range(count):
		b = bank()
		qs.append(query(b))
		print(b[0])

	cqlsh(qs)


if __name__ == "__main__":
	cqlsh(["TRUNCATE bank"])
	populate(int(sys.argv[1]))
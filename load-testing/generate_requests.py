import random
import sys

if __name__ == "__main__":
	ids = list(map(lambda _: _.strip(), sys.stdin.readlines()))
	reqs = []

	for bid in ids:
		for _ in range(10):
			reqs.append("GET||/banks/{id}/rates||rates||".format(id=bid))
		for _ in range(10):
			reqs.append("GET||/rates/min||min||")
	reqs.append("""PUT||/banks/%s/rates||update||{"bank": {"id":"","name":"","rates":""}, "rate":{"cost":42.108, "lastUpdate":"2019-12-30T03:05:06+03:00","fromUnit":1.0,"toUnit":1.0,"fromName":"","toName":""},"self":""}""" % random.choice(ids))
	reqs.append("""PUT||/banks/%s/rates||update||{"bank": {"id":"","name":"","rates":""}, "rate":{"cost":3.14, "lastUpdate":"2019-12-30T03:05:06+03:00","fromUnit":1.0,"toUnit":1.0,"fromName":"","toName":""},"self":""}""" % random.choice(ids))
	random.shuffle(reqs)

	for req in reqs:
		print(req)
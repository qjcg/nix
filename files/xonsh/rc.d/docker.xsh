import re


def docker_pull_all(skip_regex='none|harbor.drw'):
	"""Pull latest versions of docker images in local cache.
	"""
	images = $(docker images | awk 'NR > 1 {print $1":"$2}').split()
	for i in images:

		# Skip image names matching skip_regex.
		if re.search(skip_regex, i):
			continue

		docker pull @(i)

	docker image prune -f

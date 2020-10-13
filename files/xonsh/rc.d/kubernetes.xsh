aliases['k'] = 'kubectl'


def _k8s_status():
	"""Return current Kubernetes context and namespace.
	"""
	ctx = $(kubectl config view --minify --output 'jsonpath={.current-context}').rstrip()
	ns = $(kubectl config view --minify --output 'jsonpath={..namespace}').rstrip()

	if ctx and ns:
		status = f"{ctx} ({ns})"
	elif ctx and not ns:
		status = f"{ctx}"
	else:
		status = ""

	return status


$PROMPT_FIELDS['k8s'] = _k8s_status

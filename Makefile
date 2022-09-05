.PHONY: lint
lint:
	bash -c "autoflake LASERembeddingv2 -r --in-place --remove-unused-variables"
	bash -c "isort ."
	bash -c "black ."
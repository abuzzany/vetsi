.DEFAULT_GOAL := help
.PHONY: help

setup: ## Install dependencies from Gemfile.
	bundle install

start: ## Start web server locally.
	bundle exec rackup --host 0.0.0.0 -p 4567

test: ## Run test suite (Rspec).
	bundle exec rspec spec/*

rubocop: ## Run linter (Rubocop).
	bundle exec rubocop

dkr-setup: ## Build vetsi app on Docker.
	docker build -t vetsi-app:v1 .

dkr-start: ## Start and lunch the vetsi on Docker.
	docker run -d -p 4567:4567 vetsi-app:v1 && sleep 3 && open http://localhost:4567

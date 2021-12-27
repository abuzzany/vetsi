.DEFAULT_GOAL := help
.PHONY: help

setup:
	bundle install

start:
	ruby app.rb

test:
	bundle exec rspec spec/*

rubocop:
	bundle exec rubocop

dkr-setup:
	docker build -t vetsi-app:v1 .

dkr-start:
	docker run -d -p 4567:4567 vetsi-app:v1 && sleep 3 && open http://localhost:4567

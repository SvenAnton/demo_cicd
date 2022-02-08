# README #

### What is this repository for? ###

* PoC for continius delivery
* Testing features for deployment integration
* Practice GitHub Actions




### How do I get set up? ###

Clone the repo and then in project root run
```bash
docker-compose up --build
```
**NB!** It will automatically detect whether the database for application exists and creates it with migration if it does not exist. So no need to worry about it.


### How to use ###
This app enables you to create users and payments. Endpoints:
* /users
* /payments

In payments, payer and receiver must be user ids, so be sure to create users before payments. There is no error handling atm.

### Softeware versions ###
* Rails 6 with Webpacker
* Ruby 3.0.2
* Postgres 14



### Who do I talk to? ###

* Ops team
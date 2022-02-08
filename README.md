# README

### What is this repository for?

* PoC for continius delivery
* Testing features for deployment integration


### Infra setup

**NB!** Currently there is no guide for usage.

##### General functionality
1. Local Develeopment Environment with Docker for Rails application;
2. Automated testing for feature branches and the main branch (workflow: *Create Release*);
3. Automated deployment procedure, where:
3.1 a new push to main branch triggers staging deploy (after automated tests are succesful, look (workflow: *Deploy to Staging*));
3.2 a new tag in origin triggers the creation of creates a release with automatically created release notes in GitHub (workflows: *Create Release*);
3.3 The release of a release (change pre-release status) triggers production deploy (workflow: *Deploy to prod*)

Workflows are located in `.github/workflows`, where the file name does not strictly match the name of the workflow.

##### Deployment
Deploys are based on AMIs (Amazon Machine Images). Packer builds the AMIs, publishes them to the registry. Terraform then takes the AMI and creates EC2 instances with new AMI if new AMI has been provided.

##### Tools and platforms
* AWS;
* GitHub Actions;
* Terraform;
* Packer (with Ansible)

### Example app local setup
##### Setup
Clone the repo and then in project root run
```bash
docker-compose up --build
```
**NB!** It will automatically detect whether the database for application exists and creates it with migration if it does not exist. So no need to worry about it.

##### Test endpoints
This app enables you to create users and payments. Endpoints:
* /users
* /payments

In payments, payer and receiver must be user ids, so be sure to create users before payments. There is no error handling atm.

##### Softeware versions
* Rails 6 with Webpacker
* Ruby 3.0.2
* Postgres 14



### Who do I talk to? ###

* Ops team
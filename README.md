# LionHelp - A Platform for Convenient Help Seeking

## Team member names and UNIs
* Junhao Lin - jl5816
* Rui Chu - rc3414
* Qiwen Luo - ql2427
* Yixin Pan - yp2601

## Instructions to run the program locally
1. Install Node.js and npm: <https://docs.npmjs.com/downloading-and-installing-node-js-and-npm>
2. Install ruby and bundler: <https://github.com/rbenv/rbenv#installation>
3. Install PostgreSQL, please follow step 1 and 2 of in one of these tutorials:
	* Ubuntu: <https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04>
    * macOS: <https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos>
4. Run the following command to install ruby packages:  
`bundle install`
5. Run the following command to install front end packages:  
`npm install`
6. Depending on your PostgreSQL configuration, you may need to edit the default `username` and `password` accordingly in `config/database.yml`
7. Run the following commands to create schema and tables:  
```
rails db:create
rails db:migrate
rails db:seed
```
If you wish to run test locally, be sure to run `rails db:migrate RAILS_ENV=test` as well.
8. Run `rails server`, and check with a browser at <http://localhost:3000>. It might take a bit longer to render if it’s the first time you run

## Heroku Live Version
<https://gentle-cliffs-83673.herokuapp.com/> 

## Coverage report is under coverage/index.html

## Summary with LionHelp’s features

### Implemented in iter 1
* User login and signup
* User profile page
* Homepage where user can see all posted requests
* Post page where logged-in user can post a new request
* Authentication has been added to each page

### To-do features
* A page with all unfulfilled/unexpired requests posted by the current user and the user can edit these requests
* A page with all fulfilled/expired requests
* A page with all requests that the current user helped with
* On homepage, logged-in user can choose to help with some requests
* A filter on all available requests on homepage
* Feedback/comment on requests 

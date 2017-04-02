# MatchMe

MatchMe is a simple dating application that matches users according to their values and beliefs.

## Getting Started

1. Clone the repo and then install the needed gems:

```
$ bundle install --without production
```

2. Start Postgresql:

```
$ sudo service postgresql start
```

3. Create local databases in Postgresql and change user password:

```
$ sudo sudo -u postgres psql
postgres=# create database matchme_development owner=ubuntu;
postgres=# create database matchme_test owner=ubuntu;
postgres=# ALTER USER ubuntu PASSWORD 'password';
```

4. Migrate the database:

```
$ rails db:migrate
```

5. Run the test suite:

```
$ rails test
```

6. Run the app in a local server:

```
$ rails server
```

Or if on Cloud9:

```
$ rails server -b $IP -p $PORT
```

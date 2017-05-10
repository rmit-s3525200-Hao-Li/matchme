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

3. Install ImageMagick

```
sudo apt-get update
sudo apt-get install imagemagick --fix-missing
```

4. Migrate and seed the database:

```
$ rails db:migrate
$ rails db:seed
```

5. Run the test suite:

```
$ rails test
```

6. Run the app in a local server:

```
$ rails server
```

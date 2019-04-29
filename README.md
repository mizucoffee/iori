![iori-logo](https://raw.githubusercontent.com/mizucoffee/iori/develop/iori-top.png)

## Build

```
$ # gem install bundler
$ bundle install
$ # npm install -g sass
$ sass scss/index.scss public/style.css
$ rake db:migrate # ENV=production
```

## Run

```
$ rackup config.ru -p <PORT> -o <HOST>
```
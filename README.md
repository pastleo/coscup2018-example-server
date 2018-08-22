Hime Server [![pipeline status](https://git.frost.tw/BasalticStudio/Hime/hime-server/badges/master/pipeline.svg)](https://git.frost.tw/BasalticStudio/Hime/hime-server/commits/master) [![coverage report](https://git.frost.tw/BasalticStudio/Hime/hime-server/badges/master/coverage.svg)](https://git.frost.tw/BasalticStudio/Hime/hime-server/commits/master)
===

## Requirement

* Ruby 2.5.1
* PostgreSQL

## Firebase config

```shell=
cp config/{firebase-jwt-creator.json.sample => firebase-jwt-creator.json}
# visit https://console.firebase.google.com/project/[project-id]/settings/serviceaccounts/adminsdk

cp config/{firebase.json.sample => firebase.json}
# visit https://console.firebase.google.com/project/[project-id]/settings/general/
```

## Development

For client development, we need to modify `/etc/hosts` to define the hostname.

```
127.0.0.1 api.hime.lcoal
127.0.0.1 hime.local
```

And run the server using port `3000` to ensure the client can access it.

## Testing

### Generate Google Play IAP Receipt

Generate RSA Public/Private Key

```bash
openssl genpkey -algorithm RSA -out spec/fixtures/files/payment/google_play/private.key -pkeyopt rsa_keygen_bits:2048
openssl rsa -pubout -outform der -in spec/fixtures/files/payment/google_play/private.key -out spec/fixtures/files/payment/google_play/public.der
```

How to save receipt signature

```ruby
require 'openssl'

json = File.read(receipt_json_path)
key = OpenSSL::PKey::RSA.new(private_key)
sign = key.sign(OpenSSL::Digest::SHA1.new, json.gsub(/(\r\n|\r|\n)/, ''))
File.write(path, Base64.encode64(sign))
```

## Release

Before release new version, please update `config/initializers/version.rb` and change it to latest server version.

> TODO: Build Version should saved inside database and provide latest assets bundle for player.

## Deployment

### Server Environment

* Centos7
* Nginx with Passenger
* Ruby 2.5.1
* PostgreSQL

### Environment Variables

#### TLD_LENGTH

The Rails default set it to 1, so the `request.subdomain` will return `api` if host is `api.basaltic.tw`
But this project is using `api.hime.basaltic.tw` as hostname, we need set it to 2.

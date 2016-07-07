# Sidekiq WebUI w/ Auth0

Standalone [Sidekiq](https://sidekiq.org) WebUI that uses [Auth0](https://auth0.com) as an authentication provider.

## Usage

1. Clone this repo.
2. `bundle install`
3. `cp sample.env .env`
4. Edit .env with correct Auth0 Client ID, Client Secret, and Domain. Generate a secret key using `openssl rand -base64 48`
5. `foreman run rackup -p8000`

## Issue Reporting

If you have found a bug or if you have a feature request, please report them at this repository issues section.

## Author/Contributors

* [PermitZone](permitzone.com)
* [Adam Michel](https://github.com/awmichel)

## License

This project is licensed under the MIT license. See the [LICENSE](LICENSE) file for more info.

# forwarder

Платформенно-независимое мобильное приложение для экспедиторов по приему платежей

Для сборки и запуска приложения необходимо иметь в корне проекта файл .env с переменными среды:

* FORWARDER_SENTRY_DSN
* FORWARDER_RENEW_URL

Также приложения можно запускать без .env файла, но тогда при запуске надо указывать
`--dart-define FORWARDER_SENTRY_DSN=<значение> --dart-define FORWARDER_RENEW_URL=<значение>`

# SYNOPSIS

    enable 'RequestHeaders',
        set => ['Accept-Encoding' => 'identity'],
        unset => ['Authorization'];

# DESCRIPTION

This middleware allows the modification of HTTP request headers. For instance,
util for use with [Plack::App::Proxy](https://metacpan.org/pod/Plack::App::Proxy).

# SEE ALSO

[Plack::Middleware::Headers](https://metacpan.org/pod/Plack::Middleware::Headers), [Plack::Middleware](https://metacpan.org/pod/Plack::Middleware),  [Plack::Builder](https://metacpan.org/pod/Plack::Builder)

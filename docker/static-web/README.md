Static Websites
===============

This Docker container hosts static websites. Every site hosted here needs to
be in a public git repository like Github et. al. The site is `clone`d from
the repository when the a Docker instance is started. Optionally, Jekyll is
run inside the repository before serving the site. When the repository of the
site is hosted on Github the Webhook of this repository can be confiured to
POST to `hooks.das-labor.org/github`. This will update the site each `git push`.

Adding A Site
-------------

What sites to serve is configured using environment variables in the Dockerfile.
Each site needs a environment variable starting with `STATIC_SITE_` like
`STATIC_SITE_FOOBAR`. The values is the FQDN, repository URL and whenever
the site needs to be preprocessed with Jekyll. These three values are seperated
with comma.

``
ENV STATIC_SITE_FOOBAR="foo.bar,https://github.com/das-labor/foo.bar,true"
``

This line would cause a new site at `foo.bar` to be pulled from the git repository
`https://github.com/das-labor/foo.bar`. After running Jekyll inside the cloned
repository the contents of `_site` would be served by the container at port 80.

Remember to let the domain name point to the server IP.

Automatic Updates
-----------------

The site will only be cloned once when a instance of this container is started.
If you have this site hosted on Github and want the contents of the container
be up to date with the repository you can configure a webhook in the Github
repository. Under "Settings" -> "Webhooks & Services" add a webook. Set the
payload URL to http://api.das-labor.org/github and set the content type to
"application/x-www-form-urlencoded". The site will now be update each `git push`.

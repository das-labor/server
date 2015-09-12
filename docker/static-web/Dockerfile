FROM nginx
MAINTAINER seu <seu@panopticon.re>

EXPOSE 80

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
		DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install \
        git-core \
				m4 \
				ruby-i18n \
				jekyll && \
    rm -rf /var/lib/apt/lists/* && \
		apt-get clean

ENV STATIC_SITE_ELEKTROPOTT="elektropott.de,https://github.com/das-labor/elektropott.de.git,false"
ENV STATIC_SITE_LT15="labortage.das-labor.org,https://github.com/das-labor/lt15.git,false"
ENV STATIC_SITE_REPAIRCAFE="repaircafe-bochum.de,https://github.com/das-labor/repaircafe-bochum.de.git,true"

COPY nginx.m4 /
COPY entrypoint.sh /
CMD /entrypoint.sh

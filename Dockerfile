FROM node:16.10

RUN npm install -g @angular/cli

RUN apt-get -y update
RUN apt-get -y install zip

RUN JQ_URL="https://circle-downloads.s3.amazonaws.com/circleci-images/cache/linux-amd64/jq-latest" \
  && curl --silent --show-error --location --fail --retry 3 --output /usr/bin/jq $JQ_URL \
  && chmod +x /usr/bin/jq
       
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install google-chrome-stable

COPY entrypoint.sh /entrypoint.sh

USER 1001:1001

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]

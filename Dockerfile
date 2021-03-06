FROM node:8-alpine

LABEL name "Listen"
LABEL version "0.1.0"
LABEL maintainer "iCrawl <icrawltogo@gmail.com>"

# Set the work directory
WORKDIR /usr/src/Listen
# Copy over the dependency & lock files
COPY package.json package-lock.json ./

#  Install dependencies
RUN apk add --update \
&& apk add --no-cache ffmpeg opus pixman cairo pango giflib ca-certificates \
&& apk add --no-cache --virtual .build-deps git curl pixman-dev cairo-dev pangomm-dev \
libjpeg-turbo-dev giflib-dev python g++ make \
\
# Install node.js dependencies
&& npm i \
\
# Clean up build dependencies
&& apk del .build-deps

# Add project source
COPY . .

# Setting environment variables
ENV NODE_ENV= \
	COMMAND_PREFIX= \
	OWNERS= \
	DISCORD_SERVER_INVITE= \
	DISCORD_BOT_INVITE= \
	TOKEN= \
	PAGINATED_ITEMS= \
	WEBSOCKET= \

	# Databases
	DB= \
	REDIS= \

	# Discord channels
	DISCORD_WEBHOOK_ID= \
	DISCORD_WEBHOOK_TOKEN= \
	RADIO_CHANNELS= \

	# Bunch of API keys

	# Music settings
	DEFAULT_VOLUME= \
	MAX_LENGTH= \
	MAX_SONGS= \
	PACKET_PASSES=

# Execute Listen
CMD ["node", "src/Listen.js"]

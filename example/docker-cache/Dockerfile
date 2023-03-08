# syntax = docker/dockerfile:experimental

### Base
FROM node:14.19.1-stretch-slim AS base

ENV NODE_OPTIONS --max_old_space_size=8192
ENV YARN_CACHE_FOLDER /home/node/.cache

RUN mkdir -p /app && \
    chown node:node /app
RUN mkdir -p /home/node/.cache && \
    chown node:node /home/node/.cache

WORKDIR /app

### Builder
FROM base AS builder

RUN --mount=type=cache,id=apt-cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,id=apt-state,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,id=pip-cache,target=/var/cache/pip,sharing=locked \
    echo 'Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/99use-gzip-compression \
    && apt-get -yq update \
    && apt-get -yq install --no-install-recommends python3-pip python3-setuptools \
    && pip3 install --cache-dir /var/cache/pip wheel awscli

### Server
FROM base AS server

RUN touch sample.txt
RUN touch sample2.txt

ARG NODE_ENV="production"
ARG IMAGE_TAG=""
ARG GIT_COMMIT=""
ARG CREATED_AT=""

ENV NODE_ENV ${NODE_ENV}
ENV IMAGE_TAG ${IMAGE_TAG}
ENV GIT_COMMIT ${GIT_COMMIT}
ENV CREATED_AT ${CREATED_AT}

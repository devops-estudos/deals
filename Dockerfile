FROM cgr.dev/chainguard/node:latest-dev AS builder
RUN corepack install -g pnpm
WORKDIR /usr/src/app
COPY package.json .
COPY pnpm-lock.yaml .
COPY dist .
RUN pnpm install --prod --frozen-lockfile

FROM cgr.dev/chainguard/node:latest
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/ .

ENTRYPOINT [ "node" ]
CMD [ "main" ]
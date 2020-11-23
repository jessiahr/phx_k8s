FROM elixir:1.9 AS builder
ENV MIX_ENV=prod
WORKDIR /usr/local/phx_k8s
# This step installs all the build tools we'll need
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get install -y nodejs && \
    mix local.rebar --force && \
    mix local.hex --force
# Copies our app source code into the build container
COPY . .
# Compile Elixir
RUN mix do deps.get, deps.compile, compile
# Compile Javascript
RUN cd assets \
    && npm install \
    && npm rebuild node-sass \
    && ./node_modules/webpack/bin/webpack.js --mode production \
    && cd .. \
    && mix phx.digest
# Build Release
RUN mkdir -p /opt/release \
    && mix release \
    && mv _build/${MIX_ENV}/rel/phx_k8s /opt/release
# Create the runtime container
FROM erlang:22 as runtime
WORKDIR /usr/local/phx_k8s
COPY --from=builder /opt/release/phx_k8s .
CMD [ "bin/phx_k8s", "start" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=2 \
 CMD nc -vz -w 2 localhost 4000 || exit 1
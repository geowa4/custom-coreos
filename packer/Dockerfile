FROM hashicorp/packer:light
CMD ["-machine-readable", "build", "custom.json"]
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

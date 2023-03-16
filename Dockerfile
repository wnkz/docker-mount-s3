FROM amazonlinux:2 as builder

RUN yum update -y && \
  yum install -y git fuse fuse-devel make cmake3 clang-devel && \
  yum clean all
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
ENV PATH="~/.cargo/bin:${PATH}"

WORKDIR /usr/local/src
RUN git clone --recurse-submodules https://github.com/awslabs/mountpoint-s3.git
WORKDIR mountpoint-s3
RUN cargo build --release

FROM amazonlinux:2

RUN yum update -y && \
  yum install -y fuse-libs && \
  yum clean all
COPY --from=builder /usr/local/src/mountpoint-s3/target/release/mount-s3 /usr/local/bin/

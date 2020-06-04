FROM alpine:3 as build

RUN apk update && \
  apk add git build-base ninja cmake python3

ENV LLVM_TAG llvmorg-10.0.0

WORKDIR /build-llvm/llvm-project
RUN git clone --branch ${LLVM_TAG} --depth 1 https://github.com/llvm/llvm-project.git /build-llvm/llvm-project
RUN mv clang llvm/tools
RUN mv libcxx llvm/projects

WORKDIR /build-llvm/llvm-project/llvm/build
RUN cmake -GNinja -DLLVM_BUILD_STATIC=ON -DLLVM_ENABLE_LIBCXX=ON ..
RUN ninja clang-format

FROM alpine:3

COPY --from=build /build-llvm/llvm-project/llvm/build/bin/clang-format /usr/local/bin

ENTRYPOINT ["clang-format"]
CMD ["--help"]

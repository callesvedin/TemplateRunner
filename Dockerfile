FROM swift:5.4 as builder
WORKDIR /TemplateRunner

COPY . .

#RUN swift package clean
RUN swift build -c release
RUN mkdir -p ./app/bin
RUN mv `swift build -c release --show-bin-path` ./app/bin

FROM swift:5.4-slim
WORKDIR /TemplateRunner
COPY --from=builder /TemplateRunner/app/bin/release/template-runner .
CMD ["./template-runner"]

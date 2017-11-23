FROM microsoft/dotnet-nightly:2.1-sdk as builder

WORKDIR /app
COPY . .

RUN dotnet publish -c release -r alpine.3.6-x64 -o out /p:ShowLinkerSizeComparison=true

FROM microsoft/dotnet-nightly:2.1-runtime-deps-alpine

WORKDIR /app

COPY --from=builder /app/out/ .

ENTRYPOINT [ "/app/small-docker-test" ]

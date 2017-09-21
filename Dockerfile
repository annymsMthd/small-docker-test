FROM microsoft/dotnet:latest AS build-box

WORKDIR /app
COPY . .

RUN dotnet publish -c release -r linux-x64 -o out

FROM bitnami/minideb

RUN apt-get update && apt-get install -y libunwind8 curl libicu57

WORKDIR /app

COPY --from=build-box /app/out/ .

ENTRYPOINT [ "/app/small-docker-test" ]

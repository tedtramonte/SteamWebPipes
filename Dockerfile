FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app
COPY ./SteamWebPipes/*.csproj ./
RUN dotnet restore
COPY ./SteamWebPipes/. ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "SteamWebPipes.dll"]
EXPOSE 8181

#Generated Time: $Timestamp
FROM microsoft/$IMAGETYPE-aspnetcore-runtime AS base
ENV USERNAME=$USERNAME
ENV GROUP=$GROUP
ENV HOME=/home/${USERNAME}
RUN mkdir -p ${HOME}

# Create a group and user (system account) which will execute the app
RUN groupadd -r -g 3000 ${GROUP} &&\
useradd -r -u 1000 -g ${GROUP} -d ${HOME} -s /sbin/nologin -c "Docker app user" ${USERNAME}

# Alpine uses addgroup and adduser and not groupadd and useradd
# RUN addgroup -S -g 3000 ${GROUP} && adduser -S -u 1000 ${USERNAME} -G ${GROUP} -h ${HOME} -s /sbin/nologin
# Change the context to the app user
#USER ${USERNAME}
ENV COMPlus_EnableDiagnostics=0
WORKDIR /app
EXPOSE 5001

FROM base AS final
WORKDIR /app
#COPY --from=publish /app .
COPY /app/publish .

ENTRYPOINT ["dotnet", "$DLLNAME"]

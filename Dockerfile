FROM ubuntu:20.04
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
RUN apt-get update && \
    apt-get install openjdk-11-jdk maven tomcat9 git -y
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /tmp/buxfuse/
WORKDIR /tmp/buxfuse/
RUN mvn package
RUN cp target/hello-1.0.war $CATALINA_HOME/webapps/
EXPOSE 8080
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]

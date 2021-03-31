FROM maven:3.6.3-jdk-8

RUN apt update; apt install -y lsof wget tar;
ARG sha

RUN git clone https://github.com/BroadleafCommerce/DemoSite.git
WORKDIR /DemoSite
RUN git checkout ${sha};
RUN mvn clean install

EXPOSE 8001
EXPOSE 8081
EXPOSE 8000
EXPOSE 8080

RUN mkdir -p admin/src/resources/logging
RUN mkdir -p api/src/resources/logging
RUN mkdir -p site/src/resources/logging

COPY logback.xml admin/src/resources/logging
COPY logback.xml api/src/resources/logging
COPY logback.xml site/src/resources/logging

COPY start.sh .
CMD ["./start.sh"]
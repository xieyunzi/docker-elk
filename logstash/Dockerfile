FROM logstash:latest

RUN logstash-plugin install --no-verify logstash-codec-nmap

CMD ["logstash", "agent"]

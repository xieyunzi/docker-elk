test-logstash:
	docker run -it --rm -v ${PWD}/logstash/config:/etc/logstash/conf.d -v ${PWD}/logstash/patterns:/etc/logstash/patterns logstash -f /etc/logstash/conf.d/stdio.conf

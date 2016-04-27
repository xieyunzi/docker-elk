import scrapy


class TopSiteSpider(scrapy.Spider):
    name = 'top-site'
    start_urls = ['http://top.aizhan.com/']

    def parse(self, response):
        for href in response.selector.css('.ranklist li a[href]::attr(href)'):
            url = response.urljoin(href.extract())
            print(url)
            yield scrapy.Request(url, callback=self.parse_dir_contents)

    def parse_dir_contents(self, response):
        for link in response.selector.css('#Default .on a[href]'):
            site = link.xpath('text()').extract()[0].strip()
            print(site)

            with open('top_sites.txt', 'a+') as f:
                f.write(site + "\n")

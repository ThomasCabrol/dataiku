import urllib

def encode(url):
    print urllib.quote(url, safe='')
    
encode("https://raw.githubusercontent.com/ThomasCabrol/dataiku/master/partners/microsoft/hdinsights/DSS/azuredeploy.json")
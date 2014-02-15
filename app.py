# Author: Abid H. Mujtaba
# Email: abid.naqvi83@gmail.com
# Date: 2014-02-15

"""
This application is meant to be run by uwsgi. It handles requests by returning a status code and HTML content which it
 generates using Jinja2 template:

 Source:

    http://kagerato.net/articles/software/libraries/jinja-quickstart.html
"""

import jinja2


def application(env, start_response):

    start_response('200 OK', [('Content-Type', 'text/html')])

    TEMPLATE_FILE = "/home/abid/scripts/chrome_cast/local-chromecast/index.html"        # Absolute Path to template

    templateLoader = jinja2.FileSystemLoader("/")        # We will be serving a template from the same folder as this script
    templateEnv = jinja2.Environment(loader=templateLoader)

    template = templateEnv.get_template(TEMPLATE_FILE)

    output = template.render()

    return str(output)      # The output has to be explicitly cast as a string for this to work

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
import os


def application(env, start_response):

    MEDIA_PATH = "/home/abid/scripts/chrome_cast/local-chromecast/media"

    media = [f for f in os.listdir(MEDIA_PATH) if os.path.isfile( os.path.join(MEDIA_PATH, f) )]        # Get a (alphabetically) sorted list of all files (not folders) in the media folder
    media.sort()

    start_response('200 OK', [('Content-Type', 'text/html')])

    TEMPLATE_FILE = "/home/abid/scripts/chrome_cast/local-chromecast/index.html"        # Absolute Path to template
    MEDIA_URL_PATH = "http://192.168.1.10:3435/media/"

    templateLoader = jinja2.FileSystemLoader("/")        # We will be serving a template from the same folder as this script
    templateEnv = jinja2.Environment(loader=templateLoader, trim_blocks=True, lstrip_blocks=True)       # We pass in information for removing extraneous whitespace from the rendered text

    template = templateEnv.get_template(TEMPLATE_FILE)

    output = template.render({"media": media, "media_path": MEDIA_URL_PATH})

    return str(output)      # The output has to be explicitly cast as a string for this to work

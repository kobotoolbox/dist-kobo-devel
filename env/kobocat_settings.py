import os
from onadata.settings.common import * 

DEBUG = True
TEMPLATE_DEBUG = DEBUG
TEMPLATE_STRING_IF_INVALID = ''

BASE_DIR = os.path.dirname(os.path.dirname(__file__))

import dj_database_url

DATABASES = {
    'default': dj_database_url.config(default="sqlite:///%s/db.sqlite3" % BASE_DIR)
}

SECRET_KEY = os.environ.get('DJANGO_SECRET_KEY', 'mlfs33^s1l4xf6a36$0xsrgcpj_dd*sisfo6HOktYXB9y')

TESTING_MODE = False
if len(sys.argv) >= 2 and (sys.argv[1] == "test"):
    # This trick works only when we run tests from the command line.
    TESTING_MODE = True
else:
    TESTING_MODE = False

if TESTING_MODE:
    MEDIA_ROOT = os.path.join(PROJECT_ROOT, 'test_media/')
    subprocess.call(["rm", "-r", MEDIA_ROOT])
    MONGO_DATABASE['NAME'] = "formhub_test"
    CELERY_ALWAYS_EAGER = True
    BROKER_BACKEND = 'memory'
    ENKETO_API_TOKEN = 'abc'
    #TEST_RUNNER = 'djcelery.contrib.test_runner.CeleryTestSuiteRunner'
else:
    MEDIA_ROOT = os.path.join(PROJECT_ROOT, 'media/')

if PRINT_EXCEPTION and DEBUG:
    MIDDLEWARE_CLASSES += ('utils.middleware.ExceptionLoggingMiddleware',)

# Clear out the test database
if TESTING_MODE:
    MONGO_DB.instances.drop()

# include the kobocat-template directory
TEMPLATE_OVERRIDE_ROOT_DIR = os.path.join(PROJECT_ROOT, '..', '..', 'kobocat-template')
TEMPLATE_DIRS = ( os.path.join(PROJECT_ROOT, TEMPLATE_OVERRIDE_ROOT_DIR, 'templates'), ) + TEMPLATE_DIRS
STATICFILES_DIRS += ( os.path.join(PROJECT_ROOT, TEMPLATE_OVERRIDE_ROOT_DIR, 'static'), )

KOBOFORM_SERVER=os.environ.get("KOBOFORM_SERVER", "localhost")
KOBOFORM_SERVER_PORT=os.environ.get("KOBOFORM_SERVER_PORT", "8000")
KOBOFORM_SERVER_PROTOCOL=os.environ.get("KOBOFORM_SERVER_PROTOCOL", "http")
KOBOFORM_LOGIN_AUTOREDIRECT=True
KOBOFORM_URL=os.environ.get("KOBOFORM_URL", "http://localhost:8000")

TEMPLATE_CONTEXT_PROCESSORS = (
    'onadata.koboform.context_processors.koboform_integration',
) + TEMPLATE_CONTEXT_PROCESSORS

MIDDLEWARE_CLASSES = ('onadata.koboform.redirect_middleware.ConditionalRedirects', ) + MIDDLEWARE_CLASSES

CSRF_COOKIE_DOMAIN = os.environ.get('CSRF_COOKIE_DOMAIN', None)

if CSRF_COOKIE_DOMAIN:
    SESSION_COOKIE_DOMAIN = CSRF_COOKIE_DOMAIN
    SESSION_COOKIE_NAME = 'kobonaut'

SESSION_SERIALIZER='django.contrib.sessions.serializers.JSONSerializer'

# for debugging
# print "KOBOFORM_SERVER=%s" % KOBOFORM_SERVER
# print "SECRET_KEY=%s" % SECRET_KEY
# print "CSRF_COOKIE_DOMAIN=%s " % CSRF_COOKIE_DOMAIN

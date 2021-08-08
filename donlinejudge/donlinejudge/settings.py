from pathlib import Path
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve(strict=True).parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '!(@vvs7z33kzg89h19y!913@q&x@(4%#kcunpadrh7l_4u-m5t'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = [
    '*',
]

# Application definition

LOCAL_APPS = [
    'accounts',
    'announcement',
    'submission',
    'problem',
    'judgeserver',
    'authenticate',
]

INSTALLED_APPS = [
    'django_extensions',    # python manage.py reset_db ## extension
    'django_q',             # multiprocessing
    'corsheaders',

    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'rest_framework.authtoken',
] + LOCAL_APPS


MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',

    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
CORS_ORIGIN_ALLOW_ALL = True

ROOT_URLCONF = 'donlinejudge.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'donlinejudge.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'donlinejudge',
        'USER': 'postgres',
        'PASSWORD': 'superadmin',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}

# Password validation
# https://docs.djangoproject.com/en/3.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.1/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.1/howto/static-files/

STATIC_URL = '/static/'
MEDIA_URL = '/media/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]
MEDIA_ROOT = os.path.join(BASE_DIR, 'static/media')

# ==
AUTH_USER_MODEL = 'accounts.User'
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        #'rest_framework.authentication.TokenAuthentication',
        'authenticate.models.ExpiringTokenAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        #'rest_framework.authentication.BasicAuthentication', #
    ],
    'DEFAULT_PARSER_CLASSES': [
        'rest_framework.parsers.FormParser',
        #'problem.parsers.CustomFormParser',
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.MultiPartParser'
    ],
}

# == DJANGO_Q settings
Q_CLUSTER = {
    'name': 'donlinejudge',
    # 'workers': 8,
    'max_attempt': 1,
    'recycle': 500,
    'timeout': 60,
    'compress': True,
    'cpu_affinity': 1,
    'save_limit': 250,
    'queue_limit': 500,
    'label': 'Django Q',
    'redis': {
        'host': '127.0.0.1',
        'port': 6379,
        'db': 0,
    }
}

#== User's defined global variables
PAGINATION_PAGE_SIZE = 10
OUTPUT_MAX_LENGTH = 255
TOKEN_EXPIRE_AFTER_SECONDS = 14400

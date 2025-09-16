import os
from pathlib import Path

# Build paths inside the project
BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = 'your-secret-key'

DEBUG = True

# Allow hosts from environment or default


# Read DJANGO_ALLOWED_HOSTS from environment (comma-separated)
ALLOWED_HOSTS = os.getenv("DJANGO_ALLOWED_HOSTS", "").split(",")

# Clean spaces, ignore empties
ALLOWED_HOSTS = [h.strip() for h in ALLOWED_HOSTS if h.strip()]

# For debugging (optional)
print("ALLOWED_HOSTS =", ALLOWED_HOSTS)

# Installed apps
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'todos',
]

# Middleware etc. (keep existing)
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'backend.urls'

# Templates / Database / etc (keep your existing configs)

CORS_ALLOW_ALL_ORIGINS = True  # allow React

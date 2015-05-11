from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.conf import settings

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'vhs_web.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^account/', include('account.urls')),
    url(r'^report/', include('report.urls')),
    url(r'^product/', include('product.urls')),
)

if not settings.DEBUG:
    urlpatterns += patterns('',
    (r'^static/(?P.*)$', 'django.views.static.serve', {'document_root': settings.STATIC_ROOT}),
)
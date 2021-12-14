from django.contrib import admin
from .models import Cloud_Connect
#indranil, India@1243

# Register your models here.
admin.site.register(Cloud_Connect)

'''
@admin.register(Cloud_Connect)
class Cloud_Connect_Admin(admin.ModelAdmin):
    list_display = ('cloudName', 'projectName', 'cloudServiceKeyLoc')
'''



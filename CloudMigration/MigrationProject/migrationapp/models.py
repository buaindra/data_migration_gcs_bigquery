from django.db import models

cloudNameChoices = (
    ('Local', 'On-Premise/Local'),
    ('GCP', 'Google Cloud Platform'),
    ('AWS', 'Amazon Workspace'),
    ('AZURE', 'Microsoft Azure')
)

# Create your models here.
class Cloud_Connect(models.Model):
    cloudName = models.CharField(max_length=50, choices=cloudNameChoices, default='gcp')
    projectName = models.CharField(max_length=100, blank=True)
    cloudServiceKeyLoc = models.CharField(max_length=1000, blank=True)



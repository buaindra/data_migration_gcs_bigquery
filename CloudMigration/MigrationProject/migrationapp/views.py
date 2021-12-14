from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect
from .forms import Cloud_ConnectForm
from .models import Cloud_Connect
from .BL.GCP_Resources import GCP
from .BL.GCP_Billing import GCP_Cloud_Billing


def home(request):
    context = {}
    return render(request, 'migrationapp/base.html', context)


def cloud_connect_add(request):
    context = {}
    if request.method == "POST":
        form = Cloud_ConnectForm(request.POST)
        if form.is_valid():
            # pm = form.cleaned_data["projectName"]
            # cc = Cloud_Connect(projectName=pm)
            # cc.save()
            form.save()
            form = Cloud_ConnectForm()
    else:
        form = Cloud_ConnectForm()
    context["dataset"] = Cloud_Connect.objects.all()
    context["form"] = form
    return render(request, 'migrationapp/cloud_connect_add.html', context)


def cloud_connect_details(request, id):
    context = {}
    cc = Cloud_Connect.objects.get(pk=id)
    context["cc"] = cc
    #print("Details Page:", cc.cloudServiceKeyLoc)
    gcp_obj = GCP(cc.projectName, cc.cloudServiceKeyLoc)
    context["gcp_bucket"] = gcp_obj.gcs_bucket()
    gcp_bl_obj = GCP_Cloud_Billing(cc.projectName, cc.cloudServiceKeyLoc)
    context["gcp_billing"] = gcp_bl_obj.billing_info_1()
    return render(request, 'migrationapp/cloud_connect_details.html', context)


def cloud_connect_delete(request, id):
    if request.method == "POST":
        cc = Cloud_Connect.objects.get(pk=id)
        cc.delete()
        return HttpResponseRedirect("/")


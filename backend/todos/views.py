from rest_framework import viewsets
from django.http import JsonResponse
from .models import Todo
from .serializers import TodoSerializer

class TodoViewSet(viewsets.ModelViewSet):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer

# Health endpoint
def health(request):
    return JsonResponse({"status": "ok"})



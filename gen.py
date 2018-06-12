from testproj.models import Ideas
import random
from django.contrib.auth.models import User
import string

for i in range(100):t = ''.join([random.choice(string.ascii_letters) for i in range(5)]);c = ''.join([random.choice(string.ascii_letters) for i in range(15)]);s = random.choice(['c','p','a','d']);idea = Ideas(author=User.objects.get(pk=1), title=t, content=c, status=s);idea.save()




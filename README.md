Домашнее задание по курсу Terraform Mega (https://slurm.io/intensive-terraform):
- написать модуль для Yandex managed Kubernetes, дока к ресурсам:
    * https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/website/docs/r/kubernetes_cluster.html.markdown;
    * https://github.com/yandex-cloud/terraform-provider-yandex/blob/master/website/docs/r/kubernetes_node_group.html.markdown
- с помощью terragrunt научиться использовать его для разных окружений

Известные недостатки:
- не очень хорошо проработан модуль k8s-node-group, в частности он не умеет работать с региональным кластером
- конфиг vpc в prod окружении :)
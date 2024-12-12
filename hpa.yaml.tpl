apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: ${core_name_metadata}
  namespace: ${namespace_name}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: ${core_name_deployment}
  minReplicas: ${core_min_replicas}
  maxReplicas: ${core_max_replicas}
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: ${core_target_cpu_utilization}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: ${core_target_memory_utilization}


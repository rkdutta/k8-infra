# k8-infra cluster folder structure

```
+--- clusters
|   +--- base
|   |   +--- BE
|   |   |   +--- kustomization.yaml
|   |   |   +--- service.yaml
|   |   +--- FE
|   |   |   +--- app
|   |   |   |   +--- app.yaml
|   |   |   |   +--- kustomization.yaml
|   |   |   +--- autoscaling
|   |   |   |   +--- hpa.yaml
|   |   |   |   +--- kustomization.yaml
|   |   |   +--- csi
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- SecretProviderClass.yaml
|   |   |   +--- ingress
|   |   |   |   +--- ingress-controller.yaml
|   |   |   |   +--- ingress.yaml
|   |   |   |   +--- kustomization.yaml
|   |   |   +--- kustomization.yaml
|   |   |   +--- networkpolicy
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- rules.yaml
|   |   |   +--- policies
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- pod-disruption-budget.yaml
|   |   |   |   +--- psp.yaml
|   |   |   +--- priority-class
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- priority-class.yaml
|   |   |   +--- quota
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- namespace-compute-resources.yaml
|   |   |   |   +--- object-counts.yaml
|   |   |   +--- runtime-class
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- runtime-class.yaml
|   |   |   +--- testing
|   |   |   |   +--- testing-acr-connection.yaml
|   |   |   |   +--- testing-akv-connectivity-csi-driver.yaml
|   |   |   |   +--- testing-akv-connectivity-pod-identity.yaml
|   |   |   +--- volumes
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- storage-class.yaml
|   |   +--- flux-system
|   |   |   +--- gotk-components.yaml
|   |   |   +--- gotk-sync.yaml
|   |   |   +--- kustomization.yaml
|   |   |   +--- patch-pod-identity.yaml
|   +--- overlays
|   |   +--- 01-production
|   |   |   +--- BE
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- svc-patch.yaml
|   |   |   +--- FE
|   |   |   |   +--- config.properties
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- pvc.yaml
|   |   |   |   +--- replica-patch.yaml
|   |   |   |   +--- volume-patch.yaml
|   |   |   +--- kustomization.yaml
|   |   +--- 02-stage
|   |   |   +--- BE
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- svc-patch.yaml
|   |   |   +--- FE
|   |   |   |   +--- config.properties
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- pvc.yaml
|   |   |   |   +--- replica-patch.yaml
|   |   |   |   +--- volume-patch.yaml
|   |   |   +--- kustomization.yaml
|   |   +--- 03-dev
|   |   |   +--- BE
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- svc-patch.yaml
|   |   |   +--- FE
|   |   |   |   +--- config.properties
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- pvc.yaml
|   |   |   |   +--- replica-patch.yaml
|   |   |   |   +--- volume-patch.yaml
|   |   |   +--- kustomization.yaml
|   |   +--- 04-test
|   |   |   +--- BE
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- svc-patch.yaml
|   |   |   +--- FE
|   |   |   |   +--- config.properties
|   |   |   |   +--- kustomization.yaml
|   |   |   |   +--- pvc.yaml
|   |   |   |   +--- replica-patch.yaml
|   |   |   |   +--- volume-patch.yaml
|   |   |   +--- kustomization.yaml

```

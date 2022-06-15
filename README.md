├───.templates
│   ├───ci
│   ├───container-registry
│   └───service-mesh
├───cd
│   └───base
│       ├───flux-system
│       └───overlays
│           └───01-production
├───clusters
│   ├───base
│   │   ├───BE
│   │   ├───FE
│   │   │   ├───app
│   │   │   ├───autoscaling
│   │   │   ├───csi
│   │   │   ├───ingress
│   │   │   ├───networkpolicy
│   │   │   ├───policies
│   │   │   ├───priority-class
│   │   │   ├───quotaAndLimits
│   │   │   ├───runtime-class
│   │   │   ├───testing
│   │   │   └───volumes
│   │   └───flux-system
│   └───overlays
│       ├───01-production
│       │   ├───BE
│       │   └───FE
│       ├───02-stage
│       │   ├───BE
│       │   └───FE
│       ├───03-dev
│       │   ├───BE
│       │   └───FE
│       └───04-test
│           ├───BE
│           └───FE
├───monitoring-metric-server-dashboard
├───monitoring-prometheus
│   ├───prometheus-monitoring-guide
│   │   ├───alertmanager-example
│   │   ├───grafana
│   │   ├───operator
│   │   │   └───grafana
│   │   ├───pushgateway
│   │   └───storage
│   └───prometheus-operator
│       ├───.github
│       │   ├───ISSUE_TEMPLATE
│       │   └───workflows
│       ├───cmd
│       │   ├───admission-webhook
│       │   ├───operator
│       │   ├───po-docgen
│       │   │   └───model
│       │   ├───po-lint
│       │   ├───po-rule-migration
│       │   └───prometheus-config-reloader
│       ├───contrib
│       │   └───kube-prometheus
│       ├───Documentation
│       │   ├───designs
│       │   ├───logos
│       │   └───user-guides
│       │       └───images
│       ├───example
│       │   ├───additional-scrape-configs
│       │   ├───admission-webhook
│       │   ├───alertmanger-webhook
│       │   ├───mixin
│       │   ├───networkpolicies
│       │   ├───non-rbac
│       │   ├───prometheus-operator-crd
│       │   ├───rbac
│       │   │   ├───prometheus
│       │   │   ├───prometheus-operator
│       │   │   └───prometheus-operator-crd
│       │   ├───shards
│       │   ├───storage
│       │   ├───thanos
│       │   └───user-guides
│       │       ├───alerting
│       │       └───getting-started
│       ├───helm
│       ├───internal
│       │   └───log
│       ├───jsonnet
│       │   ├───mixin
│       │   │   └───alerts
│       │   ├───prometheus-operator
│       │   └───thanos
│       ├───pkg
│       │   ├───admission
│       │   ├───alertmanager
│       │   ├───api
│       │   ├───apis
│       │   │   └───monitoring
│       │   │       ├───v1
│       │   │       └───v1alpha1
│       │   ├───assets
│       │   ├───client
│       │   │   ├───informers
│       │   │   │   └───externalversions
│       │   │   │       ├───internalinterfaces
│       │   │   │       └───monitoring
│       │   │   │           ├───v1
│       │   │   │           └───v1alpha1
│       │   │   ├───listers
│       │   │   │   └───monitoring
│       │   │   │       ├───v1
│       │   │   │       └───v1alpha1
│       │   │   └───versioned
│       │   │       ├───fake
│       │   │       ├───scheme
│       │   │       └───typed
│       │   │           └───monitoring
│       │   │               ├───v1
│       │   │               │   └───fake
│       │   │               └───v1alpha1
│       │   │                   └───fake
│       │   ├───informers
│       │   ├───k8sutil
│       │   ├───listwatch
│       │   ├───namespace-labeler
│       │   ├───operator
│       │   ├───prometheus
│       │   ├───server
│       │   ├───thanos
│       │   ├───versionutil
│       │   └───webconfig
│       ├───scripts
│       │   ├───certs
│       │   ├───generate
│       │   └───tooling
│       └───test
│           ├───e2e
│           │   └───remote_write_certs
│           ├───framework
│           │   └───resources
│           └───instrumented-sample-app
├───namespaces
└───tf
    ├───.terraform
    │   ├───modules
    │   └───providers
    │       └───registry.terraform.io
    │           ├───fluxcd
    │           │   └───flux
    │           │       └───0.14.1
    │           │           └───windows_386
    │           └───hashicorp
    │               ├───azurerm
    │               │   └───3.4.0
    │               │       └───windows_386
    │               └───null
    │                   └───3.1.1
    │                       └───windows_386
    └───modules
        └───01-nsg

// https://learn.hashicorp.com/tutorials/nomad/access-control-policies?in=nomad/access-control

// règles sur Jobs API, Deployments API, Allocations API, et Evaluations API
// voir dans jobHelper.nomad pour comprendre les namespaces
// la valeur du namespace par défaut est 'default'
namespace "*" {
  // içi la police read embarque une liste prédéfinie de droit:
  // list-jobs
  // read-job
  // csi-list-volume
  // csi-read-volume
  // list-scaling-policies
  // read-scaling-policy
  // read-job-scaling
  policy       = "read"
  // nous souhaitons des droits dans d'autres policies,
  // pour les sélectionner unitairement nous utilisons capabilities
  capabilities = ["submit-job","dispatch-job","read-logs"]
}

// La règle d'agent contrôle l'accès aux opérations utilitaires dans l'API d'agent,
// telles que rejoindre et quitter.
agent {
  policy = "write"
}

// La règle operator contrôle l'accès à l'API operator.
operator {
  policy = "write"
}

// La stratégie de quota contrôle l'accès aux opérations de spécification de quota dans l'API Quota,
// telles que la création et la suppression de quota.
quota {
  policy = "write"
}

// La règle de node contrôle l'accès à l'API de nœud, par exemple en répertoriant les nœuds ou
// en déclenchant un 'drain' de nœud.
node {
  policy = "write"
}

// La stratégie host_volume contrôle l'accès au montage et à l'accès aux volumes hôtes.
// Il prend en valeur le nom du volume
host_volume "*" {
  policy = "write"
}

// La politique de plug-in contrôle l'accès aux plug-ins CSI, comme la liste des plug-ins
// ou l'obtention de l'état du plug-in.
plugin {
  policy = "read"
}
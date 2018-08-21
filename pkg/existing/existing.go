package existing

import (
	"k8s.io/client-go/kubernetes"
	"stash.hcom/run/kube-graffiti/pkg/log"
)

const (
	componentName = "existing-checks"
	istioLabel    = "istio-injection"
)

func CheckExistingObjects(_ *kubernetes.Clientset) error {
	mylog := log.ComponentLogger(componentName, "CheckExistingObjects")
	mylog.Debug().Msg("listing namespaces")

	mylog.Warn().Msg("check existing objects has not yet been implemented")

	return nil
}

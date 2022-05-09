package collector

import (
	"sync"

	"github.com/prometheus/client_golang/prometheus"
)

var namespace = "template"

type Collector struct {
	metrics map[string]*prometheus.Desc
	mutex   sync.Mutex
}

func NewCollector() *Collector {
	return &Collector{
		metrics: map[string]*prometheus.Desc{
			"test_metric": prometheus.NewDesc(namespace+"_"+"test", "test metric", []string{"host"}, nil),
		},
	}
}

func (c *Collector) Describe(ch chan<- *prometheus.Desc) {
	for _, m := range c.metrics {
		ch <- m
	}
}

func (c *Collector) Collect(ch chan<- prometheus.Metric) {
	c.mutex.Lock()
	defer c.mutex.Unlock()

	ch <- prometheus.MustNewConstMetric(c.metrics["test_metric"], prometheus.GaugeValue, float64(1.23), "127.0.0.1")
}

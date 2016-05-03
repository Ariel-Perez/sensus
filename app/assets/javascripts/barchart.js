var MyBarChartMethods = {
    // sort a dataset

    getOrder: function(chart) {
        function arraySum(datasets){
            var total = Array();
            for(var i = 0, l0 = datasets.length; i < l0; i++)
                for(var j = 0, arg = datasets[i].data, l1 = arg.length; j < l1; j++)
                    total[j]=(total[j] || 0) + arg[j];
            return total;
        }

        var sumDataset = arraySum(chart.data.datasets);
        var dataWithIndices = sumDataset.map(
            function(value, index) {
                return {
                  value: value,
                  index: index
                }
            });

        // sort the data based on label
        dataWithIndices.sort(function (a, b) {
            if (a.value > b.value)
                return -1;
            else if (a.value < b.value)
                return 1;
            else
                return 0;
        });

        indices = dataWithIndices.map(function(element) { return element.index; });
        return indices;
    },

    applyOrder: function(chart, order) {
        chart.data.labels = order.map(function(index) { return chart.data.labels[index]; });
        chart.data.datasets.forEach(function(dataset, i) {
            dataset.data = order.map(function(index) { return dataset.data[index]; });
        });
        chart.update();
    },

    revertOrder: function(chart, order) {
        reverseOrder = order.map(function(index, i) { return order.indexOf(i); });
        chart.data.labels = reverseOrder.map(function(index) { return chart.data.labels[index]; });
        chart.data.datasets.forEach(function(dataset, i) {
            dataset.data = reverseOrder.map(function(index) { return dataset.data[index]; });
        });
        chart.update();
    },

    sort: function (chart) {
        function arraySum(datasets){
            var total = Array();
            for(var i = 0, l0 = datasets.length; i < l0; i++)
                for(var j = 0, arg = datasets[i].data, l1 = arg.length; j < l1; j++)
                    total[j]=(total[j] || 0) + arg[j];
            return total;
        }

        var sumDataset = arraySum(chart.data.datasets);
        var dataWithIndices = sumDataset.map(
            function(value, index) {
                return {
                  value: value,
                  index: index
                }
            });

        // sort the data based on label
        dataWithIndices.sort(function (a, b) {
            if (a.value > b.value)
                return -1;
            else if (a.value < b.value)
                return 1;
            else
                return 0;
        });

        chart.data.labels = dataWithIndices.map(
            function(value) {
                return chart.data.labels[value.index];
            });

        // update the chart elements using the sorted data
        chart.data.datasets.forEach(function (dataset, i) {
            dataset.data = dataWithIndices.map(
                function(value) {
                    return dataset.data[value.index];
                });
        });
        chart.update();
    },
}
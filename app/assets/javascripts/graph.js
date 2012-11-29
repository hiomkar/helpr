

function drawVisualization(graph) {
    alert("draw");
    // Create and populate the data table.
    var data = google.visualization.arrayToDataTable(graph);

    // Create and draw the visualization.
    new google.visualization.LineChart(document.getElementById('graph')).
        draw(data, {curveType: "function",
            width: 500, height: 400,
            vAxis: {maxValue: 10}}
    );
}
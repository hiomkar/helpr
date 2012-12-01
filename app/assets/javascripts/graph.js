

function drawVisualization(graph) {
    $('#reveal_graph').trigger('click');

    // Create and populate the data table.
    var data = google.visualization.arrayToDataTable(graph);

    // Create and draw the visualization.
    new google.visualization.LineChart(document.getElementById('graph')).
        draw(data, {curveType: "function",
            width: 500, height: 400,

            vAxis: {title: 'No of chats escalated', maxValue: 10},
            hAxis: {title: 'Hour in the day',
                format: '##',
                titleTextStyle: {color: '#5c5c5c'},
                titlePosition: 'out'}}
    );
}
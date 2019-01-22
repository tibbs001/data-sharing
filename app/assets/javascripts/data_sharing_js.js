$(function() {

  $("#dataSharingGrid").jsGrid({
        height: "160vh",
        width: "100%",
        filtering: true,
        inserting: false,
        editing: false,
        sorting: true,
        paging: true,
        autoload: true,
        noDataContent: "...Loading...",
        searchButtonTooltip: "Search",
        clearFilterButtonTooltip: "Clear filter",
        pageSize: 40,
        controller: {
            loadData: function(filter) {
                return $.ajax({
                    type: "GET",
                    url: "/data_sharing",
                    data: filter
                });
            }
        },
        fields: [
            { name: 'dataset',                type: "text", width: 70 },
            { name: 'study_type',             type: "text", width: 30 },
            { name: 'therapeuitic_area',      type: "text", width: 80 },
            { name: 'enrollment',             type: "text", width: 40 },
            { name: 'population',             type: "text", width: 40 },
            { name: 'phase',                  type: "text", width: 20 },
            { name: 'data_availability',      type: "text", width: 40 },
            { name: 'faculty_name',           type: "text", width: 80 },
            { name: 'affiliation',            type: "text", width: 80 },
        ]
    });
});

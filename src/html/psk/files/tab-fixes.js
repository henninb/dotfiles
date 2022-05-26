$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    var target = this.href.split('#');
    $('.nav a').filter('[href="#'+target[1]+'"]').tab('show');
})

$(document).ready(function () {
    $("#profilelink").click(function () {
        $('.nav a[href="#13"]').tab('show');           
    });
});
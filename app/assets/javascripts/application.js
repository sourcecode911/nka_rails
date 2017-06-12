// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require_tree .

function httpGet(url, callback) {
    $.getJSON(url, function(resp) {
        if(callback) {#
            callback(resp);
        }
    });
}

function httpPost(url, data, callback) {
    $.ajax({
        url: url,
        type: 'POST',
        data: data,
        success: function(resp) {
            if(callback) {
                console.log('success');
                callback(resp);
            }
        }
    })
}

function httpPut(url, data, callback) {
    $.ajax({
        url: url,
        type: 'PUT',
        data: data,
        success: function(resp) {
            if(callback) {
                callback(resp);
            }
        }
    })
}
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
            
$.widget('custom.mcautocomplete_loc', $.ui.autocomplete, {
    _create: function () {
        this._super();
        this.widget().menu("option", "items", "> :not(.ui-widget-header)");
    },
    _renderMenu: function (ul, items) {
        var self = this, thead;
        if (this.options.showHeader) {
            table = $('<div class="ui-widget-header" style="width:100%"></div>');
            $.each(this.options.columns, function (index, item) {
                table.append('<span style="padding:0 1px;float:left;width:' + item.width + ';">' + item.name + '</span>');
            });
            table.append('<div style="clear: both;"></div>');
            ul.append(table);
        }
        $.each(items, function (index, item) {
            self._renderItem(ul, item);
        });
    },
    _renderItem: function (ul, item) {
        var t = '', result = '';
        $.each(this.options.columns, function (index, column) {
            t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>'
        });
        result = $('<li></li>')
            .data('ui-autocomplete-item', item)
            .append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
            .appendTo(ul);
        return result;
    }
});
$("#ProvLoc").mcautocomplete_loc({
    showHeader: true, delay: 100,
    columns: [{ name: 'Localidad', width: '220px', valueField: 'name' },
              { name: 'Pertenencia', width: '420px', valueField: 'parents_txt'},
              //{ name: 'Nivel', width: '140px', valueField: 'level' },
              { name: 'Similitud', width: '40px', valueField: 'tg' }],
    // Evento de selección
    select: function (event, ui) {
        this.value = (ui.item ? ui.item.name + ', ' + ui.item.parents_txt : '');
        var tmp = '';
        if (ui.item) {
            $('#localidad_osm').val(ui.item.osm_id);
            tmp += ui.item.name + ' (' + ui.item.level + '):' + ui.item.osm_id + '</br>';
            tmp += ui.item.parents_txt + ' (' + ui.item.parents_ids + ')</br>';
        }  else { tmp += 'No se encontraron resultados para ' + this.value; };
        $('#results_loc').html(tmp);
        return false;
    },
    minLength: 3,
    source: function (request, response) {
        $.ajax({
            url: 'http://gte003.dosalinfinito.com.ar/geo/admin_levels',
            dataType: 'json',
            data: { text: request.term, how_much: 10, app_key: 'dai' },
            success: function (data) {
                var result;
                if (!data || data.length === 0) {
                    result = [{ label: 'Sin resultados.' }];
                } else { result = data; }
                response(result);
            }
        });
    }
});

$.widget('custom.mcautocomplete_street', $.ui.autocomplete, {
    _create: function () {
        this._super();
        this.widget().menu("option", "items", "> :not(.ui-widget-header)");
    },
    _renderMenu: function (ul, items) {
        var self = this, thead;
        if (this.options.showHeader) {
            table = $('<div class="ui-widget-header" style="width:100%"></div>');
            $.each(this.options.columns, function (index, item) {
                table.append('<span style="padding:0 1px;float:left;width:' + item.width + ';">' + item.name + '</span>');
            });
            table.append('<div style="clear: both;"></div>');
            ul.append(table);
        }
        $.each(items, function (index, item) {
            self._renderItem(ul, item);
        });
    },
    _renderItem: function (ul, item) {
        var t = '', result = '';
        $.each(this.options.columns, function (index, column) {
            t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>';
        });
        result = $('<li></li>')
            .data('ui-autocomplete-item', item)
            .append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
            .appendTo(ul);
        return result;
    }
});
$("#CalleNum").mcautocomplete_street({
    showHeader: true, delay: 100,
    columns: [{ name: 'Calle', width: '220px', valueField: 'name' }, 
              { name: 'Pertenencia', width: '420px', valueField: 'parents_txt' },
              { name: 'Similitud', width: '40px', valueField: 'tg'}],
    // Evento de selección
    select: function (event, ui) {
        this.value = (ui.item ? ui.item.name : '');
        var tmp = '';
        if (ui.item) {
            $('#calle_osm').val(ui.item.osm_id);
            tmp += ui.item.name + ': ' + ui.item.osm_id + '</br>';
            tmp += ui.item.parents_txt + '</br>';
        }  else { tmp += 'No se encontraron resultados para ' + this.value; };
        $('#results_street').html(tmp);
        return false;
    },
    minLength: 3,
    source: function (request, response) {
        $.ajax({
            url: 'http://gte003.dosalinfinito.com.ar/geo/streets',
            dataType: 'json',
            data: { text: request.term, how_much: 10, app_key: 'dai', parent_osm_id: $('#localidad_osm').val() },
            success: function (data) {
                var result;
                if (!data || data.length === 0) {
                    result = [{ label: 'Sin resultados.' }];
                } else { result = data; }
                response(result);
            }
        });
    }
});

$.widget('custom.mcautocomplete_intersection', $.ui.autocomplete, {
    _create: function () {
        this._super();
        this.widget().menu("option", "items", "> :not(.ui-widget-header)");
    },
    _renderMenu: function (ul, items) {
        var self = this, thead;
        if (this.options.showHeader) {
            table = $('<div class="ui-widget-header" style="width:100%"></div>');
            $.each(this.options.columns, function (index, item) {
                table.append('<span style="padding:0 1px;float:left;width:' + item.width + ';">' + item.name + '</span>');
            });
            table.append('<div style="clear: both;"></div>');
            ul.append(table);
        }
        $.each(items, function (index, item) {
            self._renderItem(ul, item);
        });
    },
    _renderItem: function (ul, item) {
        var t = '', result = '';
        $.each(this.options.columns, function (index, column) {
            t += '<span style="padding:0 4px;float:left;width:' + column.width + ';">' + item[column.valueField ? column.valueField : index] + '</span>'
        });
        result = $('<li></li>')
            .data('ui-autocomplete-item', item)
            .append('<a class="mcacAnchor">' + t + '<div style="clear: both;"></div></a>')
            .appendTo(ul);
        return result;
    }
});

$("#EntreCalleNum").mcautocomplete_intersection({
    showHeader: true, delay: 100,
    columns: [{ name: 'Calle', width: '220px', valueField: 'number' } , { width: '420px', valueField: 'name' } ], // ,{ name: 'ID_1',  width: '420px', valueField: 'street1_osm_id' },// { name: 'ID_2',  width: '420px', valueField: 'street2_osm_id' } ],
    // Evento de selección
    select: function (event, ui) {
        this.value = (ui.item ? ui.item.name : '');
        var tmp = '';
        if (ui.item) {
            $('#intersection').val(ui.item.name);
            $('#intersection_street1_housenumber').val(ui.item.number);
            $('#intersection_street1_osm_id').val(ui.item.street1_osm_id);
            $('#intersection_street2_osm_id').val(ui.item.street2_osm_id);
            tmp += ui.item.name + ': ' + ui.item.street1_osm_id + '</br>';
            //L.marker([ui.item.lat, ui.item.lon]).addTo(map).bindPopup('Cruce de ' + $('#street').val() + ' y ' + $('#intersection').val()).openPopup();
        }  else { tmp += 'No se encontraron resultados para ' + this.value; };
        $('#results_intersection').html(tmp);
        return false;
    },
    minLength: 3, //Sugerido 0
    source: function (request, response) {
        $.ajax({
            url: 'http://gte003.dosalinfinito.com.ar/geo/intersections',
            dataType: 'json',
            data: { text: request.term, how_much: 10, app_key: 'dai', parent_osm_id: $('#localidad_osm').val(), name: $('#CalleNum').val() },
            success: function (data) {
                var result;
                if (!data || data.length === 0) {
                    result = [{ label: 'Sin resultados.' }];
                } else { result = data; }
                response(result);
            }
        }); 
    }
});
            
            
            $('#form input').keydown(function(e) {
                if (e.keyCode == 13) {
                    $('#form').submit();
                }
            });

// datos destino:
            $("#ProvLocDest").mcautocomplete_loc({
                showHeader: true, delay: 100,
                columns: [{ name: 'Localidad', width: '220px', valueField: 'name' },
                          { name: 'Pertenencia', width: '420px', valueField: 'parents_txt'},
                          //{ name: 'Nivel', width: '140px', valueField: 'level' },
                          { name: 'Similitud', width: '40px', valueField: 'tg' }],
                // Evento de selección
                select: function (event, ui) {
                    this.value = (ui.item ? ui.item.name + ', ' + ui.item.parents_txt : '');
                    var tmp = '';
                    if (ui.item) {
                        $('#localidad_osm_dest').val(ui.item.osm_id);
                        tmp += ui.item.name + ' (' + ui.item.level + '):' + ui.item.osm_id + '</br>';
                        tmp += ui.item.parents_txt + ' (' + ui.item.parents_ids + ')</br>';
                    }  else { tmp += 'No se encontraron resultados para ' + this.value; };
                    $('#results_loc_dest').html(tmp);
                    return false;
                },
                minLength: 3,
                source: function (request, response) {
                    $.ajax({
                        url: '<%=Geolocalizacion.PROVINCIA_ENDPOINT%>',
                        dataType: 'json',
                        data: { text: request.term, how_much: 10, app_key: 'dai' },
                        success: function (data) {
                            var result;
                            if (!data || data.length === 0) {
                                result = [{ label: 'Sin resultados.' }];
                            } else { result = data; }
                            response(result);
                        }
                    });
                }
            });

            $("#CalleNumDest").mcautocomplete_street({
                showHeader: true, delay: 100,
                columns: [{ name: 'Calle', width: '220px', valueField: 'name' }, 
                          { name: 'Pertenencia', width: '420px', valueField: 'parents_txt' },
                          { name: 'Similitud', width: '40px', valueField: 'tg'}],
                // Evento de selección
                select: function (event, ui) {
                    this.value = (ui.item ? ui.item.name : '');
                    var tmp = '';
                    if (ui.item) {
                        $('#calle_osm_dest').val(ui.item.osm_id);
                        tmp += ui.item.name + ': ' + ui.item.osm_id + '</br>';
                        tmp += ui.item.parents_txt + '</br>';
                    }  else { tmp += 'No se encontraron resultados para ' + this.value; };
                    $('#results_street').html(tmp);
                    return false;
                },
                minLength: 3,
                source: function (request, response) {
                    $.ajax({
                        url: '<%=Geolocalizacion.CALLE_ENDPOINT%>',
                        dataType: 'json',
                        data: { text: request.term, how_much: 10, app_key: 'dai', parent_osm_id: $('#localidad_osm_dest').val() },
                        success: function (data) {
                            var result;
                            if (!data || data.length === 0) {
                                result = [{ label: 'Sin resultados.' }];
                            } else { result = data; }
                            response(result);
                        }
                    });
                }
            });

            $("#EntreCalleNumDest").mcautocomplete_intersection({
                showHeader: true, delay: 100,
                columns: [{ name: 'Calle', width: '220px', valueField: 'number' } , { width: '420px', valueField: 'name' } ], // ,{ name: 'ID_1',  width: '420px', valueField: 'street1_osm_id' },// { name: 'ID_2',  width: '420px', valueField: 'street2_osm_id' } ],
                // Evento de selección
                select: function (event, ui) {
                    this.value = (ui.item ? ui.item.name : '');
                    var tmp = '';
                    if (ui.item) {
                        $('#intersection').val(ui.item.name);
                        $('#intersection_street1_housenumber').val(ui.item.number);
                        $('#intersection_street1_osm_id').val(ui.item.street1_osm_id);
                        $('#intersection_street2_osm_id').val(ui.item.street2_osm_id);
                        tmp += ui.item.name + ': ' + ui.item.street1_osm_id + '</br>';
                        //L.marker([ui.item.lat, ui.item.lon]).addTo(map).bindPopup('Cruce de ' + $('#street').val() + ' y ' + $('#intersection').val()).openPopup();
                    }  else {
                        tmp += 'No se encontraron resultados para ' + this.value;
                    };
                    $('#results_intersection').html(tmp);
                    return false;
                },
                minLength: 3, //Sugerido 0
                source: function (request, response) {
                    $.ajax({
                        url: '<%=Geolocalizacion.ENTRECALLE_ENDPOINT%>',
                        dataType: 'json',
                        data: { text: request.term, how_much: 10, app_key: 'dai', parent_osm_id: $('#localidad_osm_dest').val(), name: $('#CalleNumDest').val() },
                        success: function (data) {
                            console.log(data);
                            var result;
                            if (!data || data.length === 0) {
                                result = [{
                                    label: 'Sin resultados.'
                                }];
                            } else {
                                result = data;
                            }
                            response(result);
                        }
                    });
                }
            });

       
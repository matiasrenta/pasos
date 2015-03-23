// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



$(document).ready(function() {
  docReady();
})

$(document).bind('beforeReveal.facebox', function() {
    var height = $(window).height() - 100;
    $('#facebox .content').css('height', height + 'px');
    $('#facebox').css('top', ($(window).scrollTop() + 10) + 'px');
});

//para agregar el multi_select_no_filter en un nested form
$(document).on('nested:fieldAdded', function(event){
  var myArray = $('.multi_select_no_filter_nested');
  var element = myArray[myArray.length - 1];
  $(element).multiselect({
         header: false,
         selectedText: "No más de 3 por favor",
         noneSelectedText: '',
         selectedList: 3
     });

  var field = event.field;
  var moneyFields = field.find('.money');
  moneyFields.maskMoney({thousands:',', decimal:'.'});
  moneyFields.each(function() {
      if ($(this).val() == "0.00") {
          $(this).val("");
      }

      if ($(this).val().length > 0) {
          $(this).mask();
      }
  });
});

//para agregar el datepicker en un nested form
$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  // it's a jQuery object already! Now you can find date input
  var dateField = field.find('.datepicker');
  // and activate datepicker on it
  dateField.dateMask({separator:'/', format:'dmy', minYear:1900, maxYear:2030});
  dateField.datepicker($.datepicker.regional['es']);

  var datetimeField = field.find('.datetimepicker');
  datetimeField.datetimepicker({timeText: "", hourText: "Hora", showMinute: false, closeText: "Aceptar", currentText: "Hoy"});
});

//para agregar el ajax_dropdown en un nested form
$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  // it's a jQuery object already! Now you can find date input
  var dropdown_field = field.find('.ajax_dropdown');
  // and activate datepicker on it
  dropdown_field.change(function() {
            $('input[type=submit]').attr('disabled', true);
            var params_string = $('#' + this.id).data('parameter');
            if (params_string == undefined){
                params_string = this.id // si no existe data-parameter porque no lo setee en el html, pues por defecto usa el id de this
            }
            var paramsToRetrieve = params_string.split(',');
            //$('#' + this.id).data("parameter") === this.id;
            var obj = {};
            for (var i = 0; i < paramsToRetrieve.length; i++){
                var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
                obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
                obj["the_id"] = $(paramSelector).val(); // solo por conveniencia algunas veces puede ser mejor desde rails obtener un id desde este param llamado "the_id", solo funciona para uno solo no para varios ids
                obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos
            }

            $.ajax({url: this.getAttribute("data-url"),
                data: obj,
                dataType: 'script'})
        });

  // lo mismo que la de arriba con .ajax_dropdown, pero esta es para checkbox, solo cambia cuando asigna "obj["is_checked"] = xxxxxxx". Debería solo mejorar la funcion anterior preguntando que si el elemento es un checkbox entonces setear este parametro
  var checkbox_field = field.find('.ajax_checkbox');
    checkbox_field.change(function() {
            var params_string = $('#' + this.id).data('parameter');
            if (params_string == undefined){
                params_string = this.id
            }

            var paramsToRetrieve = params_string.split(',');
            var obj = {};
            for (var i = 0; i < paramsToRetrieve.length; i++){
                var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
                obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
                obj["is_checked"] = $("#" + this.id).attr('checked') ? "1" : "0"
                obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos
            }

            $.ajax({url: this.getAttribute("data-url"),
                data: obj,
                dataType: 'script'})
    });
});

//para cambiar los gramajes en el momento de agregar un tanto en el formulario de prensa plana y de continua (nested_form)
$(document).on('nested:fieldAdded', function(event){
  // this field was just inserted into your form
  var field = event.field;
  // it's a jQuery object already! Now you can find date input
  var gramajeField = field.find('.change-with-paper');
  if (gramajeField.html() != null){
      var u = "";
      if($("#quotation_press_type_id").val() == "1"){
          u = "/quotations/ajax_get_gramajes?the_id=" + $("#quotation_quotation_flat_attributes_paper_id").val() + "&from_tantos=true&the_this_html_id=quotation_flat";
      }else{
          u = "/quotations/ajax_get_gramajes?the_id=" + $("#quotation_quotation_flat_attributes_paper_id").val() + "&from_tantos=true&the_this_html_id=quotation_continue";
      }
      $.get(u, function(data) {
        gramajeField.html(data);
      });
  }
});


//esta funcion la ejecuto cuando "domcument ready" (arriba), la tengo dentro de esta named function porque cuando
//ejecuto un ajax debo llamar desde ese ajax a esta named function para simuar el "document ready"
function docReady(){

    // para desabilitar todos los submit button onclick
    $("input[type='submit']").not($('#search_clear')).click(function(){
        $(this).attr("disabled", true);
    });
    $("button[type='submit']").not($('#search_clear')).click(function(){
        $(this).attr("disabled", true);
    });

    // esto se tiene que ejecutar antes que el .multiselect, ya que le estoy quitando la clase antes para ponerle la "nested" así la funcion multiselect se ejecuta cuando
    // se agrega el renglón del form, y para cuando es updating? los renglones que ya estan creados tienen la clase "multi_select_no_filter" y no la "nested"
    $("#patient_therapies_attributes_new_therapist_schedule_ids").removeClass("multi_select_no_filter").addClass("multi_select_no_filter_nested");

    $(".on_blur_ajax").blur(function() {
        if(this.value.length > 0 && $("#" + this.getAttribute("data_start_date_id")).val().length > 0 ){
            $.post("/tasks/ajax_display_planned_end_date", $("#" + this.getAttribute("data_form_id")).serialize(), null, "script");
            return false;
        }
    });

    $(".input_text_on_blur_ajax").blur(function() {
        if(this.value.length > 0 && $("#" + this.getAttribute("data_start_date_id")).val().length > 0 ){
            $.post("/tasks/ajax_display_planned_end_date", $("#" + this.getAttribute("data_form_id")).serialize(), null, "script");
            return false;
        }
    });

    //este par de funciones son para hacer que un form se submita con ajax, al form hay que ponerle class="submit_with_ajax"
    jQuery.fn.submitWithAjax = function() {
      this.submit(function() {
        $.post(this.action, $(this).serialize(), null, "script");
        return false;
      })
      return this;
    };
    $(document).ready(function() {
      $(".submit_with_ajax").submitWithAjax();
    })


    // ajax para cuando cambia un dropdown haga algo. Ej: cargar otro dropdown segun el valor de este dropdown, u otra cosa.
    // se le puede enviar mas de un field del formulario para que envíe al servidor, el query string lleva los nombres de los
    // parámetros igual al atributo "name" del form field, EJ: ?recibo_entrega[cliente_id]&recibo_entrega[vendedore_id]
    // el data-parameter que debe llevar el form field debe contener un string con los IDs de estos form fields separados por comas
    // Ejemplo completo:
    //<select class="ajax_dropdown" data-parameter="recibo_entrega_cliente_id, recibo_entrega_vendedore_id" data-url="ajax_get_nro_series_transformadores" id="recibo_entrega_vendedore_id" name="recibo_entrega[vendedore_id]">
    //                <option value="">Seleccione uno:</option>
    //                <option value="1">FELIPE SANGABRIEL DE BAEZ</option>
    //                <option value="2">ROLANDO SANGABRIEL GERONIMO</option>
    // </select>
    jQuery(document).ready(function($) {
        $(".ajax_dropdown").change(function() {
            $('input[type=submit]').attr('disabled', true);
            var params_string = $('#' + this.id).data('parameter');
            if (params_string == undefined){
                params_string = this.id
            }
            var paramsToRetrieve = params_string.split(',');

            //$('#' + this.id).data("parameter") === this.id;


            var obj = {};
            for (var i = 0; i < paramsToRetrieve.length; i++){
                var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
                obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
                obj["the_id"] = $(paramSelector).val(); // solo por conveniencia algunas veces puede ser mejor desde rails obtener un id desde este param llamado "the_id", solo funciona para uno solo no para varios ids
                obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos
            }

            $.ajax({url: this.getAttribute("data-url"),
                data: obj,
                dataType: 'script'})
        });
    });

    jQuery(document).ready(function($) {
        $(".ajax_onblur_input_text").blur(function() {
            $('input[type=submit]').attr('disabled', true);
            var params_string = $('#' + this.id).data('parameter');
            if (params_string == undefined){
                params_string = this.id
            }
            var paramsToRetrieve = params_string.split(',');
            var obj = {};
            for (var i = 0; i < paramsToRetrieve.length; i++){
                var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
                obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
                obj["the_id"] = $(paramSelector).val(); // solo por conveniencia algunas veces puede ser mejor desde rails obtener un id desde este param llamado "the_id", solo funciona para uno solo no para varios ids
                obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos
            }

            $.ajax({url: this.getAttribute("data-url"),
                data: obj,
                dataType: 'script'})
        });
    });


    // lo mismo que la de arriba con .ajax_dropdown, pero esta es para checkbox, solo cambia cuando asigna "obj["is_checked"] = xxxxxxx". Debería solo mejorar la funcion anterior preguntando que si el elemento es un checkbox entonces setear este parametro
    jQuery(document).ready(function($) {
        $(".ajax_checkbox").change(function() {
            var params_string = $('#' + this.id).data('parameter');
            if (params_string == undefined){
                params_string = this.id
            }

            var paramsToRetrieve = params_string.split(',');
            var obj = {};
            for (var i = 0; i < paramsToRetrieve.length; i++){
                var paramSelector = "#" + $.trim(paramsToRetrieve[i]);
                obj[$(paramSelector).attr('name')] = $(paramSelector).val(); // aqui pongo como debe de ser el nombre del parametro
                obj["is_checked"] = $("#" + this.id).attr('checked') ? "1" : "0"
                obj["the_this_html_id"] = this.id; // para lo que es nested form necesito el id de quien dispara el ajax, con ese id puedo conseguir los ids de los otros campos hermanos
            }

            $.ajax({url: this.getAttribute("data-url"),
                data: obj,
                dataType: 'script'})
        });
    });



    $(".datepicker").dateMask({separator:'/', format:'dmy', minYear:1900, maxYear:2030});
    $(".datepicker").datepicker($.datepicker.regional['es']);
    $(".datetimepicker").datetimepicker({timeText: "", hourText: "Hora", showMinute: false, closeText: "Aceptar", currentText: "Hoy"});



    jQuery(function() {
        $(".money").maskMoney({thousands:',', decimal:'.'});

        $('.money').each(function() {
            if ($(this).val() == "0.00") {
                $(this).val("");
            }

            if ($(this).val().length > 0) {
                $(this).mask();
            }
        });
    });


    $("a.trigger").click(function() {
        $("div.toggle_container").slideToggle("slow");
        return false; //Prevent the browser jump to the link anchor
    });

    $("a.toggle_div").click(function() {
        if ($(this).text() == '(-) ' + this.getAttribute("data-link_text") )
            $(this).text('(+) ' + this.getAttribute("data-link_text"));
        else
          if($(this).text() == '(+) ' + this.getAttribute("data-link_text") )
            $(this).text('(-) ' + this.getAttribute("data-link_text"));

        $("#" + this.getAttribute("data-div_to_toggle")).slideToggle("slow");
        return false; //Prevent the browser jump to the link anchor
    });

    $("a.toggle_tr").click(function() {
        if ($(this).text() == '(-) ' + this.getAttribute("data-link_text") )
            $(this).text('(+) ' + this.getAttribute("data-link_text"));
        else
            $(this).text('(-) ' + this.getAttribute("data-link_text"));

        $("tr." + this.getAttribute("data-class_tr_to_toggle")).toggle();
        return false; //Prevent the browser jump to the link anchor
    });


    $('a[rel*=facebox]').facebox();


    $(".multi_select_filter")
            .multiselect({
                             selectedText: "# de # listados",
                             noneSelectedText: '',
                             selectedList: 1000
                         })
            .multiselectfilter();

    $(".multi_select_no_filter")
            .multiselect({
                             header: false,
                             selectedText: "No más de 3 por favor",
                             noneSelectedText: '',
                             selectedList: 3
                         });

    $(".one_select_filter")
            .multiselect({
                             selectedList: 1,
                             noneSelectedText: '',
                             multiple: false
                         })
            .multiselectfilter();

    $(".plus_chart").button({icons: {primary:'ui-icon-plus'}});
    $(".one_to_one_chart").button({icons: {primary:'ui-icon-arrow-4-diag'}});
    $(".minus_chart").button({icons: {primary:'ui-icon-minus'}});

}



/*
 $(document).bind('afterClose.facebox', function() {
 var h = document.getElementById("myhidden").value;
 document.getElementById("firstHidden").value = h;
 })
 */



//funcion para serializar los forms del filtro y del select del paginador
function mergeForms(trigger_form) {
    var forms = [];
    forms[0] = document.getElementById(trigger_form);
    forms[1] = document.forms["filter_form"];
    var targetForm = forms[0];
    $.each(forms, function(i, f) {
        if (i != 0) {
            $(f).find('input, select, textarea')
                    .hide()
                    .appendTo($(targetForm));
        }
    });
    $(targetForm).submit();
}




function toggle_index_child(id) {
    $('#' + id).slideToggle("slow");
    //return false; lo tuve que poner en la llamada a esta funcion, sino el bnavegador iba al anchor igualmente
}



// ##############  PRUEBAS ###############

$(function($) {
    $("#xx").change(function() {
        $.ajax({url: '/ajaxtests/fill_phases',
            data: 'ajaxtest[life_cycle_id]=' + this.value + '&message=' + this.getAttribute("data-message"),
            dataType: 'script'})
    });
});




/*
 jQuery(function($) {
 $("#projects_users_join_user_id").wrap('<div id="users_select" style="float:left" />');
 });

 jQuery(function($) {
 // when the #projects_users_join_project field changes
 $("#projects_users_join_project_id").change(function() {
 // make a POST call and replace the content
 var project = $('select#projects_users_join_project_id :selected').val();
 if(project == "") project="0";
 jQuery.get('/projects_users_joins/update_user_select/' + project, function(data){
 $("#users_select").html(data);
 })
 return false;
 });

 });*/

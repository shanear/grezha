window.Daughters ||= {}

class Daughters.Contacts extends Daughters.Base
  constructor: () ->
    super
    this

  index: () ->
    # Make birthday select change the month viewed
    jQuery ->
      $("select#birthday_month").change ->
        month = $("select#birthday_month").val()
        window.location = "contacts?birthday_month=#{month}"

  new: () ->
    form.call(this)

  edit: () ->
    form.call(this)

  form = () ->
    # Functionality for the unknown birthday checkbox
    $unknown_birthday = $("input[type='checkbox']#birthday_unknown")
    $birthday_fields = $("#birthday-fields select, #birthday-fields input")
    $unknown_birthday_field = $("#unknown-birthday-field")

    update_birthday = ->
      if $unknown_birthday.is(':checked')
        $birthday_fields.hide()
        $birthday_fields.attr('disabled', 'disabled')
        $unknown_birthday_field.removeAttr('disabled')
      else
        $birthday_fields.removeAttr('disabled')
        $unknown_birthday_field.attr('disabled', 'disabled')
        $birthday_fields.show()

    update_birthday()
    $unknown_birthday.change(update_birthday)

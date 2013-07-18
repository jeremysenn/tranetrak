# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  

  ### START BODYCOMP TAB ###

  if $('#bodycomp-donut').length
    Morris.Donut
      element: 'bodycomp-donut'
      data: $('#bodycomp-donut').data('bodycomp')

  if $('#bodycomp-percent-donut').length
    bfpercent_donut=Morris.Donut
      element: 'bodycomp-percent-donut'
      data: $('#bodycomp-percent-donut').data('bodycomp')
    bfpercent_donut.select(0)

  if $('#bodycomp_comparison').length
    Morris.Line
      element: 'bodycomp_comparison'
      data: $('#bodycomp_comparison').data('bodycomps')
      xkey: 'date'
      ykeys: ['weight', 'leanmass', 'fatmass']
      labels: ['Weight', 'Lean Mass', 'Fat Mass']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#percent-bodyfat').length
    Morris.Line
      element: 'percent-bodyfat'
      data: $('#percent-bodyfat').data('bodycomps')
      xkey: 'date'
      ykeys: ['bodyfat']
      labels: ['Percent Body Fat']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#percent-bodyfat-and-bmi').length
    Morris.Line
      element: 'percent-bodyfat-and-bmi'
      data: $('#percent-bodyfat-and-bmi').data('bodycomps')
      xkey: 'date'
      ykeys: ['bodyfat','bmi']
      labels: ['Body Fat Percent', 'BMI']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#bodyweight').length
    Morris.Line
      element: 'bodyweight'
      data: $('#bodyweight').data('bodycomps')
      xkey: 'date'
      ykeys: ['weight']
      labels: ['Body Weight']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#leanmass').length
    Morris.Line
      element: 'leanmass'
      data: $('#leanmass').data('bodycomps')
      xkey: 'date'
      ykeys: ['leanmass']
      labels: ['Lean Mass']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#fatmass').length
    Morris.Line
      element: 'fatmass'
      data: $('#fatmass').data('bodycomps')
      xkey: 'date'
      ykeys: ['fatmass']
      labels: ['Fat Mass']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#metabolic_rate').length
    Morris.Line
      element: 'metabolic_rate'
      data: $('#metabolic_rate').data('bodycomps')
      xkey: 'date'
      ykeys: ['metabolic_rate']
      labels: ['Basal Metabolic Rate (calories)']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#bmi').length
    Morris.Line
      element: 'bmi'
      data: $('#bmi').data('bodycomps')
      xkey: 'date'
      ykeys: ['bmi']
      labels: ['BMI']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#whr').length
    Morris.Line
      element: 'whr'
      data: $('#whr').data('bodycomps')
      xkey: 'date'
      ykeys: ['whr']
      labels: ['WHR']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  ### END BODYCOMP TAB ###

  ### START SKINFOLD TAB ###

  if $('#all_skinfolds').length
    Morris.Line
      element: 'all_skinfolds'
      data: $('#all_skinfolds').data('bodycomps')
      xkey: 'date'
      ykeys: ['pec','tri','subscap','suprailiac','midaxil','umbilical','quad']
      labels: ['Chest', 'Triceps', 'Subscapular', 'Suprailiac', 'Midaxillary', 'Abdominal', 'Thigh']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      hideHover: 'auto'

  if $('#all_girths').length
    Morris.Line
      element: 'all_girths'
      data: $('#all_girths').data('bodycomps')
      xkey: 'date'
      ykeys: ['waist','hip','neck','shoulder','chest','arm','thigh','gastroc']
      labels: ['Waist', 'Hip', 'Neck', 'Shoulder', 'Chest', 'Arm', 'Thigh', 'Calf']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      hideHover: 'auto'

  if $('#chest_skinfold').length
    Morris.Line
      element: 'chest_skinfold'
      data: $('#chest_skinfold').data('bodycomps')
      xkey: 'date'
      ykeys: ['pec']
      labels: ['Chest']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#tri').length
    Morris.Line
      element: 'tri'
      data: $('#tri').data('bodycomps')
      xkey: 'date'
      ykeys: ['tri']
      labels: ['Triceps']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#subscap').length
    Morris.Line
      element: 'subscap'
      data: $('#subscap').data('bodycomps')
      xkey: 'date'
      ykeys: ['subscap']
      labels: ['Subscapular']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#supra').length
    Morris.Line
      element: 'supra'
      data: $('#supra').data('bodycomps')
      xkey: 'date'
      ykeys: ['suprailiac']
      labels: ['Suprailiac']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#midaxil').length
    Morris.Line
      element: 'midaxil'
      data: $('#midaxil').data('bodycomps')
      xkey: 'date'
      ykeys: ['midaxil']
      labels: ['Midaxillary']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#ab').length
    Morris.Line
      element: 'ab'
      data: $('#ab').data('bodycomps')
      xkey: 'date'
      ykeys: ['umbilical']
      labels: ['Abdominal']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#thigh_skinfold').length
    Morris.Line
      element: 'thigh_skinfold'
      data: $('#thigh_skinfold').data('bodycomps')
      xkey: 'date'
      ykeys: ['quad']
      labels: ['Thigh']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#calf_skinfold').length
    Morris.Line
      element: 'calf_skinfold'
      data: $('#calf_skinfold').data('bodycomps')
      xkey: 'date'
      ykeys: ['calf']
      labels: ['Calf']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  ### END SKINFOLD TAB ###

  ### START GIRTH TAB ###

  if $('#waist').length
    Morris.Line
      element: 'waist'
      data: $('#waist').data('bodycomps')
      xkey: 'date'
      ykeys: ['waist']
      labels: ['Waist']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#hip').length
    Morris.Line
      element: 'hip'
      data: $('#hip').data('bodycomps')
      xkey: 'date'
      ykeys: ['hip']
      labels: ['Hip']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#neck').length
    Morris.Line
      element: 'neck'
      data: $('#neck').data('bodycomps')
      xkey: 'date'
      ykeys: ['neck']
      labels: ['Neck']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#shoulder').length
    Morris.Line
      element: 'shoulder'
      data: $('#shoulder').data('bodycomps')
      xkey: 'date'
      ykeys: ['shoulder']
      labels: ['Shoulders']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#chest_girth').length
    Morris.Line
      element: 'chest_girth'
      data: $('#chest_girth').data('bodycomps')
      xkey: 'date'
      ykeys: ['chest']
      labels: ['Chest']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#arm').length
    Morris.Line
      element: 'arm'
      data: $('#arm').data('bodycomps')
      xkey: 'date'
      ykeys: ['arm']
      labels: ['Arm']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#thigh_girth').length
    Morris.Line
      element: 'thigh_girth'
      data: $('#thigh_girth').data('bodycomps')
      xkey: 'date'
      ykeys: ['thigh']
      labels: ['Thigh']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  if $('#calf_girth').length
    Morris.Line
      element: 'calf_girth'
      data: $('#calf_girth').data('bodycomps')
      xkey: 'date'
      ykeys: ['gastroc']
      labels: ['Calf']
      dateFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()
      xLabelFormat:
        (date) ->
          d = new Date(date)
          (d.getMonth()+1) + '/' + d.getDate() + '/' + d.getFullYear()

  ### END GIRTH TAB ###

  ### KEEP CURRENT TAB ACTIVE AFTER PAGE RELOAD ###
  #$("a[data-toggle=\"tab\"]").on "shown", (e) ->
  #  #save the latest tab using a cookie:
  #  $.cookie "last_tab", $(e.target).attr("href")

  #Activate latest tab, if it exists:
  #lastTab = $.cookie("last_tab")
  #if lastTab
  #  $("ul.nav-tabs").children().removeClass "active"
  #  $("a[href=" + lastTab + "]").parents("li:first").addClass "active"
  #  $("div.tab-content").children().removeClass "active"
  #  $(lastTab).addClass "active"
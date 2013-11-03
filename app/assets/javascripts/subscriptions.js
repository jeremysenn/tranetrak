var subscription;

jQuery(function() {
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));
  return subscription.setupForm();
});

subscription = {
  setupForm: function() {
    return $('.card_form').submit(function() {
      $('input[type=submit]').attr('disabled', true);
      if ($('#card_number').length) {
        subscription.processCard();
        return false;
      } else {
        return true;
      }
    });
  },
  processCard: function() {
    var card;
    card = {
      name: $('#card_name').val(),
      number: $('#card_number').val(),
      cvc: $('#card_code').val(),
      expMonth: $('#card_month').val(),
      expYear: $('#card_year').val()
    };
    return Stripe.createToken(card, subscription.handleStripeResponse);
  },
  handleStripeResponse: function(status, response) {
    if (status === 200) {
      $('#subscription_stripe_card_token').val(response.id);
      return $('.card_form')[0].submit();
    } else {
      $('#stripe_error').text(response.error.message).show();
      return $('input[type=submit]').attr('disabled', false);
    }
  }
};
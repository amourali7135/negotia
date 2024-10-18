class NegotiationMailer < ApplicationMailer
  def invitation(negotiation)
    @negotiation = negotiation
    @user1 = negotiation.user1
    @user2_email = negotiation.user2_email
    @registration_link = new_user_registration_url(invitation_token: encode_token(negotiation))

    mail(to: @user2_email, subject: 'You have been invited to a negotiation')
  end

  private

  def encode_token(negotiation)
    # Use a secure method to encode the negotiation ID
    Base64.urlsafe_encode64(negotiation.id.to_s)
  end
end

# class NegotiationMailer < ApplicationMailer
#   def invitation(negotiation_id)
#     @negotiation = Negotiation.find(negotiation_id)
#     @inviter = @negotiation.user1
#     @invitee_email = @negotiation.user2_email

#     mail(
#       to: @invitee_email,
#       subject: "You've been invited to a negotiation by #{@inviter.name}"
#     )
#   end
# end

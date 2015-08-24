class Api::MemberProfileTypesController < ApplicationController
    def index
      render json: MemberProfile.membership_typs
    end
end

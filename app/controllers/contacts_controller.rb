class ContactsController < ApplicationController
    def index
        @flavors = Flavor.all
    end
end


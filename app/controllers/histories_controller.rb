class HistoriesController < ApplicationController
	respond_to :json  

  def index
  	@histories = History.all
  	respond_with(@histories)
  end
end

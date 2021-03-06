class Admin::EmailsController < Admin::BaseController
  
  resource_controller
  
  before_filter :check_json_authenticity, :only => :index
  before_filter :get_subscribers, :only => [:new, :create, :edit, :update]
  
  index.response do |wants|
    wants.html { render :action => :index }
    wants.json { render :json => json_data }
  end
  destroy.success.wants.js { render_js_for_destroy }


  def deliver
    @email = Email.find(params[:id])
    sent, count = @email.deliver!
    if sent
      flash[:notice] = t('delivery_success', count)
    else
      flash[:error] = t('delivery_failed', count)
    end
    redirect_to admin_email_path(@email)
  end 



  private

  ## Allow different formats of json data to suit different ajax calls
  #def json_data
  #  json_format = params[:json_format] or 'default'
  #  case json_format
  #  when 'basic'
  #    collection.map {|u| {'id' => u.id, 'name' => u.email}}.to_json
  #  else
  #    collection.to_json(:include =>
  #      {:bill_address => {:include => [:state, :country]},
  #      :ship_address => {:include => [:state, :country]}})
  #  end
  #end

  def get_subscribers
   @subscribers = Subscriber.active
  end
  
  def collection
    return @collection if @collection.present?
    unless request.xhr?
      @search = Email.searchlogic(params[:search])

      #set order by to default or form result
      @search.order ||= "ascend_by_name"

      @collection = @search.do_search.paginate(:per_page => Spree::Config[:admin_products_per_page], :page => params[:page])

    else
      @collection = Email.where("wholesalers.name like :search", {:search => "#{params[:q].strip}%"}).limit(params[:limit] || 100)
    end
  end  
end

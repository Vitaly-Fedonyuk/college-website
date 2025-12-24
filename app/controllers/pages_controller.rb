class PagesController < ApplicationController
  def public_info
    @documents = Document.for_category('public_info').ordered
  end
  
  def departments
    @documents = Document.for_category('departments').ordered
  end
  
  def quality_monitoring
    @documents = Document.for_category('quality_monitoring').ordered
  end
end

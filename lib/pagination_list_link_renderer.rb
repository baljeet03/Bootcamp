class PaginationListLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    super.except(:first_label, :last_label)
  end

  protected

  def pagination
    [:first_page, :previous_page, :next_page, :last_page]
  end

  def first_page
    previous_or_next_page(current_page == 1 ? nil : 1, @options[:first_label], "first_page")
  end

  def last_page
    previous_or_next_page(current_page == total_pages ? nil : total_pages, @options[:last_label], "last_page")
  end

end
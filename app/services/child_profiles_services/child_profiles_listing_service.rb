module ChildProfilesServices
  class ChildProfilesListingService < ApplicationService
    def initialize(page, sort_type, sort_order, limit)
      @page = page || 1
      @sort_type = sort_type || Constants::USER_SORTINGS[:All]
      @sort_order = sort_order || Constants::USER_SORTINGS_ORDERS[:DESC]
      @limit = limit || 10
    end

    def call
      if @sort_type == Constants::USER_SORTINGS[:All]
        children = User.children

        case @sort_order
        when Constants::USER_SORTINGS_ORDERS[:ASC]
          children_to_render = children.order('name ASC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.count,
                    limit: @limit },
            include: ['child_profile'],
            status: :ok }
        when Constants::USER_SORTINGS_ORDERS[:DESC]
          children_to_render = children.order('name DESC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.count,
                    limit: @limit },
            include: ['child_profile'],
            status: :ok }
        end
      elsif @sort_type == Constants::USER_FILTERS[:Scored?]
        children = User.children.where.not.accociated(:child_reviews)
        children_to_render = children.order('name DESC').page(@page).per(@limit)
        { json: { children: children_to_render,
                  page: @page,
                  total_pages: children_to_render.total_pages,
                  limit: @limit } }
      end
    end
  end
end

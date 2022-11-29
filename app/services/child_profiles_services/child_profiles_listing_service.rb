module ChildProfilesServices
  class ChildProfilesListingService < ApplicationService
    def initialize(page, sort_type, sort_order, limit)
      @page = page || 1
      @sort_type = sort_type || Constants::USER_SORTINGS[:all]
      @sort_order = sort_order || Constants::USER_SORTINGS_ORDERS[:desc]
      @limit = limit || 10
    end

    def call
      if @sort_type == Constants::USER_SORTINGS[:all]
        children = User.children

        case @sort_order
        when Constants::USER_SORTINGS_ORDERS[:asc]
          children_to_render = children.order('name ASC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.count,
                    limit: @limit },
            include: ['child_profile'],
            status: :ok }
        when Constants::USER_SORTINGS_ORDERS[:desc]
          children_to_render = children.order('name DESC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.count,
                    limit: @limit },
            include: ['child_profile'],
            status: :ok }
        end
      elsif @sort_type == Constants::USER_SORTINGS[:score]
        children = User.select('users.id', 'users.name', 'users.email',
                               'AVG(score)').joins(child_profile: [:child_reviews]).group('users.id')
        case @sort_order
        when Constants::USER_SORTINGS_ORDERS[:asc]
          children_to_render = children.order('AVG(score) ASC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    limit: @limit },
            include: ['child_profile'],
            except: [:avg],
            status: :ok }
        when Constants::USER_SORTINGS_ORDERS[:desc]
          children_to_render = children.order('AVG(score) DESC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    limit: @limit },
            include: ['child_profile'],
            except: [:avg],
            status: :ok }
        end
      elsif @sort_type == Constants::USER_FILTERS[:is_scored]
        children = User.select('users.id, users.name, users.email, users.role').joins(child_profile: [:child_reviews]).group('users.id')
        children_to_render = children.order('name DESC').page(@page).per(@limit)
        { json: { children: children_to_render,
                  page: @page,
                  total_pages: children_to_render.total_pages,
                  limit: @limit },
          include: ['child_profile'],
          status: :ok }
      else
        { json: { message: 'unhandled sorting / filter type', status: :bad_request } }
      end
    end
  end
end

module ChildProfilesServices
  class ChildProfilesListingService < ApplicationService
    def initialize(page, sort_type, filter_type, sort_order, limit)
      @page = page || 1
      @sort_type = sort_type || Constants::USER_SORTINGS[:name]
      @filter_type = filter_type || nil
      @sort_order = sort_order || Constants::USER_SORTINGS_ORDERS[:asc]
      @limit = limit || 10
    end

    def call
      children = User.children.select('users.id',
                                      'users.name',
                                      'users.email',
                                      'users.created_at',
                                      'users.updated_at',
                                      'AVG(score) AS medium_score').joins(child_profile: [:child_reviews]).group('users.id')

      if @sort_type == Constants::USER_SORTINGS[:name]
        case @sort_order
        when Constants::USER_SORTINGS_ORDERS[:asc]
          children_to_render = filter_profiles(children, @filter_type).order('name ASC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.length,
                    limit: @limit },
            except: [:medium_score],
            status: :ok }
        when Constants::USER_SORTINGS_ORDERS[:desc]
          children_to_render = filter_profiles(children, @filter_type).order('name DESC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.length,
                    limit: @limit },
            except: [:medium_score],
            status: :ok }
        end
      elsif @sort_type == Constants::USER_SORTINGS[:score]
        case @sort_order
        when Constants::USER_SORTINGS_ORDERS[:asc]
          children_to_render = filter_profiles(children, @filter_type).order('AVG(score) ASC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.length,
                    limit: @limit },
            except: [:medium_score],
            status: :ok }
        when Constants::USER_SORTINGS_ORDERS[:desc]
          children_to_render = filter_profiles(children, @filter_type).order('AVG(score) DESC').page(@page).per(@limit)
          { json: { children: children_to_render,
                    page: @page,
                    total_pages: children_to_render.total_pages,
                    total_records: children_to_render.length,
                    limit: @limit },
            except: [:medium_score],
            status: :ok }
        end
      else
        { json: { message: 'unhandled sorting type', status: :bad_request } }
      end
    end

    private

    def filter_profiles(profiles, filter_type)
      return profiles if filter_type.nil?

      case filter_type
      when Constants::USER_FILTERS[:scored]
        profiles.where('child_reviews.id IS NOT NULL')
      when Constants::USER_FILTERS[:not_scored]
        profiles.where('child_reviews.id IS NULL')
      end
    end
  end
end

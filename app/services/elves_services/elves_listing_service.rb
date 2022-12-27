module ElvesServices
  class ElvesListingService < ApplicationService
    def initialize(page, sort_type, filter_type, sort_order, limit)
      @page = page || 1
      @sort_type = sort_type || Constants::ELVES_SORTINGS[:name]
      @filter_type = filter_type || nil
      @sort_order = sort_order || Constants::USER_SORTINGS_ORDERS[:asc]
      @limit = limit || 10
    end

    def call
      elves = User.elves.select('users.id',
                                'users.name',
                                'users.email',
                                'users.created_at',
                                'users.updated_at',
                                'users.invitation_sent_at',
                                'COUNT(child_reviews.id) AS reviews_count').joins('LEFT OUTER JOIN child_reviews ON "child_reviews"."user_id" = "users"."id"').group('users.id')

      if @sort_type == Constants::ELVES_SORTINGS[:name]
        sort_by_name(elves)
      elsif @sort_type == Constants::ELVES_SORTINGS[:reviews_count]
        sort_by_reviews_count(elves)
      else
        { json: { message: 'unhandled sorting type', status: :bad_request } }
      end
    end

    private

    def filter_elves(elves, filter_type)
      return elves if filter_type.nil?

      case filter_type
      when Constants::ELVES_FILTERS[:accepted_invitation]
        elves.where.not(invitation_accepted_at: nil)
      when Constants::ELVES_FILTERS[:not_accepted_invitation]
        elves.where.not(invitation_sent_at: nil).where(invitation_accepted_at: nil)
      end
    end

    def sort_by_name(elves)
      filtered_elves = filter_elves(elves, @filter_type)

      return [] if filtered_elves.nil?

      case @sort_order
      when Constants::USER_SORTINGS_ORDERS[:asc]
        elves_to_render = filtered_elves.order('name ASC').page(@page).per(@limit)
      when Constants::USER_SORTINGS_ORDERS[:desc]
        elves_to_render = filtered_elves.order('name DESC').page(@page).per(@limit)
      end
      { json: { elves: elves_to_render,
                page: @page,
                total_pages: elves_to_render.total_pages,
                total_records: elves_to_render.length,
                limit: @limit },
        status: :ok }
    end

    def sort_by_reviews_count(elves)
      case @sort_order
      when Constants::USER_SORTINGS_ORDERS[:asc]
        elves_to_render = filter_elves(elves,
                                       @filter_type).order('COUNT(child_reviews.id) ASC').page(@page).per(@limit)
      when Constants::USER_SORTINGS_ORDERS[:desc]
        elves_to_render = filter_elves(elves,
                                       @filter_type).order('COUNT(child_reviews.id) DESC').page(@page).per(@limit)
      end
      { json: { elves: elves_to_render,
                page: @page,
                total_pages: elves_to_render.total_pages,
                total_records: elves_to_render.length,
                limit: @limit },
        status: :ok }
    end
  end
end

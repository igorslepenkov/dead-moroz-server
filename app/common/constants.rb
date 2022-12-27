module Constants
  USER_ROLES = {
    dead_moroz: 'dead_moroz',
    elf: 'elf',
    child: 'child'
  }.freeze

  USER_SORTINGS = {
    name: 'name',
    reviews: 'reviews',
    score: 'score'
  }.freeze

  ELVES_SORTINGS = {
    name: 'name',
    reviews_count: 'reviews'
  }.freeze

  USER_FILTERS = {
    scored: 'scored',
    not_scored: 'not_scored'
  }.freeze

  ELVES_FILTERS = {
    accepted_invitation: 'accept',
    not_accepted_invitation: 'not_accept'
  }.freeze

  USER_SORTINGS_ORDERS = {
    asc: 'ASC',
    desc: 'DESC'
  }.freeze
end

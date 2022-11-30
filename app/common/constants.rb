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

  USER_FILTERS = {
    scored: 'scored',
    not_scored: 'not_scored'
  }.freeze

  USER_SORTINGS_ORDERS = {
    asc: 'ASC',
    desc: 'DESC'
  }.freeze
end

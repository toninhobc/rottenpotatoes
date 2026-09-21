require "test_helper"

class MovieTest < ActiveSupport::TestCase
  # Teste 1: Garante que um filme sem título seja considerado inválido pelo model
  test "precisa ter título" do
    movie = Movie.new(rating: "PG", release_date: Date.current)
    assert_not movie.valid?
    assert_includes movie.errors[:title], "can't be blank"
  end

  # Teste 2: Garante que classificações fora da nossa Allowlist sejam rejeitadas
  test "aceita classificações conhecidas" do
    movie = Movie.new(title: "Filme", rating: "INVALIDA", release_date: Date.current)
    assert_not movie.valid?
  end
end
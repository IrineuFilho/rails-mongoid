# frozen_string_literal: true

class LocalesController < ApplicationController
  api :GET, '/locales', 'List all locales'
  param :name, String, desc: "Part of locale's name"
  def index
    @locales = ::Queries::LocaleQuery.call params[:name]
    render json: @locales
  end
end

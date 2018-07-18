#!/usr/bin/env ruby

require 'sinatra'

get('/hello') do
  'Hello, web!'
end
